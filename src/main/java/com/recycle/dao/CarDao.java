package com.recycle.dao;

import com.recycle.bean.Car;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CarDao {
    public List<Car> getCarList(@Param("carNum") String carNum,
                                @Param("region") String region,
                                @Param("state")Integer state,
                                @Param("pageCurrent") Integer page,@Param("pageSize") Integer limit);
    public int getCarCount(@Param("carNum") String carNum,@Param("region") String region,@Param("state")Integer state);

    public void delCarById(@Param("carId") Integer carId);

    public int addCar(@Param("carNum") String carNum,@Param("carType") String carType,@Param("region") String region);

    public int updateCar(Car car);

    public Car getCarByCarNum(@Param("carNum") String carNum);

    public List<String> getAvailableCars(Integer carrierId);

    public int changeCarState(@Param("carNum") String carNum, @Param("state") Integer state);

    public Car getCarExist(String carNum);
}
