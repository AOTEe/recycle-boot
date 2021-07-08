package com.recycle.service.impl;

import com.recycle.bean.RecycleSite;
import com.recycle.dao.RecycleSiteDao;
import com.recycle.service.SiteService;
import com.recycle.utils.LayUIMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SiteServiceImpl implements SiteService {

    @Autowired
    RecycleSiteDao recycleSiteDao;
    @Override
    public LayUIMap<RecycleSite> getSiteList(String siteName, String region, Integer page, Integer limit) {

        int count=recycleSiteDao.getSiteCount(siteName,region);
        List<RecycleSite> list=recycleSiteDao.getSiteList(siteName,region,(page-1)*limit,limit);
        LayUIMap<RecycleSite> siteData=new LayUIMap<>(count,list);

        return siteData;
    }

    @Override
    public int delCarById(Integer carId) {
        return recycleSiteDao.delSiteById(carId);
    }

    @Override
    public int update(RecycleSite recycleSite) {
        return recycleSiteDao.updateSite(recycleSite);
    }

    @Override
    public int addSite(RecycleSite recycleSite) {
        return recycleSiteDao.addSite(recycleSite);
    }
}
