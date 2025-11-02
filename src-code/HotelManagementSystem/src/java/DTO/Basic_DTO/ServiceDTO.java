/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.Basic_DTO;

import java.io.Serializable;

/**
 *
 * @author Nguyễn Đại
 */
public class ServiceDTO implements Serializable{
    private int serviceId;
    private String serviceName;
    private String serviceType;
    private double price;
    private int countNumService;
    private float incomeService;

    public ServiceDTO(int serviceId, String serviceName, String serviceType, double price) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceType = serviceType;
        this.price = price;
    }

    public ServiceDTO(int serviceId, String serviceName, String serviceType, int countNumService) {
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceType = serviceType;
        this.countNumService = countNumService;
    }

    public ServiceDTO(int serviceId, String serviceName, String serviceType, float incomeService) {
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

    public int getCountNumService() {
        return countNumService;
    }

    public void setCountNumService(int countNumService) {
        this.countNumService = countNumService;
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
    
    
}
