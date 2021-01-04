package com.hznu.servlet.user;

import com.alibaba.fastjson.JSON;
import com.hznu.dao.IdleGoodsDao;
import com.hznu.domain.IdleGoods;
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
 * 查找用户被取消订单的闲置品
 * 并将闲置品状态重置为出售中
 */
public class GetIdleGoodsOrdersCancelServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String userId = req.getParameter("userId").trim();

        if (userId != null && !userId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);

                List<IdleGoods> idleGoods = idleGoodsDao.selectIdleGoodsOrdersCancel(userId);
                // 将每个闲置品状态更新至1，即出售中
                idleGoods.forEach(idleGood -> idleGoodsDao.updateIdleGoodsStatus(1, idleGood.getGoodsId()));

                sqlSession.commit();
                out.print(JSON.toJSONString(idleGoods));
                out.flush();
            }
        }
    }
}