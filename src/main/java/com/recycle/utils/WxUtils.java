package com.recycle.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class WxUtils {

    //用户名默认生成wx+当前日期+四位字母+四位数字
    public static String formUserName(){
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyyMMdd");
        String userName="wx"+simpleDateFormat.format(new Date());
        Random random=new Random();
        for (int i = 0; i < 4; i++) {
            userName+=(char)('a'+random.nextInt(26));//0-26
        }
        for (int i = 0; i < 4; i++) {
            userName+=random.nextInt(10);
        }
        return userName;
    }
    public static void main(String[] args) {

        System.out.println(formUserName());
    }
}
