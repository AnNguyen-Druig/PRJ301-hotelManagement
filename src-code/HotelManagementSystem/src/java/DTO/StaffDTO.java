/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author Admin
 */
public class StaffDTO {
    private int staffID;
    private String fullName;
    private String role;
    private String userName;
    private String password;
    private String phone;
    private String email;

    public StaffDTO() {
        this.staffID = 0;
        this.fullName = "";
        this.role = "";
        this.userName = "";
        this.password = "";
        this.phone = "";
        this.email = "";
    }

    public StaffDTO(int staffID, String fullName, String role, String userName, String password, String phone, String email) {
        this.staffID = staffID;
        this.fullName = fullName;
        this.role = role;
        this.userName = userName;
        this.password = password;
        this.phone = phone;
        this.email = email;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
    
}
