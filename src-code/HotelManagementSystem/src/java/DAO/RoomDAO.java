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

    public ArrayList<RoomDTO> filterRoomType(String roomType) {
        ArrayList<RoomDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM dbo.ROOM AS r\n"
                        + "INNER JOIN dbo.ROOM_TYPE AS rt ON rt.RoomTypeID = r.RoomTypeID\n"
                        + "WHERE r.Status = ? AND rt.TypeName = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "Available");
                st.setString(2, roomType);
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
            }
        }
        return room;
    }
    
    public boolean updateRoomStatus(int roomId, String newStatus) {
        String sql = "UPDATE ROOM SET Status = ? WHERE RoomID = ?";
        try (Connection cn = DBUtills.getConnection(); PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, roomId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
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
}
