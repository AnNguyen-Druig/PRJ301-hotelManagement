/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.Manager_DTO;

import DTO.Basic_DTO.RoomDTO;
import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author Admin
 */
public class RoomOccupancyDTO implements Serializable {

    private int roomID;
    private String roomNumber;
    private String typeName;
    private int capacity;
    private double pricePerNight;
    private int roomCount;
    private int checkInMonth;
    private int checkInYear;

    //Constructor dùng để phục vụ chức năng hiển thị top 10 phòng đc đặt nhiều nhất
    public RoomOccupancyDTO(int roomID, String roomNumber, String typeName, int capacity, double pricePerNight, int checkInMonth, int checkInYear, int roomCount) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.typeName = typeName;
        this.capacity = capacity;
        this.pricePerNight = pricePerNight;
        this.checkInMonth = checkInMonth;
        this.checkInYear = checkInYear;
        this.roomCount = roomCount;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public int getCheckInMonth() {
        return checkInMonth;
    }

    public void setCheckInMonth(int checkInMonth) {
        this.checkInMonth = checkInMonth;
    }

    public int getCheckInYear() {
        return checkInYear;
    }

    public void setCheckInYear(int checkInYear) {
        this.checkInYear = checkInYear;
    }

    public int getRoomCount() {
        return roomCount;
    }

    public void setRoomCount(int roomCount) {
        this.roomCount = roomCount;
    }
}
