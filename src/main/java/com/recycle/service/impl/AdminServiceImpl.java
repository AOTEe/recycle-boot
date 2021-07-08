package com.recycle.service.impl;

import com.recycle.bean.Admin;
import com.recycle.dao.AdminDao;
import com.recycle.service.AdminService;
import com.recycle.utils.LayUIMap;
import com.recycle.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminDao adminDao;



    @Override
    public Admin getAccount(String account,String password){
        return adminDao.getAccount(account,password);
    }

    @Override
    public int updatePwd(String account, String newPwd) {
        return adminDao.updatePwd(account,newPwd);
    }

    @Override
    public void updateLast(Integer id,String currentIp) {
        adminDao.updateLast(id,currentIp);
    }

    @Override
    public int updateAdminInfo(Admin admin) {
        return adminDao.updateAdminInfo(admin);
    }

    @Override
    public LayUIMap getAdminLists(String realName, String mobile, Integer role, Integer page, Integer limit) {

        int count = adminDao.getAdminCount(realName, mobile, role);
        List<Admin> admins = adminDao.getAdminList(realName, mobile, role, (page - 1) * limit, limit);
        LayUIMap<Admin> map = new LayUIMap<>(count, admins);
        return map;
    }

    @Override
    public Map<String, Object> addAdmin(Admin admin) {
        Map<String, Object> map=new HashMap<>();
        map.put("success",true);
        map.put("message","添加成功");
        //验证用户名是否可用
        if (adminDao.accountExist(admin.getAccount())>0){
            map.put("success",false);
            map.put("message","用户名已存在");
            return map;
        }
        //***可提取出来作为常量***
        admin.setPwd(MD5Util.MD5("123456")); //设置默认密码
        admin.setAvatar("upload/avatar/default.jpg");//设置默认头像
        adminDao.addAdmin(admin);
        return map;
    }

    @Override
    public Map<String, Object> delAdmin(Integer id) {
        Map<String, Object> map=new HashMap<>();
        map.put("success",true);
        map.put("message","删除成功");

        adminDao.delAdminById(id);
        return map;
    }

    @Override
    public Map<String, Object> resetAdminPwd(Integer id,String pwd) {
        Map<String, Object> map=new HashMap<>();
        map.put("success",true);
        map.put("message","重置密码成功");

        adminDao.resetAdminPwd(id,pwd);
        return map;
    }

    @Override
    public Map<String, Object> changeRole(Integer id, Integer role) {
        Map<String, Object> map=new HashMap<>();
        map.put("success",true);
        map.put("message","操作成功");

        adminDao.changeRole(id,role);
        return map;
    }
}
