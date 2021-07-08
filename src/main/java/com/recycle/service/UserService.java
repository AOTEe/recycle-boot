package com.recycle.service;

import com.recycle.bean.Order;
import com.recycle.bean.User;
import com.recycle.utils.LayUIMap;

import java.util.Map;

public interface UserService {
   public User userLogin(User user);

   public User updateUserInfo(User user);

   public Map<String, Object> upOrder(Order order);

   public User getUser(Integer userId);

   public int cancelOrder(Integer orderId);

   public LayUIMap<User> getUserList(Integer userId,Integer page,Integer limit);

}
