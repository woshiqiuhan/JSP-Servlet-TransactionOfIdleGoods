package com.hznu.servlet.user;

import com.alibaba.fastjson.JSON;
import com.hznu.dao.IdleGoodsDao;
import com.hznu.dao.OrdersDao;
import com.hznu.dao.UserDeliveryInformationDao;
import com.hznu.domain.IdleGoods;
import com.hznu.domain.Orders;
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

/**
 * 查看自己发布的闲置品状态
 */
public class MyIdleGoodsStatusDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String flag = req.getParameter("flag").trim();


        if (flag != null && !flag.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                if (flag.equals("1")) {
                    String goodsId = req.getParameter("goodsId").trim();
                    OrdersDao ordersDao = sqlSession.getMapper(OrdersDao.class);
                    Orders orders = ordersDao.selectordersByGoodsId(goodsId);
                    out.print(JSON.toJSONString(orders));
                    out.flush();
                } else if (flag.equals("2")) {
                    String deliveryInfoId = req.getParameter("deliveryInfoId").trim();
                    UserDeliveryInformationDao userDeliveryInformationDao = sqlSession.getMapper(UserDeliveryInformationDao.class);
                    UserDeliveryInformation userDeliveryInformation = userDeliveryInformationDao.selectDeliveryInformationById(deliveryInfoId);
                    out.print(JSON.toJSONString(userDeliveryInformation));
                    out.flush();
                }
            }
        }
    }
}