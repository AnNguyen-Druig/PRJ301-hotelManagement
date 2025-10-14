/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.BookingDTO;
import DTO.GuestDTO;
import DTO.RoomDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import mylib.DBUtills;

/**
 *
 * @author Admin
 */
public class BookingDAO {

    public int saveBookingRoom(BookingDTO booking) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO dbo.BOOKING (GuestID, RoomID, CheckInDate, CheckOutDate, BookingDate, Status)\n"
                        + "VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, booking.getGuestID());
                st.setInt(2, booking.getRoomID());
                st.setDate(3, booking.getCheckInDate());
                st.setDate(4, booking.getCheckOutDate());
                st.setDate(5, booking.getBookingDate());
                st.setString(6, booking.getStatus());
                result = st.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }
    
    

}
