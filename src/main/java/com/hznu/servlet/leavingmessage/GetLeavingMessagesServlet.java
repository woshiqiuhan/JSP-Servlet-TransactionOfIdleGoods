package com.hznu.servlet.leavingmessage;

import com.alibaba.fastjson.JSON;
import com.hznu.dao.MessageBoardDao;
import com.hznu.domain.MessageBoard;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class GetLeavingMessagesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String goodsId = checkStr(req.getParameter("goodsId"));

        if (goodsId != null && !goodsId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                MessageBoardDao messageBoardDao = sqlSession.getMapper(MessageBoardDao.class);
                List<MessageBoard> messageBoards = messageBoardDao.selectByGoodsId(goodsId);

                out.print(JSON.toJSONString(messageBoards));
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