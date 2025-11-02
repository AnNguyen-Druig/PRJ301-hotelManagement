/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.RoomDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeMap;
import mylib.DBUtills;

/**
 *
 * @author ASUS
 */
public class RoomDAO {

    public ArrayList<RoomDTO> getAllRooms() {
        ArrayList<RoomDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM dbo.ROOM AS r\n"
                        + "INNER JOIN dbo.ROOM_TYPE AS rt ON rt.RoomTypeID = r.RoomTypeID\n"
                        + "WHERE r.Status = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "Available");
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        int roomTypeID = table.getInt("RoomTypeID");
                        String roomStatus = table.getString("Status");
                        String typeName = table.getString("TypeName");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        RoomDTO room = new RoomDTO(roomID, roomNumber, roomTypeID, roomStatus, typeName, capacity, pricePerNight);
                        result.add(room);
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

    public ArrayList<RoomDTO> getAllRoomsForManager() {
        ArrayList<RoomDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT R.RoomID, R.RoomNumber, R.RoomTypeID, R.Status, RT.TypeName\n"
                        + "FROM dbo.ROOM as R\n"
                        + "INNER JOIN dbo.ROOM_TYPE as RT on RT.RoomTypeID = r.RoomTypeID";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        String status = table.getString("Status");
                        String typeName = table.getString("TypeName");

                        RoomDTO room = new RoomDTO();
                        room.setRoomID(roomID);
                        room.setRoomNumber(roomNumber);
                        room.setRoomStatus(status);
                        room.setTypeName(typeName);

                        result.add(room);
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

    public ArrayList<RoomDTO> getAllRoomType() {
        ArrayList<RoomDTO> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT RoomTypeID, TypeName FROM ROOM_TYPE";
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomTypeID = table.getInt("RoomTypeID");
                        String typeName = table.getString("TypeName");

                        RoomDTO roomType = new RoomDTO(roomTypeID, typeName);
                        list.add(roomType);
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

    public ArrayList<RoomDTO> getAvailableRoomsByTypeId(int roomTypeID) {
        ArrayList<RoomDTO> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT RoomID, RoomNumber FROM ROOM WHERE RoomTypeID = ? AND Status = 'Available'";
                PreparedStatement ps = cn.prepareStatement(sql);
                ps.setInt(1, roomTypeID);
                ResultSet table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");

                        RoomDTO room = new RoomDTO();
                        room.setRoomID(roomID);
                        room.setRoomNumber(roomNumber);

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

    public ArrayList<RoomDTO> filterRoomType(String roomType, Date checkInDate, Date checkOutDate) {
        ArrayList<RoomDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                //Điều kiện ngày giao nhau: (b.CheckInDate < @checkOutDate) AND (b.CheckOutDate > @checkInDate)
                // => phải NOT IN trong đám đó
                String sql = "SELECT r.RoomID, r.RoomNumber, r.RoomTypeID, r.Status, rt.Capacity, rt.PricePerNight\n"
                        + "FROM ROOM r\n"
                        + "INNER JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "WHERE rt.TypeName = ?\n"
                        + "  AND r.Status = 'Available'\n"
                        + "  AND r.RoomID NOT IN (\n"
                        + "        SELECT b.RoomID\n"
                        + "        FROM BOOKING b\n"
                        + "        WHERE b.Status IN ('Reserved','CheckIn') -- chỉ loại trừ các booking đang còn hiệu lực\n"
                        + "          AND (\n"
                        + "               (b.CheckInDate < ?)\n"
                        + "               AND (b.CheckOutDate > ?)\n"
                        + "          )\n"
                        + "    )";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, roomType);
                st.setDate(2, checkOutDate);
                st.setDate(3, checkInDate);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        int roomTypeID = table.getInt("RoomTypeID");
                        String roomStatus = table.getString("Status");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        RoomDTO room = new RoomDTO(roomID, roomNumber, roomTypeID, roomStatus, roomType, capacity, pricePerNight);
                        result.add(room);
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

    public ArrayList<RoomDTO> filterAvailableRoomsByDateRange(Date checkInDate, Date checkOutDate) {
        ArrayList<RoomDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                //Điều kiện ngày giao nhau: (b.CheckInDate < @checkOutDate) AND (b.CheckOutDate > @checkInDate)
                // => phải NOT IN trong đám đó
                String sql = "SELECT r.RoomID, r.RoomNumber, r.RoomTypeID, r.Status, rt.TypeName,rt.Capacity, rt.PricePerNight\n"
                        + "FROM ROOM r\n"
                        + "INNER JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "WHERE r.Status = 'Available'\n"
                        + "  AND r.RoomID NOT IN (\n"
                        + "        SELECT b.RoomID\n"
                        + "        FROM BOOKING b\n"
                        + "        WHERE b.Status IN ('Reserved','CheckIn') -- chỉ loại trừ các booking đang còn hiệu lực\n"
                        + "          AND (\n"
                        + "               (b.CheckInDate < ?)\n"
                        + "               AND (b.CheckOutDate > ?)\n"
                        + "          )\n"
                        + "    )";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setDate(1, checkOutDate);
                st.setDate(2, checkInDate);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        int roomTypeID = table.getInt("RoomTypeID");
                        String roomType = table.getString("TypeName");
                        String roomStatus = table.getString("Status");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        RoomDTO room = new RoomDTO(roomID, roomNumber, roomTypeID, roomStatus, roomType, capacity, pricePerNight);
                        result.add(room);
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

    public boolean updateRoomStatus(int roomId, String newStatus) {
        boolean result = false;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "UPDATE ROOM SET Status = ? WHERE RoomID = ?";
                PreparedStatement ps = cn.prepareStatement(sql);
                ps.setString(1, newStatus);
                ps.setInt(2, roomId);
                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    result = true;
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

    public RoomDTO getRoomByID(int roomID) {
        Connection cn = null;
        RoomDTO room = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM dbo.ROOM as r\n"
                        + "INNER JOIN dbo.ROOM_TYPE AS rt ON rt.RoomTypeID = r.RoomTypeID\n"
                        + "WHERE r.RoomID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, roomID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        String roomNumber = table.getString("RoomNumber");
                        int roomTypeID = table.getInt("RoomTypeID");
                        String roomStatus = table.getString("Status");
                        String typeName = table.getString("TypeName");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        room = new RoomDTO(roomID, roomNumber, roomTypeID, roomStatus, typeName, capacity, pricePerNight);
                    }
                }
            }
        } catch (Exception e) {
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return room;
    }

    public int updateRoomStatus(int roomID) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "UPDATE dbo.ROOM SET Status = ? WHERE RoomID = ?";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "Occupied");
                st.setInt(2, roomID);
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
            }
        }
        return result;
    }

    public int countTotalRoom() {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT COUNT(RoomID) as [Tổng số phòng] FROM ROOM";
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet table = ps.executeQuery();
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public Map<String, Integer> countTotalRoomByRoomType() {
        Map<String, Integer> list = new LinkedHashMap<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT rt.TypeName, COUNT(r.RoomID) as [Tổng số phòng] FROM ROOM r JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID "
                    + "GROUP BY rt.TypeName ORDER BY [Tổng số phòng] DESC";
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet table = ps.executeQuery();
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return list;
    }

    public Map<String, Object> getMonthlyOccupancyPercentage(int month, int year) {
        Map<String, Object> list = new HashMap<>();
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

        // Dùng try-with-resources để tự động đóng tài nguyên
        try ( Connection cn = DBUtills.getConnection();  PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, month);
            ps.setInt(2, year);

            try ( ResultSet rs = ps.executeQuery()) {
                // Câu truy vấn này luôn trả về 1 hàng
                if (rs.next()) {
                    // Lấy kết quả từ SQL và đặt vào Map
                    list.put("Số phòng đang được đặt", rs.getInt("Số phòng đang được đặt"));
                    list.put("Tổng số phòng", rs.getInt("Tổng số phòng"));
                    list.put("Tỷ lệ phòng được đặt", rs.getDouble("Tỷ lệ phòng được đặt"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Luôn in lỗi ra
        }
        return list; // Trả về Map (có thể rỗng nếu có lỗi)
    }
}
