package com.hznu.servlet.android;

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
import java.net.URLEncoder;
import java.util.List;

public class GetMyCollectedListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String userId = checkStr(req.getParameter("userId"));

        try (SqlSession sqlSession = MybatisUtils.getSqlSession();
             PrintWriter out = resp.getWriter()) {
            IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);
            List<IdleGoods> idleGoods = idleGoodsDao.selectUserCollect(userId);
            
            out.print(URLEncoder.encode(JSON.toJSONString(idleGoods), "UTF-8"));
            out.flush();
        }
    }

    private String checkStr(String str) {
        if (str != null) {
            return str.trim();
        }
        return null;
    }
}