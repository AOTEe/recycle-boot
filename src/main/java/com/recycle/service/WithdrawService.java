package com.recycle.service;

import com.recycle.bean.Withdraw;
import com.recycle.bean.WxPage;
import com.recycle.utils.LayUIMap;

import java.util.Map;

public interface WithdrawService {
    Map<String, Object> subRequest(Integer userId, Double money);

    Map<String, Object> payWithdraw(Withdraw withdraw);

    LayUIMap<Withdraw> getList(Integer userId, Integer adminId,Integer state, Integer page, Integer limit);

    WxPage<Withdraw> getUserWithdraws(Integer userId, Integer state, Integer page);
}
