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
public class GuestDTO {
    private int guestID;
    private String fullName;
    private String phone;
    private String email;
    private String address;
    private String IDNumber;
    private Date dateOfBirth;
    private String username;
    private String password;

    public GuestDTO() {
    }

    public GuestDTO(int guestID, String fullName, String phone, String email, String address, String IDNumber, Date dateOfBirth, String username, String password) {
        this.guestID = guestID;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.IDNumber = IDNumber;
        this.dateOfBirth = dateOfBirth;
        this.username = username;
        this.password = password;
    }
    
    public GuestDTO(String fullName, String phone, String email, String address, String IDNumber, Date dateOfBirth, String username, String password) {
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.IDNumber = IDNumber;
        this.dateOfBirth = dateOfBirth;
        this.username = username;
        this.password = password;
    }

    public GuestDTO(int guestID, String fullName, String phone, String email, String address, Date dateOfBirth, String username, String password) {
        this.guestID = guestID;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.username = username;
        this.password = password;
    }
    
    

    public int getGuestID() {
        return guestID;
    }

    public void setGuestID(int guestID) {
        this.guestID = guestID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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

    public String getIDNumber() {
        return IDNumber;
    }

    public void setIDNumber(String IDNumber) {
        this.IDNumber = IDNumber;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    
}
