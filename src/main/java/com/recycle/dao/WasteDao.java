package com.recycle.dao;

import com.recycle.bean.Waste;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface WasteDao {
    public int getWasteCount(@Param("wasteName") String wasteName);

    public List<Waste> getWasteList(@Param("wasteName") String wasteName,
                                    @Param("currentPage") Integer currentPage,@Param("pageSize") Integer pageSize);


    public int addWaste(Waste waste);

    public int delWasteById(String wasteId);

    public int updateWasteById(Waste waste);

    public Waste findByWasteId(Integer wasteId);

    public List<String> getAllWasteName();

    public List<Waste> getAllWaste();

    //public List<Waste> getWasteListByWasteIds(List<Integer> wasteIds);

    public Waste getWasteListById(Integer wasteId);

    /*<!--获取上个月完成订单的不同废品的成交金额-->*/
    public List<Map<String,Object>> getWasteData(String region);

    //上个月各地区的回收废品重量
    public List<Map<String, Object>> getRegionData(String region);
}
