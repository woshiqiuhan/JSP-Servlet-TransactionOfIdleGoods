package com.hznu.servlet.releaseidle;

import com.hznu.dao.IdleGoodsDao;
import com.hznu.domain.IdleGoods;
import com.hznu.domain.User;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 发布闲置品
 */
public class ReleaseIdleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String ideaTitle = checkStr(req.getParameter("ideaTitle"));
        String type = checkStr(req.getParameter("type"));
        String ideaIntroduce = checkStr(req.getParameter("ideaIntroduce"));
        String ideaPrice = checkStr(req.getParameter("ideaPrice"));
        String ideaTips = checkStr(req.getParameter("ideaTips"));
        String ideaProvince = checkStr(req.getParameter("ideaProvince"));

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (ideaTitle != null && !ideaTitle.isEmpty()) {
            IdleGoods idleGoods = new IdleGoods(user.getUserId(), type, ideaTips, ideaTitle, ideaIntroduce, Double.parseDouble(ideaPrice), 1, ideaProvince);
//            System.out.println(idleGoods);
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);
                int n = idleGoodsDao.insertNewIdleGoods(idleGoods);
                sqlSession.commit();

                System.out.println("插入" + ((n == 1) ? "成功" : "失败"));
                if (n == 1) {
                    /**
                     * 用标记返回代表插入状态状态：
                     * 1： 注册成功
                     * 2： 插入失败，原因为登录id已存在
                     */
                    out.print(1);
                } else {
                    out.print(2);
                }
                out.flush();
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
