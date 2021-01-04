package com.hznu.servlet.user;

import com.alibaba.fastjson.JSON;
import com.hznu.dao.IdleGoodsDao;
import com.hznu.dao.MessageBoardDao;
import com.hznu.domain.IdleGoods;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class GetIdleGoodsRatedServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String userId = req.getParameter("userId").trim();

        if (userId != null && !userId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);

                List<IdleGoods> idleGoods = idleGoodsDao.selectIdleGoodsRated(userId);

                MessageBoardDao messageBoardDao = sqlSession.getMapper(MessageBoardDao.class);
                // 并将将每个闲置品该关于该用户的闲置品评价状态更新
                idleGoods.forEach(idleGood -> messageBoardDao.updateStatusAfterRemindUser(idleGood.getGoodsId()));

                sqlSession.commit();
                out.print(JSON.toJSONString(idleGoods));
                out.flush();
            }
        }
    }
}