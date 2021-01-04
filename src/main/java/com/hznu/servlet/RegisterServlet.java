package com.hznu.servlet;

import com.hznu.dao.UserDao;
import com.hznu.domain.User;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

//@WebServlet(name = "registerServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String userloginid = req.getParameter("userloginid").trim();
        String username = req.getParameter("username").trim();
        String userpassword = req.getParameter("userpassword").trim();
        String useremail = req.getParameter("useremail");
        String usephonenumber = req.getParameter("usephonenumber").trim();

        if (userloginid != null && !userloginid.isEmpty() &&
                username != null && !username.isEmpty() &&
                userpassword != null && !userpassword.isEmpty() &&
                useremail != null && !useremail.isEmpty() &&
                usephonenumber != null && !usephonenumber.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                UserDao userDao = sqlSession.getMapper(UserDao.class);

                if (userDao.selectCountById(userloginid) == 0) {
                    int n = userDao.insertNewUser(
                            new User(userloginid, 0, username, userpassword, usephonenumber, useremail, 1));
                    sqlSession.commit();

                    System.out.println("插入" + ((n == 1) ? "成功" : "失败"));
                    if (n == 1) {
                        /**
                         * 用标记返回代表注册状态：
                         * 1： 注册成功
                         * 2： 插入失败，原因为登录id已存在
                         */
                        out.print(1);
                        /**
                         * out.println(true);
                         * 坑：用println的话传回去的数据带回车，一般判等会出问题
                         */
                    } else {
                        out.print(2);
                    }
                    out.flush();
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
