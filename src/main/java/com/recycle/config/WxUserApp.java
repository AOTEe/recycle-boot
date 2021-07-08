package com.recycle.config;

public class WxUserApp {
    String APPID = "wx6ba570857fa25f1e";
    String APP_SECRET = "9de4cd871f7318f072d71c0a89628b07";//小程序密钥
    public String getAPPID() {
        return APPID;
    }

    public void setAPPID(String APPID) {
        this.APPID = APPID;
    }

    public String getAPP_SECRET() {
        return APP_SECRET;
    }

    public void setAPP_SECRET(String APP_SECRET) {
        this.APP_SECRET = APP_SECRET;
    }
}
