package com.hznu.servlet.order;

import com.hznu.dao.IdleGoodsDao;
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
 * 创建订单，订单处于未支付状态
 */
public class CreateOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String goodsId = checkStr(req.getParameter("goodsId"));
        String userId = checkStr(req.getParameter("userId"));
        String deliveryInfoId = checkStr(req.getParameter("deliveryInfoId"));
        if (goodsId != null && !goodsId.isEmpty() &&
                userId != null && !userId.isEmpty() &&
                deliveryInfoId != null && !deliveryInfoId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);

                // 将商品状态更改为2，即已售出
                int n = idleGoodsDao.updateIdleGoodsStatus(2, goodsId);

                if (n == 1) {
                    // 最终插入订单信息
                    OrdersDao ordersDao = sqlSession.getMapper(OrdersDao.class);
                    Orders orders = new Orders(userId, goodsId, deliveryInfoId, 30);
                    int m = ordersDao.insertIntoNewOrder(orders);
                    if (m == 1) { // 订单支付成功
                        // 提交事务
                        sqlSession.commit();
                        out.print(orders.getOrderId());
                    } else {  // 订单创建失败
                        out.print(80);
                    }
                } else {
                    out.print(400); // 表示该商品已被别人拍走或已下架
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