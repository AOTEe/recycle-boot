package com.recycle.service.impl;

import com.recycle.bean.Waste;
import com.recycle.dao.WasteDao;
import com.recycle.service.WasteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class WasteServiceImpl implements WasteService {


    @Autowired
    WasteDao wasteDao;

    @Override
    public int getWasteCount(String wasteName) {
        return wasteDao.getWasteCount(wasteName);
    }

    @Override
    public List<Waste> getWasteList(String wasteName, Integer currentPage, Integer pageSize) {
        return wasteDao.getWasteList(wasteName,currentPage,pageSize);
    }

    @Override
    public int addWaste(Waste waste) {
        return wasteDao.addWaste(waste);
    }

    @Override
    public int delWasteById(String wasteId) {
        return wasteDao.delWasteById(wasteId);
    }

    @Override
    public int updateWasteById(Waste waste) {
        return wasteDao.updateWasteById(waste);
    }
    @Override
    public List<String> getAllWasteName(){
        return wasteDao.getAllWasteName();
    }

    @Override
    public List<Waste> getAllWaste() {
        return wasteDao.getAllWaste();
    }

    @Override
    public List<Map<String, Object>> getWasteData(String region) {
        return wasteDao.getWasteData(region);
    }

    @Override
    public List<Map<String, Object>> getRegionData(String region) {
        return wasteDao.getRegionData(region);
    }
}
