package com.recycle.service.impl;

import com.recycle.bean.Car;
import com.recycle.dao.CarDao;
import com.recycle.service.CarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class CarServiceImpl implements CarService {

    @Autowired
    CarDao carDao;

    @Override
    public List<Car> getCarList(String carNum,String region,Integer state,Integer page,Integer limit) {
        return carDao.getCarList(carNum,region,state,(page-1)*limit,limit);
    }

    @Override
    public int getCarCount(String carNum, String region,Integer state) {
        return carDao.getCarCount(carNum,region,state);
    }

    @Override
    public void delCarById(Integer carId) {
        carDao.delCarById(carId);
    }

    @Override
    public int addCar(String carNum, String carType,String region) {
       return carDao.addCar(carNum,carType,region);
    }

    @Override
    public int update(Car car) {
        return carDao.updateCar(car);
    }

    @Override
    public Car getCarExist(String carNum) {
        return carDao.getCarExist(carNum);
    }
}
