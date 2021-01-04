package com.hznu.servlet.user;

import com.alibaba.fastjson.JSON;
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
import java.net.URLEncoder;

public class GetUserInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain;charset=utf-8");//设置相应类型为html,编码为utf-8

        String userloginid = req.getParameter("userloginid").trim();
        if (userloginid != null && !userloginid.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                UserDao userDao = sqlSession.getMapper(UserDao.class);

                User user = userDao.selectUserInfo(userloginid);

                if (user != null) {
                    HttpSession session = req.getSession();
                    session.setAttribute("user", user);

                    out.print(URLEncoder.encode(JSON.toJSONString(user), "UTF-8"));
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