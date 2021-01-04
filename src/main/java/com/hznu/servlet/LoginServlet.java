package com.hznu.servlet;

import com.hznu.dao.UserDao;
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

public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain;charset=utf-8");//设置相应类型为html,编码为utf-8


        String userloginid = req.getParameter("userloginid").trim();
        String userpassword = req.getParameter("userpassword").trim();

        if (userloginid != null && !userloginid.isEmpty() &&
                userpassword != null && !userpassword.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                UserDao userDao = sqlSession.getMapper(UserDao.class);

                int n = userDao.selectCountByIdAndPwd(userloginid, userpassword);

                System.out.println("核对" + ((n == 1) ? "成功" : "失败"));
                if (n == 1) {
                    /**
                     * 用标记返回代表注册状态：
                     * 1： 账号密码核对成功
                     * 2： 账号或密码错误
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
}

