/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.Basic_DTO;

import java.sql.Date;

/**
 *
 * @author ASUS
 */
public class BookingServiceDTO {
    private int bookingServiceID;
    private int bookingID;
    private int serviceID;
    private int quantity;
    private Date serviceDate;
    private String status;
    private int AssignedStaff;

    public BookingServiceDTO() {
    }

    public BookingServiceDTO(int bookingServiceID, int bookingID, int serviceID, int quantity, Date serviceDate, String status, int AssignedStaff) {
        this.bookingServiceID = bookingServiceID;
        this.bookingID = bookingID;
        this.serviceID = serviceID;
        this.quantity = quantity;
        this.serviceDate = serviceDate;
        this.status = status;
        this.AssignedStaff = AssignedStaff;
    }

    public int getBookingServiceID() {
        return bookingServiceID;
    }

    public void setBookingServiceID(int bookingServiceID) {
        this.bookingServiceID = bookingServiceID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getServiceDate() {
        return serviceDate;
    }

    public void setServiceDate(Date serviceDate) {
        this.serviceDate = serviceDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getAssignedStaff() {
        return AssignedStaff;
    }

    public void setAssignedStaff(int AssignedStaff) {
        this.AssignedStaff = AssignedStaff;
    }
    
    
}
