/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.Manager_DTO;

import DTO.Basic_DTO.GuestDTO;
import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author Admin
 */
public class TopFrequentGuestDTO implements Serializable{

    private int guestID;
    private String fullName;
    private String phone;
    private String email;
    private String address;
    private String IDNumber;
    private Date dateOfBirth;
    private String username;
    private String password;
    private int bookingCount;
    private double money;

    //Constructor Full
    public TopFrequentGuestDTO(int guestID, String fullName, String phone, String email, String address, String IDNumber, Date dateOfBirth, String username, String password, int bookingCount, double money) {
        this.guestID = guestID;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.IDNumber = IDNumber;
        this.dateOfBirth = dateOfBirth;
        this.username = username;
        this.password = password;
        this.bookingCount = bookingCount;
        this.money = money;
    }

    //Constructor dung de phuc vu chuc nang hien thi top 10 frequent guest
    public TopFrequentGuestDTO(int guestID, String fullName, String phone, String email, int bookingCount) {
        this.guestID = guestID;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.bookingCount = bookingCount;
    }
    
    //Constructor dung de phuc vu chuc nang hien thi top 10 guest su dung tien nhieu nhat
    public TopFrequentGuestDTO(int guestID, String fullName, double money) {
        this.guestID = guestID;
        this.fullName = fullName;
        this.money = money;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
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

    public int getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(int bookingCount) {
        this.bookingCount = bookingCount;
    }
}
