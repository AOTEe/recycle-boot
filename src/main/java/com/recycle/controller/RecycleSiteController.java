package com.recycle.controller;


import com.recycle.bean.RecycleSite;
import com.recycle.service.SiteService;
import com.recycle.utils.AddressParseUtils;
import com.recycle.utils.LayUIMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class RecycleSiteController {
    @Autowired
    SiteService siteService;

    @RequestMapping("/toSiteList")
    public String toCarlist(){
        return "backstage/site/sitelist";
    }

    //获取回收站列表
    @ResponseBody
    @RequestMapping(value = "/getSiteList",produces = "text/html;charset=UTF-8")
    public String getSiteList(String siteName,String province,String city,Integer page,Integer limit){
        //region的拼接
        String region="";
        if (province!=null&&city!=null){
            if((!province.contains("请"))&&(!city.contains("请")))
                region = region + province + city;

        }

        LayUIMap<RecycleSite> data = siteService.getSiteList(siteName,region,page,limit);
        return data.getLayUIjson();
    }
    @RequestMapping("/delOneSite")
    @ResponseBody
    public Map<String, Object> delOneCar(Integer siteId){

        siteService.delCarById(siteId);
        Map<String,Object> map=new HashMap<>();
        map.put("success", true);
        map.put("message", "删除成功");
        return map;

    }
    @ResponseBody
    @RequestMapping("/siteBatchDel")
    public Map<String,Object> carBatchDel(String ids){
        //将siteId字符串分割成字符串数组
        String[] strings=ids.split(",");
        Map<String, Object> map = new HashMap<>();

        for (int i = 0; i < strings.length; i++) {
            siteService.delCarById(Integer.parseInt(strings[i]));
        }

        map.put("success", true);
        map.put("message", "删除成功");

        return map;

    }

    @RequestMapping("/updateSite")
    @ResponseBody
    public Map<String,Object> updateCar(Integer siteId,String siteName,String province,String city,String county,String address){

        Map<String, Object> resultMap = new HashMap<>();
        //region的拼接
        String region="";
        if (province!=null&&city!=null&&county!=null){
            if((!province.contains("请"))&&(!city.contains("请"))&&(!county.contains("请")))
                region = region + province + city + county;

        }
        if (region==""||address==null||address==""){
            resultMap.put("success", false);
            resultMap.put("message", "请填写正确的区域和地址信息");
            return resultMap;
        }

        address=region+address;
        Map<String, String> lnglat = AddressParseUtils.parseAddress(address);

        //地址解析失败 提示系统繁忙请稍后再试
        if (lnglat==null){
            resultMap.put("success", false);
            resultMap.put("message", "系统繁忙!请稍后再试");
            return resultMap;
        }
        RecycleSite recycleSite=new RecycleSite(siteId,siteName,address,Double.valueOf(lnglat.get("lng")),Double.valueOf(lnglat.get("lat")),region);

        if (siteService.update(recycleSite)>0){
            resultMap.put("success", true);
            resultMap.put("message", "修改成功");
        }else {
            resultMap.put("success", false);
            resultMap.put("message", "修改失败");
        }
        return resultMap;
    }

    @RequestMapping("/addSite")
    @ResponseBody
    public Map<String,Object> addSite(String siteName,String province,String city,String county,String address){

        Map<String, Object> map = new HashMap<>();
        //region的拼接
        String region="";
        if (province!=null&&city!=null&&county!=null){
            if((!province.contains("请"))&&(!city.contains("请"))&&(!county.contains("请")))
                region = region + province + city + county;

        }
        if (region==""||address==null||address==""){
            map.put("success", false);
            map.put("message", "请填写正确的区域和地址信息");
            return map;
        }
        address=region+address;
        Map<String, String> lnglat = AddressParseUtils.parseAddress(address);
        //地址解析失败 提示系统繁忙请稍后再试
        if (lnglat==null){
            map.put("success", false);
            map.put("message", "系统繁忙!请稍后再试");
            return map;
        }
        RecycleSite recycleSite=new RecycleSite(null,siteName,address,Double.valueOf(lnglat.get("lng")),Double.valueOf(lnglat.get("lat")),region);

        if (siteService.addSite(recycleSite)>0){
            map.put("success", true);
            map.put("message", "添加成功");
        }else {
            map.put("success", false);
            map.put("message", "添加失败");
        }
        return map;
    }


}
