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
public class HouseKeepingReportDTO {
    private Date date;
    private int roomNumber;
    private String cleaningType;
    private String staffName;
    private String status;
    private int priority;
    private int staffId;
    private String  roomType;
    private Date checkIn;
    private String IssueDescription;
    private int roomCleaned;
    private int deepCleanings;

    public HouseKeepingReportDTO(Date date, int roomNumber, String cleaningType, String staffName, String status) {
        this.date = date;
        this.roomNumber = roomNumber;
        this.cleaningType = cleaningType;
        this.staffName = staffName;
        this.status = status;
    }

    public HouseKeepingReportDTO(int roomNumber, String staffName, String status, int priority) {
        this.roomNumber = roomNumber;
        this.staffName = staffName;
        this.status = status;
        this.priority = priority;
    }

    public HouseKeepingReportDTO(Date date, int roomNumber, String status, String roomType, Date checkIn) {
        this.date = date;
        this.roomNumber = roomNumber;
        this.status = status;
        this.roomType = roomType;
        this.checkIn = checkIn;
    }

    public HouseKeepingReportDTO(Date date, String staffName, int roomCleaned, int deepCleanings) {
        this.date = date;
        this.staffName = staffName;
        this.roomCleaned = roomCleaned;
        this.deepCleanings = deepCleanings;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(int roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getCleaningType() {
        return cleaningType;
    }

    public void setCleaningType(String cleaningType) {
        this.cleaningType = cleaningType;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public Date getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(Date checkIn) {
        this.checkIn = checkIn;
    }

    public String getIssueDescription() {
        return IssueDescription;
    }

    public void setIssueDescription(String IssueDescription) {
        this.IssueDescription = IssueDescription;
    }

    public int getRoomCleaned() {
        return roomCleaned;
    }

    public void setRoomCleaned(int roomCleaned) {
        this.roomCleaned = roomCleaned;
    }

    public int getDeepCleanings() {
        return deepCleanings;
    }

    public void setDeepCleanings(int deepCleanings) {
        this.deepCleanings = deepCleanings;
    }
    
    
}
