package com.recycle.dao;

import com.recycle.bean.AssignCarrier;
import com.recycle.bean.Carrier;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CarrierDao {
    public int getCarrierCount(@Param("carrier") Carrier carrier);
    public List<Carrier> getCarrierList(@Param("carrier") Carrier carrier,
                                        @Param("currentRow") Integer currentRow,
                                        @Param("pageSize") Integer pageSize);

    public Carrier findByCarrierId(Integer carrierId);

    //获得本月收货员的收货信息（用于订单指派页面）
    public List<AssignCarrier> assignCarrierList(@Param("region") String region);

    //根据openid查carrier
    public Carrier findByOpenid(@Param("openId") String openId);

    //新建carrier
    public int addCarrier(Carrier carrier);

    //更新carrier信息
    public int updateCarrierInfo(Carrier carrier);
}
