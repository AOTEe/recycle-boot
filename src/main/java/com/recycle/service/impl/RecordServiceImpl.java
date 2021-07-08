package com.recycle.service.impl;

import com.recycle.bean.Record;
import com.recycle.bean.WxPage;
import com.recycle.dao.CarDao;
import com.recycle.dao.RecordDao;
import com.recycle.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RecordServiceImpl implements RecordService {

    @Autowired
    CarDao carDao;
    @Autowired
    RecordDao recordDao;

    @Override
    public Map<String,Object> signIn(Integer recordId,Integer carrierId,String carNum,String imagePath,Double weight,Integer state) {

        Map<String,Object> map=new HashMap<>();

        if (state==0){//入场
            if (recordDao.insertRecord(carrierId,carNum,imagePath,weight)>0){
                carDao.changeCarState(carNum,0);
                map.put("success",true);
                map.put("message","入场打卡成功!");
            }
            else
            {
                map.put("success",false);
                map.put("message","入场打卡失败!");
            }
        }
        else {//退场
            if (recordDao.updateRecordOut(recordId,imagePath,weight)>0){
                carDao.changeCarState(carNum,1);
                map.put("success",true);
                map.put("message","退场打卡成功!");
            }
            else
            {
                map.put("success",false);
                map.put("message","退场打卡失败!");
            }
        }

        return map;

    }



    @Override
    public List<Record> findRecordList(String realName, String carNum, String recordTime, Integer page, Integer size) {
        return recordDao.findRecordList(realName, carNum, recordTime, (page-1)*size, size);
    }

    @Override
    public int findRecordCount(String realName, String carNum, String recordTime) {
        return recordDao.findRecordCount(realName,carNum,recordTime);
    }

    @Override
    public WxPage<Record> findRecordsByCarrierId(Integer carrierId,Integer page) {
        WxPage<Record> recordWxPage=new WxPage<>();
        List<Record> records=recordDao.findRecordsByCarrierId(carrierId,recordWxPage.getCurrentIndex(page));
        int count=recordDao.findRecordCountByCarrierId(carrierId);
        recordWxPage.setList(records);
        recordWxPage.setTotalCount(count);
        recordWxPage.setPageIndex(page);
        recordWxPage.setPageTotalCount();
        return recordWxPage;
    }
}
