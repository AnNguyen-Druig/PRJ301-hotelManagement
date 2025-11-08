/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.HouseKeepingDAO;

import DTO.Basic_DTO.RoomDTO;
import DTO.HouseKeeping_DTO.GetRoomForHouseKeepingDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mylib.DBUtills;

/**
 *
 * @author Admin
 */
public class GetRoomForHouseKeepingDAO {

    public ArrayList<GetRoomForHouseKeepingDTO> getAllRoomsForManager() {
        ArrayList<GetRoomForHouseKeepingDTO> result = new ArrayList<>();
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT R.RoomID, R.RoomNumber, R.RoomTypeID, R.Status, RT.TypeName\n"
                        + "FROM dbo.ROOM as R\n"
                        + "INNER JOIN dbo.ROOM_TYPE as RT on RT.RoomTypeID = r.RoomTypeID";
                st = cn.prepareStatement(sql);
                table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        String status = table.getString("Status");
                        String typeName = table.getString("TypeName");

                        GetRoomForHouseKeepingDTO room = new GetRoomForHouseKeepingDTO(roomID, roomNumber, status, typeName);
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
                if (st != null) {
                    st.close();
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

    public boolean updateRoomStatus(int roomId, String newStatus) {
        boolean result = false;
        Connection cn = null;
        PreparedStatement ps = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "UPDATE ROOM SET Status = ? WHERE RoomID = ?";
                ps = cn.prepareStatement(sql);
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
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
