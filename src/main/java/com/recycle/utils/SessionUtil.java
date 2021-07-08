package com.recycle.utils;


import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Component
public class SessionUtil {
    public static Map<Integer, HttpSession> map=new HashMap<>();

    public static void checkUserExist(Integer userId){
        Set<Integer> set=SessionUtil.map.keySet();
        for (Integer i : set) {
            if (i==userId){
                SessionUtil.map.get(i).invalidate();
            }
        }
    }

    /**
     * 判断用户是否存在
     * @param userId
     * @param session
     * @return  true 该账号已被顶掉
     */
    public static boolean userExist(Integer userId,HttpSession session){
        Set<Integer> set=SessionUtil.map.keySet();
        for (Integer i : set) {
            if (i==userId&&SessionUtil.map.get(i)!=session){
                return true;
            }
        }
        return false;
    }
}
