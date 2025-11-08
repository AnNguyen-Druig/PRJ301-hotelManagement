/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.RoomDTO;
import DTO.Basic_DTO.RoomTypeDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mylib.DBUtills;

/**
 *
 * @author Admin
 */
public class RoomTypeDAO {

    public ArrayList<RoomTypeDTO> getAllRoomType() {
        ArrayList<RoomTypeDTO> list = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT RoomTypeID, TypeName FROM ROOM_TYPE";
                ps = cn.prepareStatement(sql);
                table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int roomTypeID = table.getInt("RoomTypeID");
                        String typeName = table.getString("TypeName");

                        RoomTypeDTO roomType = new RoomTypeDTO(roomTypeID, typeName);
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
