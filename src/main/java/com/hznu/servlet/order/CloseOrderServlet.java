package com.hznu.servlet.order;

import com.hznu.dao.IdleGoodsDao;
import com.hznu.dao.OrdersDao;
import com.hznu.domain.Orders;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class CloseOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String goodsId = checkStr(req.getParameter("goodsId"));
        String orderId = checkStr(req.getParameter("orderId"));

        if (goodsId != null && !goodsId.isEmpty() &&
                orderId != null && !orderId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);

                // 将商品状态更改为4，即用户取消订单但为提醒用户
                int n = idleGoodsDao.updateIdleGoodsStatus(4, goodsId);

                if (n == 1) {
                    // 更新订单信息
                    OrdersDao ordersDao = sqlSession.getMapper(OrdersDao.class);
                    int m = ordersDao.updateOrdersStatusTo(orderId, 0);
                    if (m == 1) { // 订单支付成功
                        // 提交事务
                        sqlSession.commit();
                        out.print(1); // 表示订单关闭成功
                    } else {  // 订单创建失败
                        out.print(2); // 表示订单关闭失败
                    }
                } else {
                    out.print(2); // 表示订单关闭失败
                }
                out.flush();
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