package com.recycle.bean;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;
import java.util.List;

public class Order {
    private Integer orderId; //订单Id
    private User user;      //用户对象
    private Carrier carrier;//收货员对象
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date orderTime;//下单时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date assignTime;//接单时间
    private Double totalPrice;
    private int state;//订单状态 0：未接单 1：已接单 2：已完成 3：已取消    4:待评价(待定)
    private String sellerName;//下单人的名字
    private String sellerMobile;//下单人电话
    private String address;//收货地址
    private Double lng;//经度
    private Double lat;//纬度
    private Integer star; //星级评价
    private String comment; //评价
    private Double weight;//订单称重
    private String confirmImg;//确认时拍照
    private List<OrderItem> orderItems;//订单列表

    public Order() {
    }

    public Order(Integer orderId, User user, Carrier carrier, Date orderTime, Date assignTime, Double totalPrice, int state, String sellerName, String sellerMobile, String address, Double lng, Double lat, Integer star, String comment, Double weight, String confirmImg, List<OrderItem> orderItems) {
        this.orderId = orderId;
        this.user = user;
        this.carrier = carrier;
        this.orderTime = orderTime;
        this.assignTime = assignTime;
        this.totalPrice = totalPrice;
        this.state = state;
        this.sellerName = sellerName;
        this.sellerMobile = sellerMobile;
        this.address = address;
        this.lng = lng;
        this.lat = lat;
        this.star = star;
        this.comment = comment;
        this.weight = weight;
        this.confirmImg = confirmImg;
        this.orderItems = orderItems;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Carrier getCarrier() {
        return carrier;
    }

    public void setCarrier(Carrier carrier) {
        this.carrier = carrier;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Date getAssignTime() {
        return assignTime;
    }

    public void setAssignTime(Date assignTime) {
        this.assignTime = assignTime;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    public String getSellerMobile() {
        return sellerMobile;
    }

    public void setSellerMobile(String sellerMobile) {
        this.sellerMobile = sellerMobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Double getLng() {
        return lng;
    }

    public void setLng(Double lng) {
        this.lng = lng;
    }

    public Double getLat() {
        return lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    public Integer getStar() {
        return star;
    }

    public void setStar(Integer star) {
        this.star = star;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public String getConfirmImg() {
        return confirmImg;
    }

    public void setConfirmImg(String confirmImg) {
        this.confirmImg = confirmImg;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", user=" + user +
                ", carrier=" + carrier +
                ", orderTime=" + orderTime +
                ", assignTime=" + assignTime +
                ", totalPrice=" + totalPrice +
                ", state=" + state +
                ", sellerName='" + sellerName + '\'' +
                ", sellerMobile='" + sellerMobile + '\'' +
                ", address='" + address + '\'' +
                ", lng=" + lng +
                ", lat=" + lat +
                ", star=" + star +
                ", comment='" + comment + '\'' +
                ", weight=" + weight +
                ", confirmImg='" + confirmImg + '\'' +
                ", orderItems=" + orderItems +
                '}';
    }
}
