package com.hznu.servlet.leavingmessage;

import com.hznu.dao.IdleGoodsDao;
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

/**
 * 发布新评论
 */
public class AddNewLeavingMessageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String goodsId = checkStr(req.getParameter("goodsId"));
        String userId = checkStr(req.getParameter("userId"));
        String messageDetail = checkStr(req.getParameter("messageDetail"));

        if (goodsId != null && !goodsId.isEmpty() &&
                userId != null && !userId.isEmpty() &&
                messageDetail != null && !messageDetail.isEmpty()) {
            MessageBoard messageBoard = new MessageBoard(userId, goodsId, messageDetail, 1);
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {
                MessageBoardDao messageBoardDao = sqlSession.getMapper(MessageBoardDao.class);
                int n = messageBoardDao.insertNewMessageToBoard(messageBoard);

                sqlSession.commit();
                System.out.println("插入" + ((n == 1) ? "成功" : "失败"));
                if (n == 1) {
                    /**
                     * 用标记返回代表插入状态状态：
                     * 1： 注册成功
                     * 2： 插入失败
                     */
                    out.print(1);
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