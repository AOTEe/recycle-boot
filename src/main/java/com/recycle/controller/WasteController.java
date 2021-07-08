package com.recycle.controller;


import com.recycle.bean.Waste;
import com.recycle.service.WasteService;
import com.recycle.utils.LayUIMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
public class WasteController {

    @Autowired
    WasteService wasteService;


     // 跳转到车辆列表
    @RequestMapping("/toWasteList")
    public String toWasteList(HttpServletRequest request){


        String s1=request.getContextPath();
        ServletContext servletContext = request.getServletContext();
        String s2=request.getServletContext().getContextPath();
        String s3=request.getServletContext().getRealPath("/");

        return "backstage/waste/wastelist";
    }

    //跳转到统计图页面
    @RequestMapping("/toChars")
    public String toChars(){
        return "backstage/home/chars";
    }

    @ResponseBody
    @RequestMapping(value = "/getWasteList",produces = "text/html;charset=UTF-8")
    public String getWasteList(String wasteName,Integer page,Integer limit){
        Integer count=wasteService.getWasteCount(wasteName);
        List<Waste> wasteList=wasteService.getWasteList(wasteName,(page-1)*limit,limit);
        LayUIMap<Waste> resultMap=new LayUIMap<>(count,wasteList);
        return resultMap.getLayUIjson();

    }

    @ResponseBody
    @RequestMapping("/addWaste")
    public HashMap<String,Object> addWaste(Waste waste){
        HashMap<String,Object> map=new HashMap<>();
        if (wasteService.addWaste(waste)>0){
            map.put("success", true);
            map.put("message", "添加成功");
        }else{
            map.put("success", false);
            map.put("message", "添加失败");
        }
        return map;
    }

    @ResponseBody
    @RequestMapping("/uploadPicture")
    public Map<String,Object> uploadPicture(HttpServletRequest request, MultipartFile picture){
        HashMap<String,Object> map=new HashMap<>();


        String path=request.getServletContext().getRealPath("/wasteImage");

        File file=new File(path);//创建文件目录对象
        if(!file.exists()){
            file.mkdir(); //创建目录
        }
        String fileName=picture.getOriginalFilename();

        //新文件名=UUID+图片的后缀名
        String newFileName= UUID.randomUUID()+fileName.substring(fileName.lastIndexOf("."));
        try {
            picture.transferTo(new File(path, newFileName));
        } catch (IOException e) {
            e.printStackTrace();
        }

        String imagePath="wasteImage/"+newFileName;

        map.put("code",0);
        map.put("msg","");
        Map<String,Object> data=new HashMap<>();
        data.put("src","");
        data.put("pictureUrl",imagePath);
        map.put("data",data);
        return map;
    }

    @RequestMapping("/delWaste")
    @ResponseBody
    public Map<String,Object> delWaste(HttpServletRequest request,String wasteId,String imageUrl){

        Map<String,Object> map=new HashMap<>();
        //删除数据库中的数据同时删除服务器下的图片
        File delImg=new File(request.getServletContext().getRealPath("/"+imageUrl));

        if (wasteService.delWasteById(wasteId)>0&&delImg.delete()){
            map.put("success", true);
            map.put("message", "删除成功");
        }else{
            map.put("success", false);
            map.put("message", "删除失败");
        }
        return map;
    }

    /**
     * 批量删除废品信息
     */
    @ResponseBody
    @RequestMapping("/wasteBatchDel")
    public Map<String,Object> wasteBatchDel(HttpServletRequest request,String ids,String urls){
        String[] idArr=ids.split(",");
        String[] urlArr=urls.split(",");
        Map<String,Object> map=new HashMap<>();
        int i;
        for (i = 0; i < idArr.length; i++) {
            File file=new File(request.getServletContext().getRealPath("/"+urlArr[i]));
           file.delete();
           wasteService.delWasteById(idArr[i]);
        }

            map.put("success", true);
            map.put("message", "删除成功");
        return map;
    }




    /**
     * 修改编辑的废品信息
     */
    @RequestMapping("/updateWaste")
    @ResponseBody
    public Map<String,Object> updateWaste(Waste waste){
        Map<String,Object> map=new HashMap<>();
        if (wasteService.updateWasteById(waste)>0){
            map.put("success", true);
            map.put("message", "修改成功");
        }else{
            map.put("success", false);
            map.put("message", "修改失败");
        }
        return  map;
    }

    //echars表格数据
    //上个月各废品类别的收货金额
    @ResponseBody
    @RequestMapping("/echars/wasteData")
    public List<Map<String,Object>> wasteData(String region){
        List<Map<String,Object>> list=wasteService.getWasteData(region);
        return list;
    }
    //上个月各地区的回收废品总重
    @ResponseBody
    @RequestMapping("/echars/regionData")
    public List<Map<String,Object>> regionData(String region){
        List<Map<String,Object>> list=wasteService.getRegionData(region);
        for (Map<String, Object> map : list) {
            String area =(String) map.get("region");
            map.put("region",area.substring(area.indexOf("市")+1));
        }

        //转换成echars需要的key value
        List<Map<String,Object>> resultList=new ArrayList<>();
        for (Map<String, Object> DBmap : list) {
            Map<String,Object> map=new HashMap<>();
            map.put("name",DBmap.get("region"));
            map.put("value",DBmap.get("weight"));
            resultList.add(map);
        }
        return resultList;
    }

}
