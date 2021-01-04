package com.hznu.servlet;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
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

public class GetIdleGoodsByIdServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String goodsId = req.getParameter("goodsId");
        if (goodsId != null && !goodsId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);

                IdleGoods idleGoods = idleGoodsDao.selectIdleGoodsInfoById(goodsId);

                out.print(JSON.toJSONString(idleGoods));
                out.flush();
            }
        }
    }
}