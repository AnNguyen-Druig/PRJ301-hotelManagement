/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author ASUS
 */
public class RoomDTO {

    private int roomID;
    private String roomNumber;
    private int roomTypeID;
    private String roomStatus;
    private String typeName;
    private int capacity;
    private double pricePerNight;

    public RoomDTO() {
    }

    public RoomDTO(int roomID, String roomNumber, int roomTypeID, String roomStatus, String typeName, int capacity, double pricePerNight) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.roomTypeID = roomTypeID;
        this.roomStatus = roomStatus;
        this.typeName = typeName;
        this.capacity = capacity;
        this.pricePerNight = pricePerNight;
    }

    public RoomDTO(String roomNumber, int roomTypeID, String roomStatus, String typeName, int capacity, double pricePerNight) {
        this.roomNumber = roomNumber;
        this.roomTypeID = roomTypeID;
        this.roomStatus = roomStatus;
        this.typeName = typeName;
        this.capacity = capacity;
        this.pricePerNight = pricePerNight;
    }

    public RoomDTO(int roomTypeID, String typeName) {
        this.roomTypeID = roomTypeID;
        this.typeName = typeName;
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

}
