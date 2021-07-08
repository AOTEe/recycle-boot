package com.recycle.dao;

import com.recycle.bean.OrderItem;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderItemDao {
    public List<OrderItem> findByOrderId(Integer orderId);

    public void confirmOrderItem(List<OrderItem> list);

    public int addOrderItem(@Param("wasteId") Integer wasteId,@Param("orderId")Integer orderId);

    public Integer getLastId();
}
