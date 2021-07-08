package com.recycle.service;

import com.recycle.bean.AssignCarrier;
import com.recycle.bean.Order;
import com.recycle.bean.WxPage;

import java.util.List;

public interface OrderService {
/*    public int getOrderCount();

    public List<Order> getOrderList();*/

    public int getOrderCount(String orderTimeBegin,String orderTimeEnd,String assignTimeBegin,String assignTimeEnd,Integer state,Integer orderId);

    public List<Order> getOrderList(String orderTimeBegin,String orderTimeEnd,String assignTimeBegin,String assignTimeEnd,Integer state,Integer orderId,Integer current,Integer size);

    //指派订单时查询，当月收货员的收货信息
    public List<AssignCarrier> assignCarrierList(String region);

    //为一名收货员指派订单
    public void assignOrder(Integer orderId,Integer carrierId);

    //查找某一区域内未接单的订单
    List<Order> getOrderListByAddress(String region);

    //根据carrierId 查询该收货员已接单的订单列表
    public List<Order> listAssigned(Integer carrierId);

    //根据carrierID查询不同订单状态的订单列表
    public WxPage<Order> getCarrierOrders(Integer page,Integer carrierId,Integer state,Integer orderId,String address);

    //根据userID查询不同订单状态的订单列表
    public WxPage<Order> getUserOrders(Integer page, Integer userId, Integer state,Integer orderId);

    //对相应订单进行评价
    public void doComment(Integer orderId, Integer star, String comment);
}
