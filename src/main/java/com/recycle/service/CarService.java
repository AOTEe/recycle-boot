package com.recycle.service;

import com.recycle.bean.Car;

import java.util.List;

public interface CarService {

    public List<Car> getCarList(String carNum,String region,Integer state,Integer page,Integer limit);

    public int getCarCount(String carNum,String region,Integer state);

    public void delCarById(Integer carId);

    public int addCar(String carNum,String carType,String region);

    public int update(Car car);

    public Car getCarExist(String carNum);
}
