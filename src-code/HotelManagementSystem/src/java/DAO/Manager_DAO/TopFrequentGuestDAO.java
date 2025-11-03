/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Manager_DAO;

import DTO.Manager_DTO.TopFrequentGuestDTO;
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
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "  SELECT TOP 10	g.GuestID, g.FullName, g.Phone, g.Email, COUNT(b.BookingID) as BookingCount \n"
                        + "  FROM GUEST g JOIN BOOKING b ON g.GuestID = b.GuestID\n"
                        + "  WHERE b.Status IN ('Reserved','CheckIn','CheckOut','Complete')\n"
                        + "  GROUP BY g.GuestID, g.FullName, g.Phone, g.Email\n"
                        + "  ORDER BY BookingCount DESC";
                ps = cn.prepareStatement(sql);
                table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
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

    public ArrayList<TopFrequentGuestDTO> getGuestHighestMoney() {
        ArrayList<TopFrequentGuestDTO> list = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 10 g.GuestID, g.FullName, SUM(i.TotalAmount) as [Tổng tiền tiêu dùng]\n"
                        + "FROM GUEST g \n"
                        + "JOIN BOOKING b ON g.GuestID = b.GuestID\n"
                        + "JOIN INVOICE i ON b.BookingID = i.BookingID\n"
                        + "GROUP BY g.GuestID, g.FullName\n"
                        + "ORDER BY [Tổng tiền tiêu dùng] DESC";
                ps = cn.prepareStatement(sql);
                table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int guestID = table.getInt("GuestID");
                        String guestName = table.getString("FullName");
                        double money = table.getDouble("Tổng tiền tiêu dùng");
                        TopFrequentGuestDTO guest = new TopFrequentGuestDTO(guestID, guestName, money);
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
}
