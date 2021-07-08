package com.recycle.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 此类用来封装layUI的数据表格
 * @param <E>
 */
public class LayUIMap<E> {

    private Integer code=0;
    private String msg="";
    private Integer count;
    private List<E> data;

    public LayUIMap(Integer count, List<E> data) {
        this.count = count;
        this.data = data;
    }


    //获得layUI需要的格式
    public String getLayUIjson(){

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", this.count);
        result.put("data", this.data);
        ObjectMapper objectMapper=new ObjectMapper();
        String dataJson = null;
        try {
            dataJson= objectMapper.writeValueAsString(result);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return dataJson;
    }


}
