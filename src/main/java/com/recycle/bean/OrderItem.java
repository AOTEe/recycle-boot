package com.recycle.bean;

public class OrderItem {
    private Integer orderItemId; //订单号
    private Waste waste;//废品对象
    private Double count;//单项个数
    private Double itemPrice;//单项总价

    public OrderItem(Integer orderItemId, Waste waste, Double count, Double itemPrice) {
        this.orderItemId = orderItemId;
        this.waste = waste;
        this.count = count;
        this.itemPrice = itemPrice;
    }

    public OrderItem() {
    }

    public Integer getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(Integer orderItemId) {
        this.orderItemId = orderItemId;
    }

    public Waste getWaste() {
        return waste;
    }

    public void setWaste(Waste waste) {
        this.waste = waste;
    }

    public Double getCount() {
        return count;
    }

    public void setCount(Double count) {
        this.count = count;
    }

    public Double getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(Double itemPrice) {
        this.itemPrice = itemPrice;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "orderItemId=" + orderItemId +
                ", waste=" + waste +
                ", count=" + count +
                ", itemPrice=" + itemPrice +
                '}';
    }
}
