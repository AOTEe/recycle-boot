package com.recycle.service;

import com.recycle.bean.Record;
import com.recycle.bean.WxPage;

import java.util.List;
import java.util.Map;

public interface RecordService {
    //收货员打卡
    public Map<String,Object> signIn(Integer recordId,Integer carrierId,String carNum,String imagePath,Double weight,Integer state);

    //条件查询获取 打卡信息列表
    public List<Record> findRecordList(String realName,
                                       String carNum,
                                       String recordTime,
                                       Integer index,
                                       Integer size);
    //获取总数count
    public int findRecordCount(String realName,String carNum,String recordTime);

    //获取收货员的历史打卡记录
    public WxPage<Record> findRecordsByCarrierId(Integer carrierId, Integer page);
}
