package com.recycle.service;

import com.recycle.bean.Admin;
import com.recycle.utils.LayUIMap;

import java.util.Map;

public interface AdminService {



    public Admin getAccount(String account,String password);

    public int updatePwd(String account, String newPwd);

    public void updateLast(Integer id,String currentIp);

    public int updateAdminInfo(Admin admin);

    public LayUIMap getAdminLists(String realName, String mobile, Integer role, Integer page, Integer limit);

    public Map<String, Object> addAdmin(Admin admin);

    public Map<String, Object> delAdmin(Integer id);

    public Map<String, Object> resetAdminPwd(Integer id,String pwd);

    public Map<String, Object> changeRole(Integer id, Integer role);
}
