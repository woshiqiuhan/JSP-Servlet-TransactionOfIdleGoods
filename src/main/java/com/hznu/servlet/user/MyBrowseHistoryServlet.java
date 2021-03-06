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
 * 获取用户浏览记录
 */
public class MyBrowseHistoryServlet extends HttpServlet {
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
                out.print(userBrowseHistoryDao.selectCountByUserId(userId));
                out.flush();
            } else {
                int pageSize = Integer.parseInt(req.getParameter("pageSize"));
                PageHelper.startPage(pageNum, pageSize);
                List<IdleGoods> idleGoods = idleGoodsDao.selectUserBrowseHistory(userId);

                // 在浏览记录表中查看UserBrowseHistory.status是否为1
                idleGoods.forEach(idleGood -> {
                    if (userBrowseHistoryDao.selectCountById(userId, idleGood.getGoodsId()) == 1) {
                        idleGood.setCollected(userBrowseHistoryDao.selectHistoryStatus(userId, idleGood.getGoodsId()) == 1);
                    }
                });

                out.print(JSON.toJSONString(idleGoods));
                out.flush();
            }
        }
    }
}