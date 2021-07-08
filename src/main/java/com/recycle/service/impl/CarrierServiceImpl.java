package com.recycle.service.impl;

import com.recycle.bean.Carrier;
import com.recycle.bean.Order;
import com.recycle.bean.Record;
import com.recycle.bean.RecycleSite;
import com.recycle.dao.*;
import com.recycle.service.CarrierService;
import com.recycle.utils.AddressParseUtils;
import com.recycle.utils.WxUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class CarrierServiceImpl implements CarrierService {


    @Autowired
    CarrierDao carrierDao;
    @Autowired
    OrderDao orderDao;
    @Autowired
    OrderItemDao orderItemDao;
    @Autowired
    CountsDao countsDao;
    @Autowired
    CarDao carDao;
    @Autowired
    RecordDao recordDao;
    @Autowired
    RecycleSiteDao recycleSiteDao;
    @Autowired
    UserDao userDao;

    @Override
    public int getCarrierCount(Carrier carrier) {
        return carrierDao.getCarrierCount(carrier);
    }

    @Override
    public List<Carrier> getCarrierList(Carrier carrier, Integer currentRow, Integer pageSize) {
        return carrierDao.getCarrierList(carrier,currentRow,pageSize);
    }

    /**
     *
     * @param order
     */
    @Transactional
    @Override
    public void confirmOrder(Order order) {
        Integer carrierId=order.getCarrier().getCarrierId();
        //查询订单信息中的userId
        Integer userId=orderDao.getOrderByOrderId(order.getOrderId()).getUser().getUserId();
        //确认订单信息 总价格
        orderDao.confirmOrder(order);
        //确认订单项  数量和小计
        orderItemDao.confirmOrderItem(order.getOrderItems());
        //收货员完成数+1
        if (countsDao.countExist(carrierId)==null) //今天记录是否存在
        {
            countsDao.insertTodayCount(carrierId);//创建
        }
        countsDao.finishedPlus(carrierId);//数量+1

        //用户余额增加
        userDao.addRestMoney(order.getTotalPrice(),userId);


    }

    @Override
    public Carrier carrierLogin(Carrier carrier) {
        Carrier DBcarrier=carrierDao.findByOpenid(carrier.getOpenId());
        if (DBcarrier==null){

            carrier.setRealName(WxUtils.formUserName());
            carrierDao.addCarrier(carrier);
            DBcarrier=carrierDao.findByOpenid(carrier.getOpenId());

        }
            return DBcarrier;
    }

    /**
     * 更新并放回carrier信息
     * @param carrier
     * @return
     */
    @Override
    public Carrier updateCarrierInfo(Carrier carrier) {
         carrierDao.updateCarrierInfo(carrier);
         return carrierDao.findByCarrierId(carrier.getCarrierId());
    }

    @Override
    public List<String> getAvailableCars(Integer carrierId) {
        return carDao.getAvailableCars(carrierId);
    }

    @Override
    public Map<String,Object> carrierState(Integer carrierId) {
        Map<String,Object> map=new HashMap<>();
        Record record=recordDao.getTodayRecordByCarrierId(carrierId);
        if (record==null){
            map.put("state",0);
            map.put("msg","今日尚未打卡");
        }
        else if(record.getEndTime()!=null){
            map.put("state",2);
            map.put("msg","已退场");
            map.put("carNum",record.getCarNum());
        }
        else{
            map.put("state",1);
            map.put("msg","已入场");
            map.put("recordId",record.getRecordId());
            map.put("carNum",record.getCarNum());
        }
        return map;
    }

    @Override
    public Map<String,Object> getRecycleSites(Integer carrierId) {
        Map<String,Object> map=new HashMap<>();
         List<RecycleSite> list=recycleSiteDao.getRecycleSites(carrierId);
         if (list==null){
             map.put("success",false);
             map.put("message","您所绑定的区域内无回收站点");
         }
         else {
             for (RecycleSite site : list) {
                 Map<String, Double> txMap = AddressParseUtils.baiduMap2txMap(site.getLng(), site.getLat());
                 site.setLng(txMap.get("lng"));
                 site.setLat(txMap.get("lat"));
             }
             map.put("success",true);
             map.put("message","请求成功");
             map.put("data",list);
         }
         return map;
    }


}
