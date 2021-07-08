package com.recycle.service;

import com.recycle.bean.RecycleSite;
import com.recycle.utils.LayUIMap;

public interface SiteService {
    public LayUIMap<RecycleSite> getSiteList(String siteName, String region, Integer page, Integer limit);

    public int delCarById(Integer carId);

    public int update(RecycleSite recycleSite);

    public int addSite(RecycleSite recycleSite);
}
