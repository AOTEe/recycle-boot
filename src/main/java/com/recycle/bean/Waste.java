package com.recycle.bean;

public class Waste {
    private Integer wasteId;//废品ID
    private String wasteName;//废品名称
    private String unit;//单位
    private Double price;//单价
    private String imageUrl;//图片
    private String describe;//描述
    private Integer state;//伪删除 0删除 1可用

    public Waste() {
    }

    public Waste(Integer wasteId, String wasteName, String unit, Double price, String imageUrl, String describe, Integer state) {
        this.wasteId = wasteId;
        this.wasteName = wasteName;
        this.unit = unit;
        this.price = price;
        this.imageUrl = imageUrl;
        this.describe = describe;
        this.state = state;
    }

    public Integer getWasteId() {
        return wasteId;
    }

    public void setWasteId(Integer wasteId) {
        this.wasteId = wasteId;
    }

    public String getWasteName() {
        return wasteName;
    }

    public void setWasteName(String wasteName) {
        this.wasteName = wasteName;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "Waste{" +
                "wasteId=" + wasteId +
                ", wasteName='" + wasteName + '\'' +
                ", unit='" + unit + '\'' +
                ", price=" + price +
                ", imageUrl='" + imageUrl + '\'' +
                ", describe='" + describe + '\'' +
                ", state=" + state +
                '}';
    }
}
