package com.hznu.servlet.user;

import com.alibaba.fastjson.JSON;
import com.hznu.dao.UserDeliveryInformationDao;
import com.hznu.domain.UserDeliveryInformation;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class GetUserDeliveryInformationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String userId = req.getParameter("userId");
        if (userId != null && !userId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                UserDeliveryInformationDao userDeliveryInformationDao = sqlSession.getMapper(UserDeliveryInformationDao.class);

                List<UserDeliveryInformation> userDeliveryInformations = userDeliveryInformationDao.selectFromDeliveryInformationByUserId(userId);
                out.print(JSON.toJSONString(userDeliveryInformations));
                out.flush();
            }
        }
    }
}