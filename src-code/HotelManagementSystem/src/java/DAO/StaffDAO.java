/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.StaffDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mylib.DBUtills;

/**
 *
 * @author Admin
 */
public class StaffDAO {
    
    public StaffDTO getLoginStaff(String username, String password) {
        Connection cn = null;
        StaffDTO result = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT StaffID, FullName, Role, Username, PasswordHash, Phone, Email FROM STAFF WHERE Username = ? AND PasswordHash = ? COLLATE Latin1_General_CS_AS";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet table = ps.executeQuery();
            if(table != null) {
                while(table.next()) {
                    int staffID = table.getInt("StaffID");
                    String fullName = table.getString("FullName");
                    String role = table.getString("Role");
                    String phone = table.getString("Phone");
                    String email = table.getString("Email");
                    
                    result = new StaffDTO(staffID, fullName, role, username, password, phone, email);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
