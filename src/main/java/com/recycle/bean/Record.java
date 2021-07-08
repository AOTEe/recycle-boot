package com.recycle.bean;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class Record {
    private Integer recordId;
    private String realName;
    private String carNum;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date beginTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date endTime;
    private String beginImg;
    private String endImg;
    private Double beginWeight;
    private Double endWeight;

    public Record() {
    }

    public Record(Integer recordId, String realName, String carNum, Date beginTime, Date endTime, String beginImg, String endImg, Double beginWeight, Double endWeight) {
        this.recordId = recordId;
        this.realName = realName;
        this.carNum = carNum;
        this.beginTime = beginTime;
        this.endTime = endTime;
        this.beginImg = beginImg;
        this.endImg = endImg;
        this.beginWeight = beginWeight;
        this.endWeight = endWeight;
    }

    public Integer getRecordId() {
        return recordId;
    }

    public void setRecordId(Integer recordId) {
        this.recordId = recordId;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getCarNum() {
        return carNum;
    }

    public void setCarNum(String carNum) {
        this.carNum = carNum;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getBeginImg() {
        return beginImg;
    }

    public void setBeginImg(String beginImg) {
        this.beginImg = beginImg;
    }

    public String getEndImg() {
        return endImg;
    }

    public void setEndImg(String endImg) {
        this.endImg = endImg;
    }

    public Double getBeginWeight() {
        return beginWeight;
    }

    public void setBeginWeight(Double beginWeight) {
        this.beginWeight = beginWeight;
    }

    public Double getEndWeight() {
        return endWeight;
    }

    public void setEndWeight(Double endWeight) {
        this.endWeight = endWeight;
    }

    @Override
    public String toString() {
        return "Record{" +
                "recordId=" + recordId +
                ", realName='" + realName + '\'' +
                ", carNum='" + carNum + '\'' +
                ", beginTime=" + beginTime +
                ", endTime=" + endTime +
                ", beginImg='" + beginImg + '\'' +
                ", endImg='" + endImg + '\'' +
                ", beginWeight=" + beginWeight +
                ", endWeight=" + endWeight +
                '}';
    }
}
