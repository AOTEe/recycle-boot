package com.recycle.bean;

public class RecycleSite {
    private Integer siteId;
    private String siteName;//站点名
    private String address;//全部地址
    private Double lng;//经度
    private Double lat;//纬度
    private String region;//所在地区

    public RecycleSite() {
    }

    public RecycleSite(Integer siteId, String siteName, String address, Double lng, Double lat, String region) {
        this.siteId = siteId;
        this.siteName = siteName;
        this.address = address;
        this.lng = lng;
        this.lat = lat;
        this.region = region;
    }

    public Integer getSiteId() {
        return siteId;
    }

    public void setSiteId(Integer siteId) {
        this.siteId = siteId;
    }

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
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

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    @Override
    public String toString() {
        return "RecycleSite{" +
                "siteId=" + siteId +
                ", siteName='" + siteName + '\'' +
                ", address='" + address + '\'' +
                ", lng=" + lng +
                ", lat=" + lat +
                ", region='" + region + '\'' +
                '}';
    }
}
