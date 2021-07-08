package com.recycle.bean;

public class Car {
    private Integer carId;
    private String carNum;
    private String region;
    private Integer state;

    public Car() {
    }

    public Car(Integer carId, String carNum, String region, Integer state) {
        this.carId = carId;
        this.carNum = carNum;
        this.region = region;
        this.state = state;
    }

    public Integer getCarId() {
        return carId;
    }

    public void setCarId(Integer carId) {
        this.carId = carId;
    }

    public String getCarNum() {
        return carNum;
    }

    public void setCarNum(String carNum) {
        this.carNum = carNum;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return "Car{" +
                "carId=" + carId +
                ", carNum='" + carNum + '\'' +
                ", region='" + region + '\'' +
                ", state=" + state +
                '}';
    }
}
