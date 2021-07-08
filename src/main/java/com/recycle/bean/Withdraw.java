package com.recycle.bean;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class Withdraw {

    private Integer withdrawId;//提现单号
    private Integer userId;//用户ID
    private Integer adminId;//审批的管理员ID
    private String wxOrderno;//管理员转账凭证
    private Double money;//提现金额
    private Integer state;//0未支付 1已支付
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date subTime;//提现提交时间
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date payTime;//提现支付时间
    private String moneyCode;//收款码

    public Withdraw() {
    }

    public Withdraw(Integer withdrawId, Integer userId, Integer adminId, String wxOrderno, Double money, Integer state, Date subTime, Date payTime, String moneyCode) {
        this.withdrawId = withdrawId;
        this.userId = userId;
        this.adminId = adminId;
        this.wxOrderno = wxOrderno;
        this.money = money;
        this.state = state;
        this.subTime = subTime;
        this.payTime = payTime;
        this.moneyCode = moneyCode;
    }

    public Integer getWithdrawId() {
        return withdrawId;
    }

    public void setWithdrawId(Integer withdrawId) {
        this.withdrawId = withdrawId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getAdminId() {
        return adminId;
    }

    public void setAdminId(Integer adminId) {
        this.adminId = adminId;
    }

    public String getWxOrderno() {
        return wxOrderno;
    }

    public void setWxOrderno(String wxOrderno) {
        this.wxOrderno = wxOrderno;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Date getSubTime() {
        return subTime;
    }

    public void setSubTime(Date subTime) {
        this.subTime = subTime;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public String getMoneyCode() {
        return moneyCode;
    }

    public void setMoneyCode(String moneyCode) {
        this.moneyCode = moneyCode;
    }

    @Override
    public String toString() {
        return "Withdraw{" +
                "withdrawId=" + withdrawId +
                ", userId=" + userId +
                ", adminId=" + adminId +
                ", wxOrderno='" + wxOrderno + '\'' +
                ", money=" + money +
                ", state=" + state +
                ", subTime=" + subTime +
                ", payTime=" + payTime +
                ", moneyCode='" + moneyCode + '\'' +
                '}';
    }
}
