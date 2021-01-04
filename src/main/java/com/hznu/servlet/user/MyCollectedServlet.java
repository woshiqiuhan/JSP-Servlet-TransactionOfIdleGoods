package com.hznu.servlet.user;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.hznu.dao.IdleGoodsDao;
import com.hznu.dao.UserBrowseHistoryDao;
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
 * 获取用户收藏夹
 */
public class MyCollectedServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        int pageNum = Integer.parseInt(req.getParameter("pageNum"));

        try (SqlSession sqlSession = MybatisUtils.getSqlSession();
             PrintWriter out = resp.getWriter()) {
            IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);
            UserBrowseHistoryDao userBrowseHistoryDao = sqlSession.getMapper(UserBrowseHistoryDao.class);
            String userId = req.getParameter("userId");
            if (pageNum == -1) {
                out.print(userBrowseHistoryDao.selectCountCollectByUserId(userId));
                out.flush();
            } else {
                int pageSize = Integer.parseInt(req.getParameter("pageSize"));
                PageHelper.startPage(pageNum, pageSize);
                List<IdleGoods> idleGoods = idleGoodsDao.selectUserCollect(userId);

                idleGoods.forEach(idleGood -> idleGood.setCollected(true));
                out.print(JSON.toJSONString(idleGoods));
                out.flush();
            }
        }
    }
}