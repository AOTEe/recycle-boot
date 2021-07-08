package com.recycle.config;

public class WxCarrierApp {
        //本地的测试小程序
        String APPID = "wx42641fa584699630";
        String APP_SECRET = "d54e476c992696c821e7b00167147ef4";//小程序密钥

        /*String APPID = "wx5008265dfbbe7b0d";
        String APP_SECRET = "a4c6b015621baeb5f107aabe7aad7310";//小程序密钥*/
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
