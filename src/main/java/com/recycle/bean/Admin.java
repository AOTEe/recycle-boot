package com.recycle.bean;


import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class Admin {
    private Integer id;
    private String account;
    private String pwd;
    private String realName;
    private String mobile;
    private String lastIp;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date lastTime;
    private String role;//角色
    private String avatar;
    private Integer gender;

    public Admin(Integer id, String account, String pwd, String realName, String mobile, String lastIp, Date lastTime, String role, String avatar, Integer gender) {
        this.id = id;
        this.account = account;
        this.pwd = pwd;
        this.realName = realName;
        this.mobile = mobile;
        this.lastIp = lastIp;
        this.lastTime = lastTime;
        this.role = role;
        this.avatar = avatar;
        this.gender = gender;
    }

    public Admin() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
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

    public String getLastIp() {
        return lastIp;
    }

    public void setLastIp(String lastIp) {
        this.lastIp = lastIp;
    }

    public Date getLastTime() {
        return lastTime;
    }

    public void setLastTime(Date lastTime) {
        this.lastTime = lastTime;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", account='" + account + '\'' +
                ", pwd='" + pwd + '\'' +
                ", realName='" + realName + '\'' +
                ", mobile='" + mobile + '\'' +
                ", lastIp='" + lastIp + '\'' +
                ", lastTime=" + lastTime +
                ", role='" + role + '\'' +
                ", avatar='" + avatar + '\'' +
                ", gender=" + gender +
                '}';
    }
}

