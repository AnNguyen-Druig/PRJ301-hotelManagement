/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Guest_DAO;

import DTO.Basic_DTO.BookingDTO;
import DTO.Guest_DTO.BookingRoomDetailDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mylib.DBUtills;

/**
 *
 * @author ASUS
 */
public class BookingRoomDetailDAO {
    public ArrayList<BookingRoomDetailDTO> getActiveBookingRoomDetailByGuestID(int guestID) {
        Connection cn = null;
        ArrayList<BookingRoomDetailDTO> result = new ArrayList<>();
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT b.BookingID, g.GuestID, r.RoomID, b.CheckInDate,\n"
                        + "       b.CheckOutDate, b.BookingDate, b.Status,g.FullName, r.RoomNumber, rt.TypeName, rt.PricePerNight FROM BOOKING b \n"
                        + "INNER JOIN GUEST g ON b.GuestID = g.GuestID\n"
                        + "INNER JOIN ROOM r ON b.RoomID = r.RoomID \n"
                        + "INNER JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "WHERE g.GuestID = ? AND b.Status IN ('Reserved', 'CheckIn')";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, guestID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingID = table.getInt("BookingID");
                        int roomID = table.getInt("RoomID");
                        Date checkInDate = table.getDate("CheckInDate");
                        Date checkOutDate = table.getDate("CheckOutDate");
                        Date bookingDate = table.getDate("BookingDate");
                        String status = table.getString("Status");
                        String guestName = table.getString("FullName");    
                        String roomNumber = table.getString("RoomNumber");
                        String roomType = table.getString("TypeName");
                        double pricePerNight = table.getDouble("PricePerNight");
                        
                        BookingRoomDetailDTO bookingRoomDetail = new BookingRoomDetailDTO(bookingID, guestID, roomID, checkInDate, checkOutDate, bookingDate, status, guestName, roomNumber, roomType, pricePerNight);
                        result.add(bookingRoomDetail);
                    }
                }
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
    
     public BookingRoomDetailDTO getBookingRoomDetailByBookingID(int bookingID) {
        Connection cn = null;
        BookingRoomDetailDTO result = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT b.BookingID, g.GuestID, r.RoomID, b.CheckInDate,\n"
                        + "       b.CheckOutDate, b.BookingDate, b.Status,g.FullName, r.RoomNumber, rt.TypeName, rt.PricePerNight FROM BOOKING b \n"
                        + "INNER JOIN GUEST g ON b.GuestID = g.GuestID\n"
                        + "INNER JOIN ROOM r ON b.RoomID = r.RoomID \n"
                        + "INNER JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "WHERE b.BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int guestID = table.getInt("GuestID");
                        int roomID = table.getInt("RoomID");
                        Date checkInDate = table.getDate("CheckInDate");
                        Date checkOutDate = table.getDate("CheckOutDate");
                        Date bookingDate = table.getDate("BookingDate");
                        String status = table.getString("Status");
                        String guestName = table.getString("FullName");    
                        String roomNumber = table.getString("RoomNumber");
                        String roomType = table.getString("TypeName");
                        double pricePerNight = table.getDouble("PricePerNight");
                        
                        result = new BookingRoomDetailDTO(bookingID, guestID, roomID, checkInDate, checkOutDate, bookingDate, status, guestName, roomNumber, roomType, pricePerNight);
                    }
                }
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
