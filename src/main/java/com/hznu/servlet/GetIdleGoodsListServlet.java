package com.hznu.servlet;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.hznu.dao.IdleGoodsDao;
import com.hznu.dao.UserBrowseHistoryDao;
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

public class GetIdleGoodsListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        int pageNum = Integer.parseInt(req.getParameter("pageNum"));
        int flag = Integer.parseInt(req.getParameter("flag"));

        try (SqlSession sqlSession = MybatisUtils.getSqlSession();
             PrintWriter out = resp.getWriter()) {
            IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);
            String userId = req.getParameter("userId");
            if (pageNum == -1) {
                int n;
                if (userId == null) {
                    if (flag == 0) {
                        n = idleGoodsDao.selectSizeOfIdleGoods();
                    } else { // 进行模糊查询
                        String words = req.getParameter("words").trim();
                        StringBuilder fuzzyWords = new StringBuilder("%");
                        for (int i = 0; i < words.length(); i++) {
                            fuzzyWords.append(words.charAt(i)).append("%");
                        }
                        n = idleGoodsDao.selectSizeOfIdleGoodsFuzzy(fuzzyWords.toString());
                    }
                } else { // 查询某个用户发布的闲置品
                    n = idleGoodsDao.selectSizeOfIdleGoodsByUserId(userId);
                }
                out.print(n);
                out.flush();
            } else {
                int pageSize = Integer.parseInt(req.getParameter("pageSize"));
                PageHelper.startPage(pageNum, pageSize);
                List<IdleGoods> idleGoods = null;
                if (flag == 0) { //查询所有闲置品
                    idleGoods = idleGoodsDao.selectIdleGoodsInfo();
                } else if (flag == 1) { //查找某人发布的闲置品
                    idleGoods = idleGoodsDao.selectIdleGoodsInfoByUserId(req.getParameter("userId"));
                } else if (flag == 2) { //模糊查询
                    String words = req.getParameter("words").trim();
                    StringBuilder fuzzyWords = new StringBuilder("%");
                    for (int i = 0; i < words.length(); i++) {
                        fuzzyWords.append(words.charAt(i)).append("%");
                    }
                    idleGoods = idleGoodsDao.selectIdleGoodsFuzzy(fuzzyWords.toString());
                }

                if (userId != null) {  //在用户登录的情况下，对闲置品进行分类，标记收藏和非收藏
                    UserBrowseHistoryDao userBrowseHistoryDao = sqlSession.getMapper(UserBrowseHistoryDao.class);
                    // 在浏览记录表中查看UserBrowseHistory.status是否为1
                    idleGoods.forEach(idleGood -> {
                        if (userBrowseHistoryDao.selectCountById(userId, idleGood.getGoodsId()) == 1) {
                            idleGood.setCollected(userBrowseHistoryDao.selectHistoryStatus(userId, idleGood.getGoodsId()) == 1);
                        }
                    });
                }

                out.print(JSON.toJSONString(idleGoods));
                out.flush();
            }
        }
    }
}
