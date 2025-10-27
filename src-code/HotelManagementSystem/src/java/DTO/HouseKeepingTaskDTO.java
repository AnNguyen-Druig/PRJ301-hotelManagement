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
public class HouseKeepingTaskDTO {
    private int taskID;
    private int roomID;
    private String assignedStaff;
    private Date taskDate;
    private String cleaningType;
    private String status;

    public HouseKeepingTaskDTO(int taskID, int roomID, String assignedStaff, Date taskDate, String cleaningType, String status) {
        this.taskID = taskID;
        this.roomID = roomID;
        this.assignedStaff = assignedStaff;
        this.taskDate = taskDate;
        this.cleaningType = cleaningType;
        this.status = status;
    }

    public int getTaskID() {
        return taskID;
    }

    public void setTaskID(int taskID) {
        this.taskID = taskID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getAssignedStaff() {
        return assignedStaff;
    }

    public void setAssignedStaff(String assignedStaff) {
        this.assignedStaff = assignedStaff;
    }

    public Date getTaskDate() {
        return taskDate;
    }

    public void setTaskDate(Date taskDate) {
        this.taskDate = taskDate;
    }

    public String getCleaningType() {
        return cleaningType;
    }

    public void setCleaningType(String cleaningType) {
        this.cleaningType = cleaningType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
