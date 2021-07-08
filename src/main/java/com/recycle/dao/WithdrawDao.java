package com.recycle.dao;

import com.recycle.bean.Withdraw;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WithdrawDao {
    int subWithdraw(@Param("userId") Integer userId, @Param("money") Double money);

    int updateWithdraw(@Param("withdrawId") Integer withdrawId,@Param("wxOrderno") String wxOrderno,@Param("adminId")Integer adminId);

    List<Withdraw> getWithdrawList(@Param("userId") Integer userId,@Param("adminId") Integer adminId,@Param("state") Integer state,@Param("index") Integer index,@Param("limit") Integer limit);

    int getWithdrawCount(@Param("userId") Integer userId, @Param("adminId") Integer adminId,@Param("state") Integer state);

    List<Withdraw> getUserWithdrawList(@Param("userId") Integer userId, @Param("state")Integer state,@Param("currentIndex") Integer currentIndex);

    int getUserWithdrawCount(@Param("userId") Integer userId, @Param("state")Integer state);
}
