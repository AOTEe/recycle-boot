package com.recycle.dao;

import com.recycle.bean.Admin;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface AdminDao {


    public Admin getAccount(@Param("account") String account,@Param("password") String password);

    public int updatePwd(@Param("account") String account,@Param("newPwd") String newPwd);

    public void updateLast(@Param("id")Integer id,@Param("currentIp") String currentIp);

    public int updateAdminInfo( Admin admin);

    public int getAdminCount(@Param("realName") String realName, @Param("mobile")String mobile,@Param("role") Integer role);

    public List<Admin> getAdminList(@Param("realName") String realName, @Param("mobile")String mobile,@Param("role") Integer role, @Param("index") Integer index,@Param("limit") Integer limit);

    public int accountExist(String account);

    public int addAdmin(Admin admin);

    public int delAdminById(Integer id);

    public int resetAdminPwd(@Param("id") Integer id,@Param("pwd")String pwd);

    public int changeRole(@Param("id") Integer id,@Param("role") Integer role);
}
