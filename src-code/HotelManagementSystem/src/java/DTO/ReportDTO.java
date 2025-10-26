/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Date;

/**
 *
 * @author Nguyễn Đại
 */
public class ReportDTO {
    private Date serviceDate;
    private String guestName;
    private int roomNumber;
    private String serviceName;
    private int quantity;
    private String status;
    private String assignedStaff;
    private String staffName;
    private int totalComplete;
    private double totalRevenue;
    private Date period;
    private int requestTime;

    public ReportDTO() {
    }
    
    

    public ReportDTO(Date serviceDate, String guestName, int roomNumber, String serviceName, int quantity, String status) {
        this.serviceDate = serviceDate;
        this.guestName = guestName;
        this.roomNumber = roomNumber;
        this.serviceName = serviceName;
        this.quantity = quantity;
        this.status = status;
    }

    public ReportDTO(String guestName, int roomNumber, String serviceName, int quantity, String assignedStaff, int requestTime) {
        this.guestName = guestName;
        this.roomNumber = roomNumber;
        this.serviceName = serviceName;
        this.quantity = quantity;
        this.assignedStaff = assignedStaff;
        this.requestTime = requestTime;
    }

    public ReportDTO(Date serviceDate, String serviceName, String staffName, int totalComplete) {
        this.serviceDate = serviceDate;
        this.serviceName = serviceName;
        this.staffName = staffName;
        this.totalComplete = totalComplete;
    }

    public ReportDTO(String serviceName, int quantity, double totalRevenue, Date period) {
        this.serviceName = serviceName;
        this.quantity = quantity;
        this.totalRevenue = totalRevenue;
        this.period = period;
    }

    public Date getServiceDate() {
        return serviceDate;
    }

    public void setServiceDate(Date serviceDate) {
        this.serviceDate = serviceDate;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAssignedStaff() {
        return assignedStaff;
    }

    public void setAssignedStaff(String assignedStaff) {
        this.assignedStaff = assignedStaff;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public int getTotalComplete() {
        return totalComplete;
    }

    public void setTotalComplete(int totalComplete) {
        this.totalComplete = totalComplete;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public Date getPeriod() {
        return period;
    }

    public void setPeriod(Date period) {
        this.period = period;
    }

    public int getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(int requestTime) {
        this.requestTime = requestTime;
    }
    
    
}
