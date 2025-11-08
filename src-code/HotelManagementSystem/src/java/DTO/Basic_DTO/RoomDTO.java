/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.Basic_DTO;

/**
 *
 * @author ASUS
 */
public class RoomDTO {

    private int roomID;
    private String roomNumber;
    private int roomTypeID;
    private String roomStatus;

    public RoomDTO() {
    }

    //Constructor Full
    public RoomDTO(int roomID, String roomNumber, int roomTypeID, String roomStatus) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.roomTypeID = roomTypeID;
        this.roomStatus = roomStatus;
    }

    public RoomDTO(int roomID, String roomNumber) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
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

    public int getRoomTypeID() {
        return roomTypeID;
    }

    public void setRoomTypeID(int roomTypeID) {
        this.roomTypeID = roomTypeID;
    }

    public String getRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(String roomStatus) {
        this.roomStatus = roomStatus;
    }
}
