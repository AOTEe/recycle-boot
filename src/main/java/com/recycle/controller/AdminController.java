package com.recycle.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.recycle.bean.Admin;
import com.recycle.service.AdminService;
import com.recycle.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class AdminController {

    @Autowired
    AdminService adminService;

    //页面跳转
    @RequestMapping("/toIndex")
    public String toIndex(){
        return "backstage/user/administrators/index";
    }

    @RequestMapping("/toAdminList")
    public String toAdminList(){
        return "backstage/user/administrators/adminlist";
    }

    @RequestMapping("/toPwd")
    public String toPwd(){
        return "backstage/user/administrators/password";
    }
    @RequestMapping("/toLogin")
    public String toLogin(){
        return "backstage/user/administrators/login";
    }

    @RequestMapping("/toConsole")
    public String toConsole(){
        return "backstage/home/console";
    }

    @RequestMapping("/toInfo")
    public String toInofo(){
        return "backstage/user/administrators/info";
    }
    /**
     * 后台登录ajax
     * @param username
     * @param password
     * @param request
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public Map<String,Object> login(String username,
                                    String password,
                                    String vCode,
                                    Integer remember,
                                    HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException, UnsupportedEncodingException {
        Map<String,Object> msgMap=new HashMap<>();


        //验证验证是否正确
        String sessionCode= (String) request.getSession().getAttribute("vCode");
        if (!sessionCode.toLowerCase().equals(vCode.toLowerCase())){ //全转为小写
            msgMap.put("success",false);
            msgMap.put("message","验证码错误");
            return msgMap;
        }

        //session里头存的是上次登录的数据   本次登录的数据存入数据库
        String currentIp= IPUtil.getIpAddress(request);
        String IP=request.getRemoteAddr();


        //MD5
        //1 取出数据库中的数据
        Admin admin;

        admin=adminService.getAccount(username,password);


        Cookie[] cookies=request.getCookies();

        //是否勾选记住密码
        //记住密码

        if (admin==null){
            msgMap.put("success",false);//账号密码错误
            msgMap.put("message","账号密码错误");
            return msgMap;
        }
        else if(remember!=null) {

            //cookie免登录
            Cookie name=new Cookie("userName",username);
            Cookie pwd=new Cookie("password",password);
            name.setMaxAge(60 * 60 * 24 * 7);//当前 Cookie 一周内有效
            pwd.setMaxAge(60 * 60 * 24 * 7);//当前 Cookie 一周内有效
            response.addCookie(name);
            response.addCookie(pwd);
/*
            ObjectMapper objectMapper=new ObjectMapper();
            String jsonAdmin=objectMapper.writeValueAsString(admin);

            jsonAdmin = URLEncoder.encode(jsonAdmin,"utf-8");
            Cookie cookie=new Cookie("admin",jsonAdmin);
            response.addCookie(cookie);*/
        }
        else{//清除cookie
            for (Cookie cookie : cookies) {
                if ("userName".equals(cookie.getName())||"pwd".equals(cookie.getName())){
                    cookie.setMaxAge(0);//立即过期
                    response.addCookie(cookie);
                }
            }
        }


        //若账号已登录，先前账号被顶掉(结束先前的session)，新的session写入map
        //SessionUtil.checkUserExist(admin.getId());
        SessionUtil.map.put(admin.getId(),request.getSession());

        request.getSession().setAttribute("admin",admin);
        //2 更新本次登录后的数据
        adminService.updateLast(admin.getId(),currentIp);
        msgMap.put("success",true);//登录成功

        return msgMap;
    }

    /**
     * 注销登录
     * @param request
     * @return
     */
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        request.getSession().invalidate();
        return "redirect:/toLogin";
    }



    /**
     * 后台管理员列表渲染
     * @param response
     * @return
     * @throws JsonProcessingException
     */
    @RequestMapping(value="/adminLists",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String adminLists(String realName,String mobile,Integer role,Integer page,Integer limit,HttpServletResponse response) throws JsonProcessingException {

        LayUIMap map=adminService.getAdminLists(realName,mobile,role,page,limit);
        return map.getLayUIjson();
    }

    //修改密码
    @RequestMapping("/updatePwd")
    @ResponseBody
    public Map<String,Object> updatePwd(HttpServletRequest request,String oldPwd,String newPwd){
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        Map<String,Object> map=new HashMap<>();
        if (!admin.getPwd().equals(oldPwd)){
            map.put("success",false);
            map.put("message","原始密码错误");
        }
        else {
            adminService.updatePwd(admin.getAccount(),newPwd);
            admin.setPwd(newPwd);
            request.getSession().setAttribute("admin",admin);//更新session
            map.put("success",true);
            map.put("message","修改密码成功");
        }
        return map;
    }

    //头像上传
    @ResponseBody
    @RequestMapping("/avatarUpload")
    public Map<String,Object> imgUpload(HttpServletRequest request, MultipartFile picture){

        String tailPath="/upload/avatar";
        String imgUrl = ImgUploadUtils.imgUpload(request, tailPath, picture);
        Map<String,Object> map=new HashMap<>();
        map.put("code",0);
        map.put("msg","");
        Map<String,Object> data=new HashMap<>();
        data.put("src","");
        data.put("imgUrl",imgUrl);
        map.put("data",data);
        return map;
    }
    //更新个人信息
    @ResponseBody
    @RequestMapping("/updateAdminInfo")
    public Map<String, Object> updateAdminInfo(HttpServletRequest request, Admin admin) {
        //更新信息中不包含pwd
        Map<String, Object> map = new HashMap<>();
        if (adminService.updateAdminInfo(admin) > 0) {
            //更新session域中admin信息
            //获取最新的个人信息
            Admin sessionAdmin= (Admin) request.getSession().getAttribute("admin");
            Admin newAdmin=adminService.getAccount(sessionAdmin.getAccount(),sessionAdmin.getPwd());
            request.getSession().setAttribute("admin", newAdmin);
            map.put("success", true);
            map.put("message", "修改成功");
        } else {
            map.put("success", false);
            map.put("message", "修改失败");
        }
        return map;
    }
    //获得登录验证码
    @RequestMapping("/verifyCode")
    public void verifyCode(HttpServletRequest request,HttpServletResponse response){
        VerifyCode vc = new VerifyCode();
        BufferedImage image = vc.getImage();//获取一次性验证码图片
        // 该方法必须在getImage()方法之后来调用
        //		System.out.println(vc.getText());//获取图片上的文本
        try {
            VerifyCode.output(image, response.getOutputStream());//把图片写到指定流中
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 把文本保存到session中，为LoginServlet验证做准备
        request.getSession().setAttribute("vCode", vc.getText());//服务器生成的：vCode
    }

    //添加管理员
    @RequestMapping("/addAdmin")
    @ResponseBody
    public Map<String,Object> addAdmin(Admin admin){
        Map<String,Object> map=adminService.addAdmin(admin);
        return map;
    }

    //修改管理员角色
    @ResponseBody
    @RequestMapping("/changeRole")
    public Map<String,Object> changeRole(Integer id,Integer role){
        Map<String,Object> map=adminService.changeRole(id,role);
        return map;
    }


    //重置管理员密码
    @RequestMapping("/resetAdminPwd")
    @ResponseBody
    public Map<String,Object> resetAdminPwd(Integer id){
        Map<String,Object> map=adminService.resetAdminPwd(id,MD5Util.MD5("123456"));
        return map;
    }

    //删除管理员
    @RequestMapping("/delAdmin")
    @ResponseBody
    public Map<String,Object> editAdmin(Integer id){
        Map<String,Object> map=adminService.delAdmin(id);
        return map;
    }


}
