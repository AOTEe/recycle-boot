package com.recycle.dao;

import com.recycle.bean.AssignCarrier;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CountsDao {
    //查看当天是否有记录了
    public AssignCarrier countExist(@Param("carrierId") Integer carrierId);
    //今天第一单
    public int insertTodayCount(@Param("carrierId") Integer carrierId);
    //接单数+1
    public int assignedPlus(@Param("carrierId") Integer carrierId);
    //完成单子数+1
    public void finishedPlus(Integer carrierId);
}
