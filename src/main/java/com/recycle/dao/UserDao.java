package com.recycle.dao;

import com.recycle.bean.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {
    public User findByUserId(Integer userId);//这个不加

    public User findByOpenid(String openId);

    public int addUser(User user);

    public int updateUserInfo(User user);

    public int getUserCount(@Param("userId") Integer userId);//这个为啥加

    public List<User> getUserList(@Param("userId") Integer userId,@Param("index") Integer index,@Param("limit") Integer limit);

    public int restMoneyDown(@Param("userId") Integer userId,@Param("money") Double money);

    public int addRestMoney(@Param("price") Double price,@Param("userId") Integer userId);
}
