package com.hznu.servlet.leavingmessage;

import com.alibaba.fastjson.JSON;
import com.hznu.dao.MessageBoardDao;
import com.hznu.dao.MessageReplyDao;
import com.hznu.domain.MessageBoard;
import com.hznu.domain.MessageReply;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class GetMessageReplyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String messageId = checkStr(req.getParameter("messageId"));

        if (messageId != null && !messageId.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession();
                 PrintWriter out = resp.getWriter()) {

                MessageReplyDao messageReplyDao = sqlSession.getMapper(MessageReplyDao.class);
                List<MessageReply> messageReplies = messageReplyDao.selectReplyByMessageId(messageId);

                System.out.println(JSON.toJSONString(messageReplies));
                out.print(JSON.toJSONString(messageReplies));
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