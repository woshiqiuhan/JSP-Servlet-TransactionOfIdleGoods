package com.hznu.servlet.user;

import com.hznu.dao.UserBrowseHistoryDao;
import com.hznu.domain.UserBrowseHistory;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 管理用户收藏夹
 */
public class ManageMyCollectedServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        int flag = Integer.parseInt(req.getParameter("flag"));
        String userId = checkStr(req.getParameter("userId"));
        String goodsId = checkStr(req.getParameter("goodsId"));
        if (userId != null && !userId.isEmpty() &&
                goodsId != null && !goodsId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {
                UserBrowseHistoryDao userBrowseHistoryDao = sqlSession.getMapper(UserBrowseHistoryDao.class);
                // 先删除记录
                userBrowseHistoryDao.deleteUserColleted(userId, goodsId);

                // 添加新纪录
                int n = userBrowseHistoryDao.insertNewUserBrowseHistory(new UserBrowseHistory(userId, goodsId, flag));
                sqlSession.commit();

                System.out.println("插入" + ((n == 1) ? "成功" : "失败"));
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private String checkStr(String str) {
        if (str != null) {
            return str.trim();
        }
        return null;
    }
}