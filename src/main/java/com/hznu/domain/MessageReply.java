package com.hznu.domain;

import java.sql.Timestamp;
import java.util.Date;

/**
 * 留言回复实体
 */
public class MessageReply {
    private String replyId;
    private String messageId;  // 在哪条评论下的回复
    private String userId;  // 谁回复
    private Integer replyOrder;  // 根据回复时间排序
    private Timestamp replyDate; // 回复日期
    private String replyDetail;  // 回复详情
    private Integer replyStatus;  // 恢复状态
    private String userName;  // 评论者昵称

    @Override
    public String toString() {
        return "MessageReply{" +
                "replyId='" + replyId + '\'' +
                ", messageId='" + messageId + '\'' +
                ", userId='" + userId + '\'' +
                ", replyOrder=" + replyOrder +
                ", replyDate=" + replyDate +
                ", replyDetail='" + replyDetail + '\'' +
                ", replyStatus=" + replyStatus +
                ", userName='" + userName + '\'' +
                '}';
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public MessageReply(String messageId, String userId, String replyDetail, Integer replyStatus) {
        this.replyId = createReplyId();
        this.messageId = messageId;
        this.userId = userId;
        this.replyDetail = replyDetail;
        this.replyStatus = replyStatus;
    }

    private String createReplyId() {
        return "mr_" + (new Date()).getTime();
    }

    public MessageReply() {
    }

    public String getReplyId() {
        return replyId;
    }

    public void setReplyId(String replyId) {
        this.replyId = replyId;
    }

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getReplyOrder() {
        return replyOrder;
    }

    public void setReplyOrder(Integer replyOrder) {
        this.replyOrder = replyOrder;
    }

    public Timestamp getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Timestamp replyDate) {
        this.replyDate = replyDate;
    }

    public String getReplyDetail() {
        return replyDetail;
    }

    public void setReplyDetail(String replyDetail) {
        this.replyDetail = replyDetail;
    }

    public Integer getReplyStatus() {
        return replyStatus;
    }

    public void setReplyStatus(Integer replyStatus) {
        this.replyStatus = replyStatus;
    }
}
