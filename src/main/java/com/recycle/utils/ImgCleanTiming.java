package com.recycle.utils;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContext;
import java.io.File;

/*@Component
public class ImgCleanTiming {
    //添加定时任务
    @Scheduled(cron="0 0/1 0 0 0 ?")//每三分钟执行一次任务
    public void doClean(){
        System.out.println("定时任务");
        WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
        ServletContext servletContext = webApplicationContext.getServletContext();

        File img=new File()
    }
}*/
