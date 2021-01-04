package com.hznu.domain;

import java.sql.Timestamp;
import java.util.Date;

public class UserBrowseHistory {
    public String browseId;
    public String userId;
    public String goodsId;

    @Override
    public String toString() {
        return "UserBrowseHistory{" +
                "browseId='" + browseId + '\'' +
                ", userId='" + userId + '\'' +
                ", goodsId='" + goodsId + '\'' +
                ", browseTime=" + browseTime +
                ", status=" + status +
                '}';
    }

    public Timestamp browseTime;
    public Integer status;

    public UserBrowseHistory() {
    }

    public String getBrowseId() {
        return browseId;
    }

    public void setBrowseId(String browseId) {
        this.browseId = browseId;
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

    public Timestamp getBrowseTime() {
        return browseTime;
    }

    public void setBrowseTime(Timestamp browseTime) {
        this.browseTime = browseTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public UserBrowseHistory(String userId, String goodsId, Integer status) {
        this.browseId = createUserBrowseHistoryId();
        this.userId = userId;
        this.goodsId = goodsId;
        this.status = status;
    }

    private String createUserBrowseHistoryId() {
        return "ubs_" + (new Date()).getTime();
    }
}
