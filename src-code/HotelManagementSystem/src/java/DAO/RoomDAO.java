/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.RoomDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
                String sql = "SELECT r.RoomID, rt.TypeName, rt.Capacity, rt.PricePerNight\n"
                        + "FROM dbo.ROOM AS r\n"
                        + "INNER JOIN dbo.ROOM_TYPE AS rt ON rt.RoomTypeID = r.RoomTypeID\n"
                        + "WHERE r.Status = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "Available");
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomID = table.getInt("RoomID");
                        String typeName = table.getString("TypeName");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        RoomDTO room = new RoomDTO(roomID, typeName, capacity, pricePerNight);
                        result.add(room);
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

        return result;
    }

    public ArrayList<RoomDTO> filterRoomType(String roomType) {
        ArrayList<RoomDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT r.RoomID, rt.TypeName, rt.Capacity, rt.PricePerNight\n"
                        + "FROM dbo.ROOM AS r\n"
                        + "INNER JOIN dbo.ROOM_TYPE AS rt ON rt.RoomTypeID = r.RoomTypeID\n"
                        + "WHERE r.Status = ? AND rt.TypeName = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "Available");
                st.setString(2, roomType);
                ResultSet table = st.executeQuery();
                if(table != null) {
                    while(table.next()) {
                        int roomID = table.getInt("RoomID");
                        String typeName = table.getString("TypeName");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        RoomDTO room = new RoomDTO(roomID, typeName, capacity, pricePerNight);
                        result.add(room);
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
            }
        }
        return result;
    }
}
