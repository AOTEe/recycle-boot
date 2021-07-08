package com.recycle.dao;

import com.recycle.bean.RecycleSite;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecycleSiteDao {
    public int getSiteCount(@Param("siteName") String siteName,@Param("region") String region);

    public List<RecycleSite> getSiteList(@Param("siteName")String siteName,
                                         @Param("region")String region,
                                         @Param("index")Integer index,
                                         @Param("limit")Integer limit);

    public int delSiteById(Integer siteId);

    public int addSite(RecycleSite recycleSite);

    public int updateSite(RecycleSite recycleSite);

    public List<RecycleSite> getRecycleSites(Integer carrierId);
}
