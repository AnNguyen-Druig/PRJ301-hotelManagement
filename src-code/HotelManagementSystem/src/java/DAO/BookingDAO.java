/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.BookingDTO;
import DTO.GuestDTO;
import DTO.RoomDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
    
    public ArrayList<BookingDTO> getBookingRoom(){
        Connection cn = null;
        ArrayList<BookingDTO> result = new ArrayList<>(); 
        try{
            cn = DBUtills.getConnection();
            if(cn != null){
                String sql = "Select B.BookingID, B.RoomID, G.FullName, B.CheckInDate, B.Status\n"
                        + "from dbo.BOOKING as B\n"
                        + "JOIN dbo.GUEST AS G ON B.GuestID = G.GuestID "
                        + "LEFT JOIN dbo.BOOKING_SERVICE AS BS ON BS.BookingID = B.BookingID "
                        + "Where B.Status = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "CheckIn");
                ResultSet table = st.executeQuery();
                if(table != null){
                    while(table.next()){
                        int bookingID = table.getInt("BookingID");
                        int RoomID = table.getInt("RoomID");
                        String GuestName = table.getString("FullName");
                        Date CheckInDate = table.getDate("CheckInDate");
                        String Status = table.getString("Status");
                        BookingDTO booking = new BookingDTO(bookingID, RoomID, CheckInDate, Status, GuestName);
                        result.add(booking);
                    }
                }
            }
        }catch (Exception e) {
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
