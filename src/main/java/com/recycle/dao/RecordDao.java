package com.recycle.dao;

import com.recycle.bean.Record;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecordDao {

    //入场签到
    public int insertRecord(@Param("carrierId") Integer carrierId,
                            @Param("carNum")String carNum,
                            @Param("beginImg")String beginImg,
                            @Param("beginWeight")Double beginWeight);

    //退场打卡
    Integer updateRecordOut(@Param("recordId") Integer recordId,@Param("endImg") String endImg,@Param("endWeight") Double endWeight);

    public List<Record> findRecordList(@Param("realName")String realName,
                                       @Param("carNum")String carNum,
                                       @Param("recordTime")String recordTime,
                                       @Param("index")Integer index,
                                       @Param("size")Integer size);

    public int isSignIn(Integer carrierId);

    public int findRecordCount(@Param("realName") String realName,
                               @Param("carNum") String carNum,
                               @Param("recordTime") String recordTime);

    public Record getTodayRecordByCarrierId(Integer carrierId);


    public List<Record> findRecordsByCarrierId(@Param("carrierId") Integer carrierId,@Param("index") Integer index);

    public int findRecordCountByCarrierId(Integer carrierId);
}
