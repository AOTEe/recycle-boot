package com.recycle.service.impl;

import com.recycle.bean.User;
import com.recycle.bean.Withdraw;
import com.recycle.bean.WxPage;
import com.recycle.dao.UserDao;
import com.recycle.dao.WithdrawDao;
import com.recycle.service.WithdrawService;
import com.recycle.utils.LayUIMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class WithdrawServiceImpl implements WithdrawService {
    @Autowired
    UserDao userDao;
    @Autowired
    WithdrawDao withdrawDao;

    @Transactional
    @Override
    public Map<String, Object> subRequest(Integer userId, Double money) {
        Map<String, Object> map=new HashMap<>();
        //余额是否充足
        User user = userDao.findByUserId(userId);
        if (user.getRestMoney()<money){
            map.put("success",false);
            map.put("message","余额不足");
        }
        else {
            //扣除用户余额
            userDao.restMoneyDown(userId,money);
            //生成一条提现记录
            withdrawDao.subWithdraw(userId,money);
            map.put("success",true);
            map.put("message","成功发起提现请求");
        }
        return map;
    }


    @Override
    public Map<String, Object> payWithdraw(Withdraw withdraw) {
        Map<String, Object> map=new HashMap<>();
        //更新提现表
        withdrawDao.updateWithdraw(withdraw.getWithdrawId(),withdraw.getWxOrderno(),withdraw.getAdminId());

        map.put("success",true);
        map.put("message","用户提现完成");
        return map;
    }

    @Override
    public LayUIMap<Withdraw> getList(Integer userId, Integer adminId,Integer state, Integer page, Integer limit) {
        int count=withdrawDao.getWithdrawCount(userId,adminId,state);
        List<Withdraw> list=withdrawDao.getWithdrawList(userId,adminId,state,(page-1)*limit,limit);

        LayUIMap<Withdraw> map=new LayUIMap<>(count,list);
        return map;
    }

    @Override
    public WxPage<Withdraw> getUserWithdraws(Integer userId, Integer state, Integer page) {
        WxPage<Withdraw> withdrawWxPage=new WxPage<>();
        int count=withdrawDao.getUserWithdrawCount(userId,state);
        withdrawWxPage.setPageIndex(page);
        withdrawWxPage.setTotalCount(count);
        withdrawWxPage.setPageTotalCount();
        List<Withdraw> list=withdrawDao.getUserWithdrawList(userId,state,withdrawWxPage.getCurrentIndex(page));
        withdrawWxPage.setList(list);
        return withdrawWxPage;
    }
}
