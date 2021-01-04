package com.hznu.domain;

import java.sql.Timestamp;
import java.util.Date;

/**
 * 留言板实体
 */
public class MessageBoard {
    private String messageId;
    private String userId;  // 评论发起者
    private String userName;  // 评论者昵称

    @Override
    public String toString() {
        return "MessageBoard{" +
                "messageId='" + messageId + '\'' +
                ", userId='" + userId + '\'' +
                ", userName='" + userName + '\'' +
                ", goodsId='" + goodsId + '\'' +
                ", leavingDate=" + leavingDate +
                ", replyNum=" + replyNum +
                ", messageDetail='" + messageDetail + '\'' +
                ", messageStatus=" + messageStatus +
                '}';
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    private String goodsId;  // 属于哪件闲置品的评论
    private Timestamp leavingDate;  // 留言日期
    private Integer replyNum;  //  回复数量
    private String messageDetail;  // 留言详情
    /**
     * 0——代表留言已删除
     * 1——代表留言存在，但未提醒过卖家此留言被发布
     * 2——代表留言存在，已提醒过卖家此留言被发布
     */
    private Integer messageStatus;  // 留言状态，存在或已删除

    public MessageBoard(String userId, String goodsId, String messageDetail, Integer messageStatus) {
        this.messageId = createMessageId();
        this.userId = userId;
        this.goodsId = goodsId;
        this.messageDetail = messageDetail;
        this.messageStatus = messageStatus;
    }

    public MessageBoard() {
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

    public String getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(String goodsId) {
        this.goodsId = goodsId;
    }

    public Timestamp getLeavingDate() {
        return leavingDate;
    }

    public void setLeavingDate(Timestamp leavingDate) {
        this.leavingDate = leavingDate;
    }

    public Integer getReplyNum() {
        return replyNum;
    }

    public void setReplyNum(Integer replyNum) {
        this.replyNum = replyNum;
    }

    public String getMessageDetail() {
        return messageDetail;
    }

    public void setMessageDetail(String messageDetail) {
        this.messageDetail = messageDetail;
    }

    public Integer getMessageStatus() {
        return messageStatus;
    }

    public void setMessageStatus(Integer messageStatus) {
        this.messageStatus = messageStatus;
    }

    private String createMessageId() {
        return "mb_" + (new Date()).getTime();
    }
}
