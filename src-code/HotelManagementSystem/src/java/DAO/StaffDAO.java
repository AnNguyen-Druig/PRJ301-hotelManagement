/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.StaffDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
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

            String sql = "SELECT StaffID, FullName, Role, Username, PasswordHash, Phone, Email, Status FROM STAFF WHERE Username = ? AND PasswordHash = ? COLLATE Latin1_General_CS_AS";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet table = ps.executeQuery();
            if (table != null) {
                while (table.next()) {
                    int staffID = table.getInt("StaffID");
                    String fullName = table.getString("FullName");
                    String role = table.getString("Role");
                    String phone = table.getString("Phone");
                    String email = table.getString("Email");
                    String status = table.getString("Status");

                    result = new StaffDTO(staffID, fullName, role, username, password, phone, email, status);
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

    public static void main(String[] args) {
        try {
            Connection cn = null;
            cn = DBUtills.getConnection();
            System.out.println("Connected DB: " + cn.getCatalog());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<StaffDTO> getAllStaff() {
    Connection cn = null;
    List<StaffDTO> list = new ArrayList<>(); // Dùng List vì có thể có nhiều kết quả
    PreparedStatement ps = null;
    ResultSet table = null;

    try {
        cn = DBUtills.getConnection();
        String sql = "SELECT StaffID, FullName, Role, Username, Phone, Email, Status "
                   + "FROM STAFF ORDER BY Role, Status";
        ps = cn.prepareStatement(sql);
        table = ps.executeQuery();
        if (table != null) {
            while (table.next()) {
                int staffID = table.getInt("StaffID");
                String fullName = table.getString("FullName");
                String staffRole = table.getString("Role");
                String username = table.getString("Username");
                String phone = table.getString("Phone");
                String email = table.getString("Email");
                String status = table.getString("Status");

                // Tạo DTO (không có password) và thêm vào list
                StaffDTO staff = new StaffDTO(staffID, fullName, staffRole, username, "", phone, email, status);
                list.add(staff);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (table != null) table.close();
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    return list;
}

/**
 * Hàm 2: Chỉ lọc theo Role.
 */
public List<StaffDTO> getStaffByRole(String role) {
    Connection cn = null;
    List<StaffDTO> list = new ArrayList<>();
    PreparedStatement ps = null;
    ResultSet table = null;

    try {
        cn = DBUtills.getConnection();
        String sql = "SELECT StaffID, FullName, Role, Username, Phone, Email, Status "
                   + "FROM STAFF WHERE Role = ? ORDER BY Role, Status";
        ps = cn.prepareStatement(sql);
        ps.setString(1, role); // Gán tham số Role
        
        table = ps.executeQuery();
        if (table != null) {
            while (table.next()) {
                int staffID = table.getInt("StaffID");
                String fullName = table.getString("FullName");
                String staffRole = table.getString("Role");
                String username = table.getString("Username");
                String phone = table.getString("Phone");
                String email = table.getString("Email");
                String status = table.getString("Status");

                StaffDTO staff = new StaffDTO(staffID, fullName, staffRole, username, "", phone, email, status);
                list.add(staff);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (table != null) table.close();
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    return list;
}

/**
 * Hàm 3: Chỉ lọc theo Status.
 */
public List<StaffDTO> getStaffByStatus(String status) {
    Connection cn = null;
    List<StaffDTO> list = new ArrayList<>();
    PreparedStatement ps = null;
    ResultSet table = null;

    try {
        cn = DBUtills.getConnection();
        String sql = "SELECT StaffID, FullName, Role, Username, Phone, Email, Status "
                   + "FROM STAFF WHERE Status = ? ORDER BY Role, Status";
        ps = cn.prepareStatement(sql);
        ps.setString(1, status); // Gán tham số Status
        
        table = ps.executeQuery();
        if (table != null) {
            while (table.next()) {
                int staffID = table.getInt("StaffID");
                String fullName = table.getString("FullName");
                String staffRole = table.getString("Role");
                String username = table.getString("Username");
                String phone = table.getString("Phone");
                String email = table.getString("Email");
                String staffStatus = table.getString("Status");

                StaffDTO staff = new StaffDTO(staffID, fullName, staffRole, username, "", phone, email, staffStatus);
                list.add(staff);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (table != null) table.close();
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    return list;
}

/**
 * Hàm 4: Lọc theo CẢ Role VÀ Status.
 */
public List<StaffDTO> getStaffByRoleAndStatus(String role, String status) {
    Connection cn = null;
    List<StaffDTO> list = new ArrayList<>();
    PreparedStatement ps = null;
    ResultSet table = null;

    try {
        cn = DBUtills.getConnection();
        String sql = "SELECT StaffID, FullName, Role, Username, Phone, Email, Status "
                   + "FROM STAFF WHERE Role = ? AND Status = ? ORDER BY Role, Status";
        ps = cn.prepareStatement(sql);
        ps.setString(1, role);   // Gán tham số Role
        ps.setString(2, status); // Gán tham số Status
        
        table = ps.executeQuery();
        if (table != null) {
            while (table.next()) {
                int staffID = table.getInt("StaffID");
                String fullName = table.getString("FullName");
                String staffRole = table.getString("Role");
                String username = table.getString("Username");
                String phone = table.getString("Phone");
                String email = table.getString("Email");
                String staffStatus = table.getString("Status");

                StaffDTO staff = new StaffDTO(staffID, fullName, staffRole, username, "", phone, email, staffStatus);
                list.add(staff);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (table != null) table.close();
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    return list;
}
}
