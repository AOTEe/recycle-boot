package com.recycle.bean;

public class User {
    private Integer userId;//用户ID
    private String openId;
    private String nickName;//昵称
    private String wxPicture;//微信头像
    private Integer gender;//1 男  0女
    private String mobile;//手机号
    private String moneyCode;//微信收款码的Url
    private Double restMoney;//余额

    public User(Integer userId, String openId, String nickName, String wxPicture, Integer gender, String mobile, String moneyCode, Double restMoney) {
        this.userId = userId;
        this.openId = openId;
        this.nickName = nickName;
        this.wxPicture = wxPicture;
        this.gender = gender;
        this.mobile = mobile;
        this.moneyCode = moneyCode;
        this.restMoney = restMoney;
    }

    public User() {
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getWxPicture() {
        return wxPicture;
    }

    public void setWxPicture(String wxPicture) {
        this.wxPicture = wxPicture;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getMoneyCode() {
        return moneyCode;
    }

    public void setMoneyCode(String moneyCode) {
        this.moneyCode = moneyCode;
    }

    public Double getRestMoney() {
        return restMoney;
    }

    public void setRestMoney(Double restMoney) {
        this.restMoney = restMoney;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", openId='" + openId + '\'' +
                ", nickName='" + nickName + '\'' +
                ", wxPicture='" + wxPicture + '\'' +
                ", gender=" + gender +
                ", mobile='" + mobile + '\'' +
                ", moneyCode='" + moneyCode + '\'' +
                ", restMoney=" + restMoney +
                '}';
    }
}
