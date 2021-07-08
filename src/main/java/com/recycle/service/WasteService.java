package com.recycle.service;

import com.recycle.bean.Waste;

import java.util.List;
import java.util.Map;

public interface WasteService {
    public int getWasteCount(String wasteName);

    public List<Waste> getWasteList(String wasteName, Integer currentPage, Integer pageSize);

    public int addWaste(Waste waste);

    public int delWasteById(String wasteId);

    public int updateWasteById(Waste waste);

    public List<String> getAllWasteName();

    public List<Waste> getAllWaste();

    public List<Map<String, Object>> getWasteData(String region);

    public List<Map<String, Object>> getRegionData(String region);
}
