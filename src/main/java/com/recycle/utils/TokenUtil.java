package com.recycle.utils;


import com.recycle.bean.Carrier;
import com.recycle.bean.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;



import java.util.UUID;
import java.util.concurrent.TimeUnit;


@Component
public class TokenUtil {

    @Autowired
    RedisTemplate redisTemplate;

    /**
     *    登录往redis存放token和对象信息，并返回token
     */
    public  String getToken(Object obj){
        String token;
        if (obj.getClass()==Carrier.class){
            token="carrier_"+UUID.randomUUID();
        }
        else
            token="user_"+UUID.randomUUID();

        redisTemplate.opsForValue().set(token,obj);
        //redisTemplate.opsForHash().put("token",token,obj);
        redisTemplate.expire(token,1,TimeUnit.HOURS);

        return token;
    }

    //根据token返回微信用户ID
    public  Integer getUid(String token){
        Object o = redisTemplate.opsForValue().get(token);
        //Object o = redisTemplate.opsForHash().get("token", token);
        if (token.contains("carrier")){
            Carrier carrier=(Carrier)o;
            return carrier.getCarrierId();
        }
        else {
            User user=(User)o;
            return user.getUserId();
        }
    }

    /**
     * 从redis中获取key对应的过期时间;
     * 如果该值有过期时间，就返回相应的过期时间;
     * 如果该值没有设置过期时间，就返回-1;
     * 如果没有该值，就返回-2;
     */
    //查看token是否过期
    public  boolean  isExist(String token){
        Long timeOut = redisTemplate.opsForValue().getOperations().getExpire(token);
        if (timeOut>0) {
            redisTemplate.expire(token,1,TimeUnit.HOURS);
            return true;
        }
        else return false;
    }
}
