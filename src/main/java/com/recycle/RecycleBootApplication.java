package com.recycle;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;

@MapperScan("com.recycle.dao")
@SpringBootApplication
@EnableScheduling//开启定时任务
public class RecycleBootApplication {


    public static void main(String[] args) {
        //SpringApplication.run(RecycleBootApplication.class, args);
        //1、返回我们IOC容器
        ConfigurableApplicationContext run = SpringApplication.run(RecycleBootApplication.class, args);

        //2、查看容器里面的组件
        String[] names = run.getBeanDefinitionNames();
        for (String name : names) {
            System.out.println(name);
        }
    }


}
