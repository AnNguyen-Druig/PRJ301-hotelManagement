/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.Manager_DTO.RoomOccupancyDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import mylib.DBUtills;

/**
 *
 * @author Admin
 */
public class RoomOccupancyDAO {

    //Hàm này dùng để hiển thị top 10 phòng đc sử dụng nhiều nhất
    public ArrayList<RoomOccupancyDTO> getRoomOccupancyRatePerMonth(int month, int year) {
        ArrayList<RoomOccupancyDTO> list = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 10\n"
                        + "	r.RoomID, rt.TypeName, r.RoomNumber, rt.Capacity, rt.PricePerNight, MONTH(b.CheckInDate) AS Tháng, YEAR(b.CheckInDate) as Năm, COUNT(b.RoomID) AS RoomCount\n"
                        + "FROM ROOM r\n"
                        + "JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "JOIN BOOKING b ON r.RoomID = b.RoomID\n"
                        + "WHERE MONTH(b.CheckInDate) = ? AND YEAR(b.CheckInDate) = ?\n"
                        + "AND b.Status IN ('Reserved', 'CheckIn', 'CheckOut', 'Complete')\n"
                        + "GROUP BY r.RoomID, rt.TypeName, r.RoomNumber, rt.Capacity, rt.PricePerNight, MONTH(b.CheckInDate), YEAR(b.CheckInDate)\n"
                        + "ORDER BY RoomCount DESC";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, month);
                ps.setInt(2, year);
                table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomID = table.getInt("RoomID");
                        String typeName = table.getString("TypeName");
                        String roomNumber = table.getString("RoomNumber");
                        int capacity = table.getInt("Capacity");
                        double price = table.getDouble("PricePerNight");
                        int checkInMonth = table.getInt("Tháng");
                        int checkInYear = table.getInt("Năm");
                        int roomCount = table.getInt("RoomCount");
                        RoomOccupancyDTO room = new RoomOccupancyDTO(roomID, roomNumber, typeName, capacity, price, checkInMonth, checkInYear, roomCount);
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

    //Hàm này được sử dụng để hiển thị Số phòng khách sạn hiện có
    public int countTotalRoom() {
        int result = 0;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT COUNT(RoomID) as [Tổng số phòng] FROM ROOM";
            ps = cn.prepareStatement(sql);
            table = ps.executeQuery();
            if (table != null && table.next()) {
                int totalBooking = table.getInt("Tổng số phòng");
                result = totalBooking;
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

    //Hàm này được sử dụng để hiển thị số phòng tương ứng với từng loại RoomType
    public Map<String, Integer> countTotalRoomByRoomType() {
        Map<String, Integer> list = new LinkedHashMap<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT rt.TypeName, COUNT(r.RoomID) as [Tổng số phòng] FROM ROOM r JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID "
                    + "GROUP BY rt.TypeName ORDER BY [Tổng số phòng] DESC";
            ps = cn.prepareStatement(sql);
            table = ps.executeQuery();
            if (table != null) {
                while (table.next()) {
                    String typeName = table.getString("TypeName");
                    int totalRoom = table.getInt("Tổng số phòng");
                    list.put(typeName, totalRoom);
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

    //Hàm này được dùng để hiển thị phần 4. Tỷ lệ phòng được đặt (Tháng/Năm)
    public Map<String, Object> getMonthlyOccupancyPercentage(int month, int year) {
        Map<String, Object> list = new HashMap<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "WITH MonthlyBookedRooms AS ("
                        + " SELECT COUNT(DISTINCT RoomID) AS [Số phòng đang được đặt] "
                        + " FROM BOOKING "
                        + " WHERE MONTH(CheckInDate) = ? AND YEAR(CheckInDate) = ? "
                        + " AND Status IN ('Reserved', 'CheckIn', 'Complete', 'CheckOut')"
                        + "), "
                        + "TotalHotelRooms AS ("
                        + " SELECT COUNT(RoomID) AS [Tổng số phòng] FROM ROOM"
                        + ") "
                        + "SELECT "
                        + " ISNULL(m.[Số phòng đang được đặt], 0) AS [Số phòng đang được đặt], "
                        + " t.[Tổng số phòng], "
                        + " CASE "
                        + "     WHEN t.[Tổng số phòng] = 0 THEN 0.0 "
                        + "     ELSE (CAST(ISNULL(m.[Số phòng đang được đặt], 0) AS DECIMAL(10, 2)) * 100.0 / t.[Tổng số phòng]) "
                        + " END AS [Tỷ lệ phòng được đặt] "
                        + "FROM TotalHotelRooms t, MonthlyBookedRooms m";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, month);
                ps.setInt(2, year);
                table = ps.executeQuery();
                if (table != null && table.next()) {
                    list.put("Số phòng đang được đặt", table.getInt("Số phòng đang được đặt"));
                    list.put("Tổng số phòng", table.getInt("Tổng số phòng"));
                    list.put("Tỷ lệ phòng được đặt", table.getDouble("Tỷ lệ phòng được đặt"));
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
        return list; // Trả về Map (có thể rỗng nếu có lỗi)
    }
}
