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
public class RoomOccupancyDTO extends RoomDTO{
    private int roomCount;
    private int checkInMonth;
    private int checkInYear;

    public RoomOccupancyDTO() {
        super();
    }

    public RoomOccupancyDTO(int roomID, String roomNumber, String typeName, int capacity, double pricePerNight, int checkInMonth, int checkInYear, int roomCount) {
        super(roomID, roomNumber, typeName, capacity, pricePerNight);
        this.checkInMonth = checkInMonth;
        this.checkInYear = checkInYear;
        this.roomCount = roomCount;
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
