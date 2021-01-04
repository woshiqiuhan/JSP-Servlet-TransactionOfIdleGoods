package com.hznu.servlet.order;

import com.hznu.dao.OrdersDao;
import com.hznu.dao.UserDao;
import com.hznu.domain.Orders;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 订单支付
 */
public class SubmitNewOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String passwd = checkStr(req.getParameter("passwd"));
        String goodsId = checkStr(req.getParameter("goodsId"));
        String userId = checkStr(req.getParameter("userId"));
        String orderId = checkStr(req.getParameter("orderId"));
        Double goodsPrice = Double.parseDouble(checkStr(req.getParameter("goodsPrice")));

        System.out.println(goodsPrice);
        if (passwd != null && !passwd.isEmpty() &&
                userId != null && !userId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                // 首先找出对应的orderid
                OrdersDao ordersDao = sqlSession.getMapper(OrdersDao.class);
                Orders orders = ordersDao.selectordersById(orderId);
                if (orders != null) { // 订单存在才可修改状态
                    UserDao userDao = sqlSession.getMapper(UserDao.class);
                    int n = userDao.selectCountByUserIdAndPwd(userId, passwd);
                    System.out.println("n:" + n);
                    if (n == 1) {  //密码核对成功
                        // 修改订单状态
                        int m = ordersDao.updateOrdersStatus(40, orders.getOrderId(), goodsPrice);
                        if (m > 0) { // 订单支付成功
                            // 提交事务
                            System.out.println("m:" + m);
                            sqlSession.commit();
                            out.print(40);
                        } else {  // 支付失败
                            out.print(90);
                        }
                    } else { // 密码错误
                        out.print(100);
                    }
                    out.flush();
                }
            }
        }
    }

    private String checkStr(String str) {
        if (str != null) {
            return str.trim();
        }
        return null;
    }
}