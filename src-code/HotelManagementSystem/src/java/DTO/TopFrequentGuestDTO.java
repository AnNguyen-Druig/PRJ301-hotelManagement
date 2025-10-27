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
public class TopFrequentGuestDTO extends GuestDTO{
    private int bookingCount;

    public TopFrequentGuestDTO() {
        super();
    }

    public TopFrequentGuestDTO(int bookingCount) {
        this.bookingCount = bookingCount;
    }

    public TopFrequentGuestDTO(int guestID, String fullName, String phone, String email, int bookingCount) {
        super(guestID, fullName, phone, email);
        this.bookingCount = bookingCount;
    }

    public int getBookingCount() {
        return bookingCount;
    }

    public void setBookingCount(int bookingCount) {
        this.bookingCount = bookingCount;
    }
}
