package com.recycle.service.impl;

import com.recycle.bean.Order;
import com.recycle.bean.OrderItem;
import com.recycle.bean.User;
import com.recycle.bean.Waste;
import com.recycle.dao.OrderDao;
import com.recycle.dao.OrderItemDao;
import com.recycle.dao.UserDao;
import com.recycle.dao.WasteDao;
import com.recycle.service.UserService;
import com.recycle.utils.AddressParseUtils;
import com.recycle.utils.LayUIMap;
import com.recycle.utils.WxUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    @Autowired
    WasteDao wasteDao;

    @Autowired
    OrderItemDao orderItemDao;

    @Autowired
    OrderDao orderDao;

    @Override
    public User userLogin(User user) {
        User DBuser= userDao.findByOpenid(user.getOpenId());
        if (DBuser==null){

            user.setNickName(WxUtils.formUserName());
            userDao.addUser(user);
            DBuser=userDao.findByOpenid(user.getOpenId());

        }
        return DBuser;
    }

    @Override
    public User updateUserInfo(User user) {
        userDao.updateUserInfo(user);
        User newUser=userDao.findByUserId(user.getUserId());
        return newUser;
    }

    @Transactional
    @Override
    public  Map<String, Object>  upOrder(Order order) {
        //地址解析成经纬度
        Map<String, String> addressMap = AddressParseUtils.parseAddress(order.getAddress());
        Map<String,Object> resMap=new HashMap<>();
        resMap.put("success",true);
        resMap.put("message","下单成功");
        if (addressMap==null){
            resMap.put("success",false);
            resMap.put("message","系统繁忙!请稍后再试");
        }
        order.setLng(Double.parseDouble(addressMap.get("lng")));
        order.setLat(Double.parseDouble(addressMap.get("lat")));

        //根据userId查询user对象填入order对象  为了return
         order.setUser(userDao.findByUserId(order.getUser().getUserId()));

         //0 获取orderId  当前时间戳 加了锁
        int orderId=formOrderId();
        order.setOrderId(orderId);
         //1 插入order表 拿到orderId
        orderDao.addOrder(order);

        //2 插入userId
        orderDao.setUserId(order.getUser().getUserId(),orderId);


         //3 根据orderItems里的wasteId查询waste对象填充到orderItems中
        List<OrderItem> orderItems = order.getOrderItems();
        for (OrderItem orderItem : orderItems) {
            Waste waste = wasteDao.getWasteListById(orderItem.getWaste().getWasteId());
            orderItemDao.addOrderItem(waste.getWasteId(),orderId);

            //为了return
            Integer orderItemId=orderItemDao.getLastId();
            orderItem.setOrderItemId(orderItemId);
            orderItem.setWaste(waste);
        }
        order.setOrderItems(orderItems);
        return resMap;
    }

    @Override
    public User getUser(Integer userId) {
        return userDao.findByUserId(userId);
    }

    @Override
    public int cancelOrder(Integer orderId) {
        return orderDao.cancelOrder(orderId);
    }

    @Override
    public LayUIMap<User> getUserList(Integer userId,Integer page,Integer limit) {
        int count=userDao.getUserCount(userId);
        List<User> list=userDao.getUserList(userId,(page-1)*limit,limit);
        LayUIMap<User> map=new LayUIMap<>(count,list);

        return map;
    }

    //给生成订单号加个锁 睡一秒保证 时间戳不重复
    public synchronized int formOrderId(){
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return (int)(new Date().getTime()/1000);
    }
}
