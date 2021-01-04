package com.hznu.servlet.user;

import com.alibaba.fastjson.JSON;
import com.hznu.dao.UserBrowseHistoryDao;
import com.hznu.dao.UserDeliveryInformationDao;
import com.hznu.domain.UserBrowseHistory;
import com.hznu.domain.UserDeliveryInformation;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class AddUserDeliveryInformationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String userId = checkStr(req.getParameter("userId"));
        String receiveName = checkStr(req.getParameter("receiveName"));
        String receiveContact = checkStr(req.getParameter("receiveContact"));
        String receiveDetailAddress = checkStr(req.getParameter("receiveDetailAddress"));
        if (userId != null && !userId.isEmpty() &&
                receiveName != null && !receiveName.isEmpty() &&
                receiveContact != null && !receiveContact.isEmpty() &&
                receiveDetailAddress != null && !receiveDetailAddress.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                UserDeliveryInformationDao userDeliveryInformationDao = sqlSession.getMapper(UserDeliveryInformationDao.class);
                UserDeliveryInformation userDeliveryInformation = new UserDeliveryInformation(userId, receiveName, receiveContact, receiveDetailAddress);
                int n = userDeliveryInformationDao.insertIntoDeliveryInformation(userDeliveryInformation);
                sqlSession.commit();
                System.out.println("插入" + ((n == 1) ? "成功" : "失败"));
                if (n == 1) {
                    /**
                     * 用标记返回代表注册状态：
                     * 1： 注册成功
                     * 2： 插入失败，原因为登录id已存在
                     */
                    out.print(JSON.toJSONString(userDeliveryInformation.getDeliveryInfoId()));
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