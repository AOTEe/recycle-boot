package com.recycle.controller;


import com.recycle.bean.Carrier;
import com.recycle.bean.Order;
import com.recycle.bean.Record;
import com.recycle.bean.WxPage;
import com.recycle.config.WxCarrierApp;
import com.recycle.service.CarrierService;
import com.recycle.service.OrderService;
import com.recycle.service.RecordService;
import com.recycle.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CarrierController {

    @Autowired
    CarrierService carrierService;

    @Autowired
    OrderService orderService;

    @Autowired
    RecordService recordService;

    @Autowired
    TokenUtil tokenUtil;




    @ResponseBody
    @RequestMapping("/api/imgTest")
    public String imgTest(MultipartFile picture, HttpServletRequest request){
        String path1=request.getSession().getServletContext().getRealPath("/upload");
        String path2=request.getServletContext().getRealPath("/upload");
        return "ok";
    }
    /**                                 微信端api
     * ====================================================================================
     */

    //图片上传
    @ResponseBody
    @RequestMapping("/api/imgUpload")
    public String imgUpload(HttpServletRequest request,MultipartFile picture){
        String tailPath="/upload/img";
        String imgUrl = ImgUploadUtils.imgUpload(request, tailPath, picture);
        return imgUrl;
    }

    //出场及退场打卡
    @ResponseBody
    @RequestMapping("/api/signIn")
    public Map<String,Object> signIn(String picture, Integer carrierId, String carNum,Double weight,Integer state,Integer recordId){

        //返回的信息
        Map<String,Object> map=recordService.signIn(recordId,carrierId,carNum,picture,weight,state);


/*        if (!success){
            //删除上传的图片
            File exist=new File(request.getServletContext().getRealPath(picture));
            exist.delete();
        }*/
        return map;
    }



    //收货员登录
    @ResponseBody
    @RequestMapping("/api/carrierLogin")
    public Map<String,Object>  Login(String code) throws IOException {

        WxCarrierApp config = new WxCarrierApp();//app id&secret的配置
        //GET https://api.weixin.qq.com/sns/jscode2session   ?appid=APPID & secret=SECRET & js_code=JSCODE  & grant_type=authorization_code

        String urlHeader = "https://api.weixin.qq.com/sns/jscode2session";
        Map<String, String> urlParams = new HashMap<>();
        urlParams.put("appid", config.getAPPID());
        urlParams.put("secret", config.getAPP_SECRET());
        urlParams.put("js_code", code);
        urlParams.put("grant_type", "authorization_code");

        Carrier carrier=new Carrier();
        String openid = HttpUtils.getOpenid(urlHeader, urlParams);
        carrier.setOpenId(openid);


        //登录or注册收货员
        //根据openid查询carrier 没有就插入一条新的carrier
        Carrier DBcarrier =carrierService.carrierLogin(carrier);

        String token=tokenUtil.getToken(DBcarrier);
        Integer uid=tokenUtil.getUid(token);
        Map<String,Object> resMap=new HashMap<>();
        resMap.put("token",token);
        resMap.put("message","登录成功");
        resMap.put("data",DBcarrier);
        return resMap;
    }

    //收货员完善个人信息
    @ResponseBody
    @RequestMapping("/api/updateCarrierInfo")
    public Carrier completeCarrierInfo(@RequestBody Carrier carrier){
        Carrier newCarrier = carrierService.updateCarrierInfo(carrier);
        return newCarrier;
    }

    //获取收货员的接单列表
    @RequestMapping("/api/listAssigned")
    @ResponseBody
    public List<Order> listAssigned(Integer carrierId){
        List<Order> listAssigned = orderService.listAssigned(carrierId);
        //因前台的为腾讯坐标,将百度系转换为腾讯系
        for (Order order : listAssigned) {
            Map<String, Double> txMap = AddressParseUtils.baiduMap2txMap(order.getLng(), order.getLat());
            order.setLng(txMap.get("lng"));
            order.setLat(txMap.get("lat"));
        }
        return  listAssigned;
    }

    //最后确认时修改订单中订单项
    @ResponseBody
    @RequestMapping("/api/confirmOrder")
    public Order confirmOrder(@RequestBody Order order){

        carrierService.confirmOrder(order);
        return order;
    }

    //获取和收货员相同地区的可用车辆
    @ResponseBody
    @RequestMapping("/api/availableCars")
    public List<String> availableCars(Integer carrierId){
       List<String> list=carrierService.getAvailableCars(carrierId);
       return list;
    }

    //收货员打卡前获取当天打卡状态
    @ResponseBody
    @RequestMapping("/api/carrierState")
    public Map<String, Object> carrierState(Integer carrierId){
        Map<String, Object> stateMap = carrierService.carrierState(carrierId);
        return stateMap;
    }


    //获取收货员不同状态的订单列表 增加查询条件
    @ResponseBody
    @RequestMapping("/api/carrierOrders")
    public WxPage<Order> carrierOrders(Integer page, Integer carrierId, Integer state, Integer orderId, String address){
        WxPage<Order> orderWxPage = orderService.getCarrierOrders(page,carrierId, state, orderId,address);
        return orderWxPage;
    }

    //获取收货员的历史打卡记录
    @ResponseBody
    @RequestMapping("/api/records")
    public WxPage<Record> records(Integer carrierId, Integer page){
        WxPage<Record> recordWxPage=recordService.findRecordsByCarrierId(carrierId,page);
        return recordWxPage;
    }
    //获取和收获员相同地区的收获站地点
    @ResponseBody
    @RequestMapping("/api/recycleSites")
    public Map<String,Object> recycleSites(Integer carrierId){
        Map<String,Object> map= carrierService.getRecycleSites(carrierId);
        return map;
    }

    /**
     *页面跳转
     */
    @RequestMapping("/toCarrierList")
    public String toCarrier(){
        return "backstage/user/carriers/carrierlist";
    }

    /**
     * ====================================================================================
     */
    /**
     *
     * @param carrier  包含了条件查询的字段
     * @param page      当前页面
     * @param limit      页面大小
     * @return
     */
    @RequestMapping(value = "/getCarrierList",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getCarrierList(Carrier carrier,String province,String city,String county, Integer page,Integer limit){

        //拼接省市区 为region（地区）
        String region="";
        if (province!=null&&province!="")
            region=region+province;
        if (city!=null&&city!="")
            region=region+city;
        if (county!=null&&county!="")
            region=region+county;

        carrier.setRegion(region);

        int carrierCount = carrierService.getCarrierCount(carrier);
        List<Carrier> carrierList = carrierService.getCarrierList(carrier, (page - 1) * limit, limit);
        LayUIMap map=new LayUIMap(carrierCount,carrierList);
        return map.getLayUIjson();
    }
}
