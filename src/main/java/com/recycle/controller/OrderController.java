package com.recycle.controller;


import com.recycle.bean.AssignCarrier;
import com.recycle.bean.Carrier;
import com.recycle.bean.Order;
import com.recycle.service.CarrierService;
import com.recycle.service.OrderService;
import com.recycle.utils.LayUIMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
public class OrderController {

    @Autowired
    OrderService orderService;

    @Autowired
    CarrierService carrierService;

    @RequestMapping("/toOrderList")
    public String toOrderList(){
        return "backstage/order/orderlist";
    }
    /**
     * 获取某一区域内未接单的订单List
     * @param
     * @return
     */
    @RequestMapping("/ordersByAddress")
    @ResponseBody
    public List<Order> inMap(String region){


        List<Order> list = orderService.getOrderListByAddress(region);

        return  list;
    }

    /**
     * 获取订单表(可根据台哦见查询)
     * @param orderTimeBegin
     * @param orderTimeEnd
     * @param assignTimeBegin
     * @param assignTimeEnd
     * @param state
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value = "/orders",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String orderList(String orderTimeBegin,
                            String orderTimeEnd,
                            String assignTimeBegin,
                            String assignTimeEnd,
                            Integer orderId,
                            Integer state,
                            Integer page,Integer limit) {
        List<Order> list = orderService.getOrderList(orderTimeBegin,orderTimeEnd,assignTimeBegin,assignTimeEnd,state,orderId,(page-1)*limit,limit);
        int count=orderService.getOrderCount(orderTimeBegin,orderTimeEnd,assignTimeBegin,assignTimeEnd,state,orderId);

        LayUIMap map = new LayUIMap(count,list);
        return map.getLayUIjson();
    }



        /**
         * 获取某一区域内收货员单月的收货信息列表
         * @param carrier 携带region参数
         * @return
         */
    @ResponseBody
    @RequestMapping(value = "/assignCarriers",produces = "text/html;charset=UTF-8")
    public String assignCarriers(Carrier carrier){

        int count= carrierService.getCarrierCount(carrier);
        List<AssignCarrier> list = orderService.assignCarrierList(carrier.getRegion());
        LayUIMap map=new LayUIMap(count,list);

        return map.getLayUIjson();
    }

    /**
     * 为一名收货员指派订单
     * @param orderId
     * @param carrierId
     * @return
     */
    @ResponseBody
    @RequestMapping("/assign")
    public void assign(Integer orderId,Integer carrierId){

        orderService.assignOrder(orderId,carrierId);

    return;
    }
}
