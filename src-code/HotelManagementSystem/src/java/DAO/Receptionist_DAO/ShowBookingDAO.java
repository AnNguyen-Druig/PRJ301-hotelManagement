/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Receptionist_DAO;

import DTO.Basic_DTO.BookingDTO;
import DTO.Receptionist_DTO.ShowBookingDTO;
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
public class ShowBookingDAO {

    //Hàm này dùng để hiển thị toàn bộ Booking với select 'All'
    public ArrayList<ShowBookingDTO> getAllBookingRoomGuest() {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        ArrayList<ShowBookingDTO> result = new ArrayList<>();
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT b.BookingID, g.GuestID, g.FullName, r.RoomID, r.RoomNumber, rt.TypeName, b.CheckInDate, b.CheckOutDate, b.BookingDate, b.Status "
                        + "FROM BOOKING b JOIN GUEST g ON b.GuestID = g.GuestID \n"
                        + "JOIN ROOM r ON b.RoomID = r.RoomID JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID";
                ps = cn.prepareStatement(sql);
                table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingID = table.getInt("BookingID");
                        int guestID = table.getInt("GuestID");
                        String guestName = table.getString("FullName");
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        String roomType = table.getString("TypeName");
                        Date checkInDate = table.getDate("CheckInDate");
                        Date checkOutDate = table.getDate("CheckOutDate");
                        Date bookingDate = table.getDate("BookingDate");
                        String Status = table.getString("Status");
                        ShowBookingDTO booking = new ShowBookingDTO(bookingID, guestID, roomID, checkInDate, checkOutDate, bookingDate, Status, guestName, roomNumber, roomType);
                        result.add(booking);
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
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    //Hàm này dùng để hiển thị các Booking phù hợp với status đc chọn
    public ArrayList<ShowBookingDTO> getBookingListByStatus(String status) {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        ArrayList<ShowBookingDTO> list = new ArrayList<>();
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT b.BookingID, g.GuestID, g.FullName, r.RoomID, r.RoomNumber, rt.TypeName, b.CheckInDate, b.CheckOutDate, b.BookingDate, b.Status "
                        + "FROM BOOKING b JOIN GUEST g ON b.GuestID = g.GuestID \n"
                        + "JOIN ROOM r ON b.RoomID = r.RoomID JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID WHERE b.Status = ?";
                ps = cn.prepareStatement(sql);
                ps.setString(1, status);
                table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingID = table.getInt("BookingID");
                        int guestID = table.getInt("GuestID");
                        String guestName = table.getString("FullName");
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        String roomType = table.getString("TypeName");
                        Date checkInDate = table.getDate("CheckInDate");
                        Date checkOutDate = table.getDate("CheckOutDate");
                        Date bookingDate = table.getDate("BookingDate");
                        ShowBookingDTO booking = new ShowBookingDTO(bookingID, guestID, roomID, checkInDate, checkOutDate, bookingDate, status, guestName, roomNumber, roomType);
                        list.add(booking);
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
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    //Hàm này dùng để hiển thị Booking trong phần Update trong role Reception
    //BookingDetail
    public ShowBookingDTO getBookingByBookingIDInReception(int bookingID) {
        Connection cn = null;
        ShowBookingDTO result = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT b.BookingID, g.GuestID, g.FullName, r.RoomID, r.RoomNumber, rt.RoomTypeID, rt.TypeName, b.CheckInDate, "
                        + "b.CheckOutDate, b.BookingDate, b.Status FROM BOOKING b JOIN GUEST g ON b.GuestID = g.GuestID \n"
                        + "JOIN ROOM r ON b.RoomID = r.RoomID JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "WHERE b.BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int guestID = table.getInt("GuestID");
                        String guestName = table.getString("FullName");
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        int roomTypeID = table.getInt("RoomTypeID");
                        String roomType = table.getString("TypeName");
                        Date checkInDate = table.getDate("CheckInDate");
                        Date checkOutDate = table.getDate("CheckOutDate");
                        Date bookingDate = table.getDate("BookingDate");
                        String status = table.getString("Status");
                        result = new ShowBookingDTO(bookingID, guestID, roomID, checkInDate, checkOutDate, bookingDate, status, guestName, roomNumber, roomType, roomTypeID);
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
