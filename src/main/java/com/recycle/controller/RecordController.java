package com.recycle.controller;


import com.recycle.bean.Record;
import com.recycle.service.RecordService;
import com.recycle.utils.LayUIMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class RecordController {
    @Autowired
    RecordService recordService;


    //页面跳转
    @RequestMapping("/toRecordlist")
    public String toCarlist(){

        return "backstage/car/recordlist";
    }



    //layUI异步加载表格
    @RequestMapping(value = "/getRecordList",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getRecordList(String realName,
                                String carNum,
                                String recordTime,
                                Integer page,
                                Integer limit){
        int count=recordService.findRecordCount(realName, carNum, recordTime);
        List<Record> list=recordService.findRecordList(realName, carNum, recordTime, page, limit);
        LayUIMap<Record> map=new LayUIMap<>(count,list);
        return map.getLayUIjson();
    }
}
