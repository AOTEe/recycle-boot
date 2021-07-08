package com.recycle.controller;


import com.recycle.bean.Car;
import com.recycle.service.CarService;
import com.recycle.utils.LayUIMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CarController {
    @Autowired
    CarService carService;

    @RequestMapping("/toCarlist")
    public String toCarlist(){

        return "backstage/car/carlist";
    }


    //获得车辆列表
    @ResponseBody
    @RequestMapping(value="/getCarList",produces = "text/html;charset=UTF-8")
    public String getCarList(String carNum,
                             String province,
                             String city,
                             String county,
                             Integer state,
                             Integer page, Integer limit)  {
        //region的拼接
        String region="";
        if (province!=null&&city!=null&&county!=null){
            if((!province.contains("请"))&&(!city.contains("请"))&&(!county.contains("请")))
                region = region + province + city + county;

        }
        //获得查询到的数据总数
        int totalNum=carService.getCarCount(carNum,region,state);
        List<Car> cars=carService.getCarList(carNum,region,state,page,limit);
        LayUIMap<Car> layUIMap=new LayUIMap<>(totalNum,cars);

        String dataJson=layUIMap.getLayUIjson();
        return dataJson;
    }

    @RequestMapping("/delOneCar")
    @ResponseBody
    public Map<String, Object> delOneCar(Integer carId){

        carService.delCarById(carId);
        Map<String,Object> map=new HashMap<>();
        map.put("success", true);
        map.put("message", "删除成功");
        return map;

    }

    @ResponseBody
    @RequestMapping("/carBatchDel")
    public Map<String,Object> carBatchDel(String ids){
        //将carId字符串分割成字符串数组
        String[] strings=ids.split(",");
        Map<String, Object> map = new HashMap<>();

        for (int i = 0; i < strings.length; i++) {
            carService.delCarById(Integer.parseInt(strings[i]));
        }

        map.put("success", true);
        map.put("message", "删除成功");

        return map;

    }

    @RequestMapping("/addCar")
    @ResponseBody
    public Map<String,Object> addCar(String carNum,String carType,String province,String city,String county){
        Map<String, Object> map = new HashMap<>();
        int isExist =carService.getCarCount(carNum,null,null);

        //region的拼接
        String region="";
        if (province!=null&&city!=null&&county!=null){
            if((!province.contains("请"))&&(!city.contains("请"))&&(!county.contains("请")))
                region = region + province + city + county;
        }
        else{
            map.put("success", false);
            map.put("message", "请选择正确的区域");
            return map;
        }

        if(isExist>0){
            map.put("success", false);
            map.put("message", "车牌号已存在");
        }
        else if (isExist<=0 && carService.addCar(carNum, carType,region) > 0) {
            map.put("success", true);
            map.put("message", "添加成功");
        } else {
            map.put("success", false);
            map.put("message", "添加失败");
        }
        return map;
    }

    @RequestMapping("/updateCar")
    @ResponseBody
    public Map<String,Object> updateCar(Car car){
        Map<String, Object> map = new HashMap<>();

        //int isExist =carService.getCarCount(car.getCarNum(),null,null);


        Car carExist=carService.getCarExist(car.getCarNum());


        if (carExist!=null&&!car.getCarId().equals(carExist.getCarId())&&car.getCarNum().equals(carExist.getCarNum())){
            map.put("success", false);
            map.put("message", "车牌号已存在");
            return map;
        }

        if (carService.update(car)>0){
            map.put("success", true);
            map.put("message", "修改成功");
        }else {
            map.put("success", false);
            map.put("message", "修改失败");
        }
        return map;
    }
}
