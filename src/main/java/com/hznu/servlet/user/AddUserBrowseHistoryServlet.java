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
 * 添加用户浏览记录
 */
public class AddUserBrowseHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String userId = checkStr(req.getParameter("userId"));
        String goodsId = checkStr(req.getParameter("goodsId"));
        if (userId != null && !userId.isEmpty() &&
                goodsId != null && !goodsId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {
                UserBrowseHistoryDao userBrowseHistoryDao = sqlSession.getMapper(UserBrowseHistoryDao.class);

                if (userBrowseHistoryDao.selectCountById(userId, goodsId) == 0) {
                    // 当前用户从未浏览过当前闲置品
                    int n = userBrowseHistoryDao.insertNewUserBrowseHistory(new UserBrowseHistory(userId, goodsId, 0));
                    sqlSession.commit();

                    System.out.println("插入" + ((n == 1) ? "成功" : "失败"));
                } else {
                    // 若浏览过则更新时间即可
                    int n = userBrowseHistoryDao.updateBrowseTime(userId, goodsId);
                    sqlSession.commit();
                    System.out.println("更新" + ((n == 1) ? "成功" : "失败"));
                }
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
