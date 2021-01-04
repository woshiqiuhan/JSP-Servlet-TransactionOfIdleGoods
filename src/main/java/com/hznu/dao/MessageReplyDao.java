package com.hznu.dao;

import com.hznu.domain.MessageReply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MessageReplyDao {

    List<MessageReply> selectAllFromMessageReply();

    List<MessageReply> selectReplyByMessageId(@Param("messageId") String messageId);

    int insertNewMessageReply(MessageReply messageReply);
}
