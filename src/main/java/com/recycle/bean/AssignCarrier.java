package com.recycle.bean;

/**
 * 订单指派页面收货员对应信息类
 */
public class AssignCarrier {
    private Integer carrierId;
    private String realName;
    private String mobile;
    private Double achievement;//废品回收业绩
    private Integer assigned;//接单数
    private Integer finished;//订单完成数

    public AssignCarrier() {
    }

    public AssignCarrier(Integer carrierId, String realName, String mobile, Double achievement, Integer assigned, Integer finished) {
        this.carrierId = carrierId;
        this.realName = realName;
        this.mobile = mobile;
        this.achievement = achievement;
        this.assigned = assigned;
        this.finished = finished;
    }

    public Integer getCarrierId() {
        return carrierId;
    }

    public void setCarrierId(Integer carrierId) {
        this.carrierId = carrierId;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Double getAchievement() {
        return achievement;
    }

    public void setAchievement(Double achievement) {
        this.achievement = achievement;
    }

    public Integer getAssigned() {
        return assigned;
    }

    public void setAssigned(Integer assigned) {
        this.assigned = assigned;
    }

    public Integer getFinished() {
        return finished;
    }

    public void setFinished(Integer finished) {
        this.finished = finished;
    }

    @Override
    public String toString() {
        return "AssignCarrier{" +
                "carrierId=" + carrierId +
                ", realName='" + realName + '\'' +
                ", mobile='" + mobile + '\'' +
                ", achievement=" + achievement +
                ", assigned=" + assigned +
                ", finished=" + finished +
                '}';
    }
}
