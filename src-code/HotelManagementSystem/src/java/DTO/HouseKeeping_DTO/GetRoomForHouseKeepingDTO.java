/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.HouseKeeping_DTO;

/**
 *
 * @author Admin
 */
public class GetRoomForHouseKeepingDTO {
    private int roomID;
    private String roomNumber;
    private String status;
    private String typeName;

    //Constructor Full
    public GetRoomForHouseKeepingDTO(int roomID, String roomNumber, String status, String typeName) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.status = status;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
    
}
