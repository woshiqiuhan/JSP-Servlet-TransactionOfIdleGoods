package com.hznu.servlet.user;

import com.alibaba.fastjson.JSON;
import com.hznu.dao.IdleGoodsDao;
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

/**
 * 查看用户发布的闲置品状态
 * 若已卖出且未提醒用户，则提醒用户且更新状态
 */
public class MyIdleGoodsStatusServlet extends HttpServlet {
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

                List<IdleGoods> idleGoods = idleGoodsDao.selectIdleGoodsSold(userId);
                // 将每个闲置品状态更新至3
                idleGoods.forEach(idleGood -> idleGoodsDao.updateIdleGoodsStatus(3, idleGood.getGoodsId()));

                sqlSession.commit();
                out.print(JSON.toJSONString(idleGoods));
                out.flush();
            }
        }
    }
}