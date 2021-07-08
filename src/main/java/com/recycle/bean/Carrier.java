package com.recycle.bean;

public class Carrier {
    private Integer carrierId;  //收货员编号
    private String openId;      //收货员openId
    private String realName;    //姓名
    private String idNumber;    //身份证号
    private String wxPicture;   //微信头像
    private Integer gender;     //性别
    private String mobile;      //手机号
    private String region;      //地区

    public Carrier(Integer carrierId, String openId, String realName, String idNumber, String wxPicture, Integer gender, String mobile, String region) {
        this.carrierId = carrierId;
        this.openId = openId;
        this.realName = realName;
        this.idNumber = idNumber;
        this.wxPicture = wxPicture;
        this.gender = gender;
        this.mobile = mobile;
        this.region = region;
    }

    public Carrier() {
    }

    public Integer getCarrierId() {
        return carrierId;
    }

    public void setCarrierId(Integer carrierId) {
        this.carrierId = carrierId;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
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

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    @Override
    public String toString() {
        return "Carrier{" +
                "carrierId=" + carrierId +
                ", openId='" + openId + '\'' +
                ", realName='" + realName + '\'' +
                ", idNumber='" + idNumber + '\'' +
                ", wxPicture='" + wxPicture + '\'' +
                ", gender=" + gender +
                ", mobile='" + mobile + '\'' +
                ", region='" + region + '\'' +
                '}';
    }
}
