package com.hznu.domain;

import java.util.Date;

public class UserDeliveryInformation {
    private String deliveryInfoId;

    @Override
    public String toString() {
        return "UserDeliveryInformation{" +
                "deliveryInfoId='" + deliveryInfoId + '\'' +
                ", userId='" + userId + '\'' +
                ", receiveName='" + receiveName + '\'' +
                ", receiveContact='" + receiveContact + '\'' +
                ", receiveDetailAddress='" + receiveDetailAddress + '\'' +
                '}';
    }

    private String userId;
    private String receiveName;
    private String receiveContact;
    private String receiveDetailAddress;

    public UserDeliveryInformation(String userId, String receiveName, String receiveContact, String receiveDetailAddress) {
        this.deliveryInfoId = createDeliveryInfoId();
        this.userId = userId;
        this.receiveName = receiveName;
        this.receiveContact = receiveContact;
        this.receiveDetailAddress = receiveDetailAddress;
    }

    public UserDeliveryInformation() {
    }

    public String getDeliveryInfoId() {
        return deliveryInfoId;
    }

    public void setDeliveryInfoId(String deliveryInfoId) {
        this.deliveryInfoId = deliveryInfoId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getReceiveName() {
        return receiveName;
    }

    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
    }

    public String getReceiveContact() {
        return receiveContact;
    }

    public void setReceiveContact(String receiveContact) {
        this.receiveContact = receiveContact;
    }

    public String getReceiveDetailAddress() {
        return receiveDetailAddress;
    }

    public void setReceiveDetailAddress(String receiveDetailAddress) {
        this.receiveDetailAddress = receiveDetailAddress;
    }

    private String createDeliveryInfoId() {
        return "di_" + (new Date()).getTime();
    }
}
