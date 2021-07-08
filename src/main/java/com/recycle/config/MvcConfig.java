package com.recycle.config;

import com.recycle.controller.interceptor.WXInterceptor;
import com.recycle.utils.TokenUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(wXInterceptor()).addPathPatterns("/api/**")
                //不拦截的路径
                .excludePathPatterns("/api/carrierLogin","/api/userLogin");
    }

    @Bean
    public WXInterceptor wXInterceptor(){
        return new WXInterceptor();
    }
}
