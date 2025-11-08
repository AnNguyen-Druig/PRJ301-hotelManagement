/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Service_DAO;

import DTO.Basic_DTO.BookingDTO;
import DTO.Service_DTO.GetBookingRoomForServiceDTO;
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
public class GetBookingRoomForServiceDAO {

    public ArrayList<GetBookingRoomForServiceDTO> getAllBookingRoom() {
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet table = null;
        ArrayList<GetBookingRoomForServiceDTO> result = new ArrayList<>();
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "Select B.BookingID, B.RoomID, G.FullName, B.CheckInDate, B.Status\n"
                        + "from dbo.BOOKING as B\n"
                        + "JOIN dbo.GUEST AS G ON B.GuestID = G.GuestID "
                        + "LEFT JOIN dbo.BOOKING_SERVICE AS BS ON BS.BookingID = B.BookingID "
                        + "Where B.Status = ?";
                st = cn.prepareStatement(sql);
                st.setString(1, "CheckIn");
                table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingID = table.getInt("BookingID");
                        int RoomID = table.getInt("RoomID");
                        String GuestName = table.getString("FullName");
                        Date CheckInDate = table.getDate("CheckInDate");
                        String Status = table.getString("Status");
                        GetBookingRoomForServiceDTO booking = new GetBookingRoomForServiceDTO(bookingID, RoomID, CheckInDate, Status, GuestName);
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
                if(st != null) {
                    st.close();
                }
                if(table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
