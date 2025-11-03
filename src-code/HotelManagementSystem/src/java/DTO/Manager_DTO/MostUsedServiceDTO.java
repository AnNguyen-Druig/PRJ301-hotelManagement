/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.Manager_DTO;

import java.io.Serializable;

/**
 *
 * @author Admin
 */
public class MostUsedServiceDTO implements Serializable{
    private int serviceId;
    private String serviceName;
    private String serviceType;
    private double price;
    private int countNumService;
    private float incomeService;

    //Constructor Full
    public MostUsedServiceDTO(int serviceId, String serviceName, String serviceType, double price, int countNumService, float incomeService) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceType = serviceType;
        this.price = price;
        this.countNumService = countNumService;
        this.incomeService = incomeService;
    }

    //Constructor để phục vụ chức năng xem Service nào được sử dụng nhiều nhất
    public MostUsedServiceDTO(int serviceId, String serviceName, String serviceType, int countNumService) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceType = serviceType;
        this.countNumService = countNumService;
    }
    
    //Constructor để phục vụ chức năng xem Service có doanh thu Cao/Thấp nhất
    public MostUsedServiceDTO(int serviceId, String serviceName, String serviceType, float incomeService) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceType = serviceType;
        this.incomeService = incomeService;
    }

    public float getIncomeService() {
        return incomeService;
    }

    public void setIncomeService(float incomeService) {
        this.incomeService = incomeService;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCountNumService() {
        return countNumService;
    }

    public void setCountNumService(int countNumService) {
        this.countNumService = countNumService;
    } 
}
