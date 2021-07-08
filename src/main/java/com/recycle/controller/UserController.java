package com.recycle.controller;


import com.recycle.bean.*;
import com.recycle.service.OrderService;
import com.recycle.service.UserService;
import com.recycle.service.WasteService;
import com.recycle.service.WithdrawService;
import com.recycle.utils.HttpUtils;
import com.recycle.utils.LayUIMap;
import com.recycle.config.WxUserApp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {
    @Autowired
    OrderService orderService;

    @Autowired
    WasteService wasteService;

    @Autowired
    UserService userService;

    @Autowired
    WithdrawService withdrawService;


    //获取用户信息表（包含搜索条件
    @ResponseBody
    @RequestMapping(value = "/getUserList",produces = "text/html;charset=UTF-8")
    public String getUserList(Integer userId,Integer page,Integer limit){

        LayUIMap<User> data = userService.getUserList(userId,page,limit);

        return data.getLayUIjson();
    }

    //管理员扫码转账
    @ResponseBody
    @RequestMapping("/payWithdraw")
    public Map<String,Object> payWithdraw(Withdraw withdraw, HttpServletRequest request){
        Admin admin= (Admin) request.getSession().getAttribute("admin");
        withdraw.setAdminId(admin.getId());
        Map<String,Object> map=withdrawService.payWithdraw(withdraw);
        return map;
    }

    //获取withdraw列表
    @ResponseBody
    @RequestMapping(value = "/getWithdrawList",produces = "text/html;charset=UTF-8")
    public String getWithdrawList(Integer userId,Integer adminId,Integer page,Integer state,Integer limit){
        LayUIMap<Withdraw> data=withdrawService.getList(userId,adminId,state,page,limit);
        return data.getLayUIjson();
    }


    /**
     * =================微信端用户api===================
     */

    //小程序登录
    @ResponseBody
    @RequestMapping("/api/userLogin")
    public User userLogin(String code) throws IOException {
        WxUserApp config = new WxUserApp();//app id&secret的配置
        //设置请求的url
        String urlHeader = "https://api.weixin.qq.com/sns/jscode2session";
        Map<String, String> urlParams = new HashMap<>();
        urlParams.put("appid", config.getAPPID());
        urlParams.put("secret", config.getAPP_SECRET());
        urlParams.put("js_code", code);
        urlParams.put("grant_type", "authorization_code");

        User user =new User();
        String openid = HttpUtils.getOpenid(urlHeader, urlParams);
        user.setOpenId(openid);

        //登录or注册用户
        //根据openid查询user没有就插入一条新的user
        User DBuser =userService.userLogin(user);
        return DBuser;
    }
    //查看用户个人信息
    @ResponseBody
    @RequestMapping("api/getUserInfo")
    public User getUserInfo(Integer userId){
        User user=userService.getUser(userId);
        return user;
    }

    //更新小程序用户的个人信息
    @ResponseBody
    @RequestMapping("/api/updateUserInfo")
    public User updateUserInfo(@RequestBody User user){
       User newUser= userService.updateUserInfo(user);
       return newUser;
    }
    //获取用户不同状态的订单
    //0未接单 1已接单 2已完成（commentState=0未评价,1已评价） 3已取消
    @RequestMapping("/api/userOrders")
    @ResponseBody
    public WxPage<Order> userOrders(Integer page,Integer userId,Integer state,Integer orderId){
        return orderService.getUserOrders(page,userId,state,orderId);
    }

    //获得所有的废品列表
    @RequestMapping("/api/allWaste")
    @ResponseBody
    public List<Waste> allWaste(){
        List<Waste> list=wasteService.getAllWaste();
        return list;
    }

    //提交废品表单
    @RequestMapping("/api/upOrder")
    @ResponseBody
    public Map<String,Object> upOrder(@RequestBody Order order){
        Map<String, Object> map=userService.upOrder(order);
        return map;
    }



    //评价对应订单
    @ResponseBody
    @RequestMapping("/api/doComment")
    public Map<String,Object> doComment(Integer orderId,Integer star,String comment){
        Map<String,Object> map=new HashMap<>();
        if (star==null||comment==null){
            map.put("success",false);
            map.put("message","评论不能为空");
        }
        else{
            orderService.doComment(orderId,star,comment);
            map.put("success",true);
            map.put("message","评论成功");
        }
        return map;
    }

    //用户取消订单
    @ResponseBody
    @RequestMapping("/api/cancelOrder")
    public Map<String,Object> cancelOrder(Integer orderId){
        Map<String,Object> map=new HashMap<>();
        userService.cancelOrder(orderId);
        map.put("success",true);
        map.put("message","取消成功");
    return map;
    }

    //用户发起提现请求
    @ResponseBody
    @RequestMapping("/api/subPayment")
    public Map<String,Object> userWithdraw(Integer userId,Double money){
        Map<String,Object>  map= withdrawService.subRequest(userId,money);
        return map;
    }

    //获取历史提现记录
    @ResponseBody
    @RequestMapping("/api/payments")
    public WxPage<Withdraw> payments(Integer userId, Integer state, Integer page){
        WxPage<Withdraw> withdrawWxPage=withdrawService.getUserWithdraws(userId,state,page);

        return withdrawWxPage;
    }

    /**
     * ===========页面跳转==========
     */
    @RequestMapping("/toUserList")
    public String toUserList(){
        return "backstage/user/users/userlist";
    }


    @RequestMapping("/toPayList")
    public String toPayList(){
        return "backstage/order/paylist";
    }
}
