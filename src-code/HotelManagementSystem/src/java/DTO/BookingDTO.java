/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class BookingDTO {

    private int bookingID;
    private int guestID;
    private int roomID;
    private Date checkInDate;
    private Date checkOutDate;
    private Date bookingDate;
    private String status;
    private String guestName;
    private String roomNumber;
    private String roomType;
    private int roomTypeID;

    public BookingDTO() {
    }

    //Constructor-full
    public BookingDTO(int bookingID, int guestID, int roomID, Date checkInDate, Date checkOutDate, Date bookingDate, String status, String guestName, String roomNumber, String roomType, int roomTypeID) {
        this.bookingID = bookingID;
        this.guestID = guestID;
        this.roomID = roomID;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.bookingDate = bookingDate;
        this.status = status;
        this.guestName = guestName;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
        this.roomTypeID = roomTypeID;
    }

    public BookingDTO(int bookingID, int guestID, int roomID, Date checkInDate, Date checkOutDate, Date bookingDate, String status, String guestName, String roomNumber, String roomType) {
        this.bookingID = bookingID;
        this.guestID = guestID;
        this.roomID = roomID;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.bookingDate = bookingDate;
        this.status = status;
        this.guestName = guestName;
        this.roomNumber = roomNumber;
        this.roomType = roomType;
    }

    public BookingDTO(int bookingID, int roomID) {
        this.bookingID = bookingID;
        this.roomID = roomID;
    }

    public BookingDTO(int bookingID, int guestID, int roomID, Date checkInDate, Date checkOutDate, Date bookingDate, String status) {
        this.bookingID = bookingID;
        this.guestID = guestID;
        this.roomID = roomID;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.bookingDate = bookingDate;
        this.status = status;
    }

    public BookingDTO(int bookingID, int roomID, Date checkInDate, String status, String guestName) {
        this.bookingID = bookingID;
        this.roomID = roomID;
        this.checkInDate = checkInDate;
        this.status = status;
        this.guestName = guestName;
    }

    public BookingDTO(int guestID, int roomID, Date checkInDate, Date checkOutDate, Date bookingDate, String status) {
        this.guestID = guestID;
        this.roomID = roomID;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.bookingDate = bookingDate;
        this.status = status;
    }

    public BookingDTO(int bookingID, int roomID, Date checkInDate, Date checkOutDate) {
        this.bookingID = bookingID;
        this.roomID = roomID;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    public BookingDTO(int bookingID, int roomID, Date checkInDate, Date checkOutDate, String status) {
        this.bookingID = bookingID;
        this.roomID = roomID;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.status = status;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getGuestID() {
        return guestID;
    }

    public void setGuestID(int guestID) {
        this.guestID = guestID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
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

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public int getRoomTypeID() {
        return roomTypeID;
    }

    public void setRoomTypeID(int roomTypeID) {
        this.roomTypeID = roomTypeID;
    }

}
