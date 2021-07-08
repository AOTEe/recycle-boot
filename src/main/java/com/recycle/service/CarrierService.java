package com.recycle.service;

import com.recycle.bean.Carrier;
import com.recycle.bean.Order;

import java.util.List;
import java.util.Map;

public interface CarrierService {
    public int getCarrierCount(Carrier carrier);

    public List<Carrier> getCarrierList(Carrier carrier,Integer currentRow,Integer pageSize);

    public void confirmOrder(Order order);

    public Carrier carrierLogin(Carrier carrier);

    public Carrier updateCarrierInfo(Carrier carrier);

    public List<String> getAvailableCars(Integer carrierId);

    public Map<String,Object> carrierState(Integer carrierId);

    public Map<String,Object> getRecycleSites(Integer carrierId);
}
