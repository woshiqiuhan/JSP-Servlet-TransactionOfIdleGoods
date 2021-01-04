package com.hznu.domain;

import java.sql.Timestamp;
import java.util.Date;

public class Orders {
    private String orderId;
    private String userId;
    private String goodsId;
    private String deliveryInfoId;
    /**
     * 0——订单关闭(用户主动取消订单)
     * 10——订单关闭(超时未支付)
     * 20——订单关闭(退货并买家退款成功)
     * 30——订单创建但未支付
     * 40——已支付但未收到物品
     * 50——收到货物但未确认收货
     * 60——订单完成(确认收货)
     * 70——退货(卖家同意退货)
     * 80——订单创建失败
     * 90——支付失败
     * 100——支付密码错误
     * 400——表示该商品已被别人拍走或已下架
     * 待完善
     */
    private Integer orderStatus;
    private Timestamp orderCreateTime;
    private Timestamp orderCloseTime;
    private Double paymentAmount;
    private Timestamp paymentTime;

    @Override
    public String toString() {
        return "Orders{" +
                "orderId='" + orderId + '\'' +
                ", userId='" + userId + '\'' +
                ", goodsId='" + goodsId + '\'' +
                ", deliveryInfoId='" + deliveryInfoId + '\'' +
                ", orderStatus=" + orderStatus +
                ", orderCreateTime=" + orderCreateTime +
                ", orderCloseTime=" + orderCloseTime +
                ", paymentAmount=" + paymentAmount +
                ", paymentTime=" + paymentTime +
                '}';
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
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

    public String getDeliveryInfoId() {
        return deliveryInfoId;
    }

    public void setDeliveryInfoId(String deliveryInfoId) {
        this.deliveryInfoId = deliveryInfoId;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Timestamp getOrderCreateTime() {
        return orderCreateTime;
    }

    public void setOrderCreateTime(Timestamp orderCreateTime) {
        this.orderCreateTime = orderCreateTime;
    }

    public Timestamp getOrderCloseTime() {
        return orderCloseTime;
    }

    public void setOrderCloseTime(Timestamp orderCloseTime) {
        this.orderCloseTime = orderCloseTime;
    }

    public Double getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(Double paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public Timestamp getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Timestamp paymentTime) {
        this.paymentTime = paymentTime;
    }

    public Orders() {
    }

    private String createOrderId() {
        return "od_" + (new Date()).getTime();
    }

    public Orders(String userId, String goodsId, String deliveryInfoId, Integer orderStatus) {
        this.orderId = createOrderId();
        this.userId = userId;
        this.goodsId = goodsId;
        this.deliveryInfoId = deliveryInfoId;
        this.orderStatus = orderStatus;
    }
}
