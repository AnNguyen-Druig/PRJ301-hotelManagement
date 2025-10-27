/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.RoomOccupancyDTO;
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
public class RoomOccupancyDAO {

    public ArrayList<RoomOccupancyDTO> getRoomOccupancyRatePerMonth(int month, int year) {
        ArrayList<RoomOccupancyDTO> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 10\n"
                        + "	r.RoomID, rt.TypeName, r.RoomNumber, rt.Capacity, rt.PricePerNight, MONTH(b.CheckInDate) AS Tháng, YEAR(b.CheckInDate) as Năm, COUNT(b.RoomID) AS RoomCount\n"
                        + "FROM ROOM r\n"
                        + "JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "JOIN BOOKING b ON r.RoomID = b.RoomID\n"
                        + "WHERE MONTH(b.CheckInDate) = ? AND YEAR(b.CheckInDate) = ?\n"
                        + "GROUP BY r.RoomID, rt.TypeName, r.RoomNumber, rt.Capacity, rt.PricePerNight, MONTH(b.CheckInDate), YEAR(b.CheckInDate)\n"
                        + "ORDER BY RoomCount DESC";
                PreparedStatement ps = cn.prepareStatement(sql);
                ps.setInt(1, month);
                ps.setInt(2, year);
                ResultSet table = ps.executeQuery();
                if(table != null) {
                    while(table.next()) {
                        int roomID = table.getInt("RoomID");
                        String typeName = table.getString("TypeName");
                        String roomNumber = table.getString("RoomNumber");
                        int capacity = table.getInt("Capacity");
                        double price = table.getDouble("PricePerNight");
                        int checkInMonth = table.getInt(month);
                        int checkInYear = table.getInt(year);
                        RoomOccupancyDTO room = new RoomOccupancyDTO(roomID, roomNumber, typeName, capacity, price, checkInMonth, checkInYear, roomID);
                        list.add(room);
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
