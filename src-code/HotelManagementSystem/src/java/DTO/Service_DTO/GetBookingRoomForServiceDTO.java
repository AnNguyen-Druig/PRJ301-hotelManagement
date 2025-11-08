/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.Service_DTO;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class GetBookingRoomForServiceDTO {
    private int bookingID;
    private int roomID;
    private Date checkinDate;
    private String status;
    private String guestName;

    //Constructor Full
    public GetBookingRoomForServiceDTO(int bookingID, int roomID, Date checkinDate, String status, String guestName) {
        this.bookingID = bookingID;
        this.roomID = roomID;
        this.checkinDate = checkinDate;
        this.status = status;
        this.guestName = guestName;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public Date getCheckinDate() {
        return checkinDate;
    }

    public void setCheckinDate(Date checkinDate) {
        this.checkinDate = checkinDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }
}
