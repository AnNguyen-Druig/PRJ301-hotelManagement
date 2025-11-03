
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.Basic_DTO;

import java.sql.Date;

public class StaffDTO {

    private int staffID;
    private String fullName;
    private String role;
    private String userName;
    private String password; // Dùng để lưu passwordHash
    private String phone;
    private String email;
    private String address;
    private String idNumber;
    private Date dateOfBirth; // Cột mới
    private String status;
    //Đủ các thuộc tính

    // Constructor rỗng
    public StaffDTO() {
    }

    // Constructor đầy đủ (dùng cho DAO)
    public StaffDTO(int staffID, String fullName, String role, String userName, String password, String phone, String email, String address, String idNumber, Date dateOfBirth, String status) {
        this.staffID = staffID;
        this.fullName = fullName;
        this.role = role;
        this.userName = userName;
        this.password = password;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.idNumber = idNumber;
        this.dateOfBirth = dateOfBirth;
        this.status = status;
    }

    public StaffDTO(String fullName, String role, String userName, String password, String phone, String email, String address, String idNumber, Date dateOfBirth, String status) {
        this.fullName = fullName;
        this.role = role;
        this.userName = userName;
        this.password = password;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.idNumber = idNumber;
        this.dateOfBirth = dateOfBirth;
        this.status = status;
    }

    // --- Bắt đầu Getters and Setters ---
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
