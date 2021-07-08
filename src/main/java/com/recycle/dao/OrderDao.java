package com.recycle.dao;

import com.recycle.bean.Order;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDao {
/*    public int getOrderCount();

    public List<Order> getOrderList();*/

    //查看状态为已经接单的订单列表
    public List<Order> getOrderList(@Param("orderTimeBegin") String orderTimeBegin,
                                    @Param("orderTimeEnd") String orderTimeEnd,
                                    @Param("assignTimeBegin") String assignTimeBegin,
                                    @Param("assignTimeEnd") String assignTimeEnd,
                                    @Param("state") Integer state,
                                    @Param("orderId")Integer orderId,
                                    @Param("current")Integer current,@Param("size")Integer size);

    //
    public int getOrderCount(@Param("orderTimeBegin") String orderTimeBegin,
                             @Param("orderTimeEnd") String orderTimeEnd,
                             @Param("assignTimeBegin") String assignTimeBegin,
                             @Param("assignTimeEnd") String assignTimeEnd,
                             @Param("state") Integer state,
                             @Param("orderId")Integer orderId);
    //派单给收货员：修改收货员信息,订单状态为 1
    public int assignOrder(@Param("orderId") Integer orderId,@Param("carrierId") Integer carrierId);


    List<Order> getOrderListByAddress(@Param("region") String region);

    public List<Order> findOrdersByCarrierId(@Param("carrierId") Integer carrierId);

    public void confirmOrder(Order order);

    public Integer getCarrierOrdersCount(@Param("carrierId")Integer carrierId,@Param("state")Integer state,@Param("orderId")Integer orderId,@Param("address")String address);

    public List<Order> getCarrierOrders(@Param("carrierId")Integer carrierId,@Param("state")Integer state,@Param("orderId")Integer orderId,@Param("address")String address,@Param("current")Integer current);

    public Integer getUserOrdersCount(@Param("userId") Integer userId, @Param("state") Integer state,@Param("orderId")Integer orderId);

    public List<Order> getUserOrders(@Param("userId") Integer userId, @Param("state") Integer state,@Param("orderId")Integer orderId,@Param("current") Integer current);

    public int addOrder(Order order);

    public Integer getLastOrderId();

    public int doComment(@Param("orderId") Integer orderId,@Param("star") Integer star,@Param("comment") String comment);

    public int cancelOrder(Integer orderId);

    public int setUserId(@Param("userId") Integer userId,@Param("orderId") Integer orderId);

    public Order getOrderByOrderId(Integer orderId);
}
