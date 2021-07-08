package com.recycle.service.impl;

import com.recycle.bean.AssignCarrier;
import com.recycle.bean.Order;
import com.recycle.bean.WxPage;
import com.recycle.dao.CarrierDao;
import com.recycle.dao.CountsDao;
import com.recycle.dao.OrderDao;
import com.recycle.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderDao orderDao;
    @Autowired
    CarrierDao carrierDao;
    @Autowired
    CountsDao countsDao;

    @Override
    public int getOrderCount(String orderTimeBegin,String orderTimeEnd,String assignTimeBegin,String assignTimeEnd,Integer state,Integer orderId) {
        return orderDao.getOrderCount(orderTimeBegin,orderTimeEnd,assignTimeBegin,assignTimeEnd,state,orderId);
    }

    @Override
    public List<Order> getOrderList(String orderTimeBegin,String orderTimeEnd,String assignTimeBegin,String assignTimeEnd,Integer state,Integer orderId,Integer current,Integer size) {
        return orderDao.getOrderList(orderTimeBegin,orderTimeEnd,assignTimeBegin,assignTimeEnd,state,orderId,current,size);
    }

    @Override
    public List<AssignCarrier> assignCarrierList(String region) {
        return carrierDao.assignCarrierList(region);
    }



    @Transactional
    @Override
    public void assignOrder(Integer orderId,Integer carrierId) {

        orderDao.assignOrder(orderId,carrierId);



        if (countsDao.countExist(carrierId)==null)
            countsDao.insertTodayCount(carrierId);

        countsDao.assignedPlus(carrierId);

    }

    @Override
    public List<Order> getOrderListByAddress(String region) {
        return orderDao.getOrderListByAddress(region) ;
    }

    @Override
    public List<Order> listAssigned(Integer carrierId) {
        return orderDao.findOrdersByCarrierId(carrierId);
    }

    @Override
    public WxPage<Order> getCarrierOrders(Integer page,Integer carrierId,Integer state,Integer orderId,String address) {
        WxPage<Order> orderWxPage=new WxPage<>();
        Integer count=orderDao.getCarrierOrdersCount(carrierId,state,orderId,address);
        orderWxPage.setPageIndex(page);//当前页码
        orderWxPage.setTotalCount(count);//数据个数
        orderWxPage.setPageTotalCount();//页面个数
        List<Order> list=orderDao.getCarrierOrders(carrierId,state,orderId,address,orderWxPage.getCurrentIndex(page));
        orderWxPage.setList(list);
        return orderWxPage;
    }

    @Override
    public WxPage<Order> getUserOrders(Integer page, Integer userId, Integer state,Integer orderId) {
        WxPage<Order> orderWxPage=new WxPage<>();
        Integer count=orderDao.getUserOrdersCount(userId,state,orderId);
        orderWxPage.setPageIndex(page);//当前页码
        orderWxPage.setTotalCount(count);//数据个数
        orderWxPage.setPageTotalCount();//页面个数
        List<Order> list=orderDao.getUserOrders(userId,state,orderId,orderWxPage.getCurrentIndex(page));
        orderWxPage.setList(list);
        return orderWxPage;
    }

    @Override
    public void doComment(Integer orderId, Integer star, String comment) {
        orderDao.doComment(orderId,star,comment);
    }


}
