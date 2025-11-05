/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.RoomDTO;
import DTO.Guest_DTO.ShowRoomDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mylib.DBUtills;

/**
 *
 * @author ASUS
 */
public class RoomDAO {

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
                        String typeName = table.getString("TypeName");
                        int capacity = table.getInt("Capacity");
                        double pricePerNight = table.getDouble("PricePerNight");
                        room = new RoomDTO(roomID, roomNumber, typeName, capacity, pricePerNight);
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
