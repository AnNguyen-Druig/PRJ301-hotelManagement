/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Guest_DAO;

import DTO.Guest_DTO.ShowRoomDTO;
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
public class ShowRoomDAO {

    public ArrayList<ShowRoomDTO> getAllRooms() {
        ArrayList<ShowRoomDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT r.RoomID, r.RoomNumber, rt.TypeName, rt.Capacity, rt.PricePerNight\n"
                        + "FROM dbo.ROOM AS r INNER JOIN dbo.ROOM_TYPE AS rt ON rt.RoomTypeID = r.RoomTypeID \n"
                        + "WHERE r.Status = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "Available");
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        String typeName = table.getString("TypeName");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        ShowRoomDTO room = new ShowRoomDTO(roomID, roomNumber, typeName, capacity, pricePerNight);
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
    
     public ArrayList<ShowRoomDTO> filterAvailableRoomsByDateRange(Date checkInDate, Date checkOutDate) {
        ArrayList<ShowRoomDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                //Điều kiện ngày giao nhau: (b.CheckInDate < @checkOutDate) AND (b.CheckOutDate > @checkInDate)
                // => phải NOT IN trong đám đó
                String sql = "SELECT r.RoomID, r.RoomNumber, rt.TypeName,rt.Capacity, rt.PricePerNight\n"
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
                        String roomType = table.getString("TypeName");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        ShowRoomDTO room = new ShowRoomDTO(roomID, roomNumber, roomType, capacity, pricePerNight);
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
     
      public ArrayList<ShowRoomDTO> filterRoomType(String roomType, Date checkInDate, Date checkOutDate) {
        ArrayList<ShowRoomDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                //Điều kiện ngày giao nhau: (b.CheckInDate < @checkOutDate) AND (b.CheckOutDate > @checkInDate)
                // => phải NOT IN trong đám đó
                String sql = "SELECT r.RoomID, r.RoomNumber, rt.TypeName,rt.Capacity, rt.PricePerNight\n"
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
                        String typeName = table.getString("TypeName");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        ShowRoomDTO room = new ShowRoomDTO(roomID, roomNumber,typeName, capacity, pricePerNight);
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
      
      public ShowRoomDTO getRoomByID(int roomID) {
        Connection cn = null;
        ShowRoomDTO room = null;
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
                        String typeName = table.getString("TypeName");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        room = new ShowRoomDTO(roomID, roomNumber, typeName, capacity, pricePerNight);
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
}
