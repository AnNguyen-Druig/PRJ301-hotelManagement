/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.TopFrequentGuestDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mylib.DBUtills;

/**
 *
 * @author Admin
 */
public class TopFrequentGuestDAO {

    public ArrayList<TopFrequentGuestDTO> getTop10FrequentGuest() {
        ArrayList<TopFrequentGuestDTO> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 10\n"
                        + "	g.GuestID, g.FullName, g.Phone, g.Email, COUNT(b.BookingID) as BookingCount\n"
                        + "FROM GUEST g\n"
                        + "JOIN BOOKING b ON g.GuestID = b.GuestID\n"
                        + "GROUP BY g.GuestID, g.FullName, g.Phone, g.Email\n"
                        + "ORDER BY BookingCount DESC";
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet table = ps.executeQuery();
                if(table != null) {
                    while(table.next()) {
                        int guestID = table.getInt("GuestID");
                        String guestName = table.getString("FullName");
                        String phone = table.getString("Phone");
                        String email = table.getString("Email");
                        int bookingCount = table.getInt("BookingCount");
                        TopFrequentGuestDTO guest = new TopFrequentGuestDTO(guestID, guestName, phone, email, bookingCount);
                        list.add(guest);
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
        return list;
    }
}
