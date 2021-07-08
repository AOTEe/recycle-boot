package com.recycle.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonUtil {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    //Object ->string
    public static String getJsonStr(Object obj){

        String jsonStr=null;
        try {
             jsonStr = MAPPER.writeValueAsString(obj);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return jsonStr;
    }

    //string ->Object
    public static Object getObj(String jsonStr,Class beanType){
        try {
            Object obj = MAPPER.readValue(jsonStr, beanType);
            return obj;
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return null;
    }
}
