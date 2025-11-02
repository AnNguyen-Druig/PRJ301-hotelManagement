package DAO;

import DTO.StaffDTO;
import java.sql.Connection;
import java.sql.Date; // Import java.sql.Date
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mylib.DBUtills;

public class StaffDAO {

    /**
     * Dùng để kiểm tra đăng nhập.
     */
    public StaffDTO getLoginStaff(String username, String password) {
        Connection cn = null;
        StaffDTO result = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            
            // CẬP NHẬT CÂU SQL: Thêm DateOfBirth
            String sql = "SELECT StaffID, FullName, Role, Username, PasswordHash, Phone, Email, Status, Address, IDNumber, DateOfBirth "
                       + "FROM STAFF WHERE Username = ? AND PasswordHash = ? COLLATE Latin1_General_CS_AS";
            
            ps = cn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            table = ps.executeQuery();
            
            // Dùng if thay vì while vì Username là UNIQUE
            if (table != null && table.next()) {
                int staffID = table.getInt("StaffID");
                String fullName = table.getString("FullName");
                String role = table.getString("Role");
                String phone = table.getString("Phone");
                String email = table.getString("Email");
                String status = table.getString("Status");
                String address = table.getString("Address");
                String idNumber = table.getString("IDNumber");
                Date dateOfBirth = table.getDate("DateOfBirth"); // Lấy DateOfBirth

                // CẬP NHẬT CONSTRUCTOR DTO: Khớp với StaffDTO.java
                result = new StaffDTO(staffID, fullName, role, username, password, phone, email, address, idNumber, dateOfBirth, status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng tất cả tài nguyên
            try {
                if (table != null) table.close();
                if (ps != null) ps.close();
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * Lấy tất cả nhân viên.
     */
    public List<StaffDTO> getAllStaff() {
        Connection cn = null;
        List<StaffDTO> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet table = null;

        try {
            cn = DBUtills.getConnection();
            // CẬP NHẬT CÂU SQL: Thêm DateOfBirth
            String sql = "SELECT StaffID, FullName, Role, Username, Phone, Email, Status, Address, IDNumber, DateOfBirth "
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
                    String address = table.getString("Address");
                    String idNumber = table.getString("IDNumber");
                    Date dateOfBirth = table.getDate("DateOfBirth");

                    // CẬP NHẬT CONSTRUCTOR DTO: (password để là "" vì không cần thiết khi hiển thị danh sách)
                    StaffDTO staff = new StaffDTO(staffID, fullName, staffRole, username, "", phone, email, address, idNumber, dateOfBirth, status);
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
     * Lọc nhân viên chỉ theo Role.
     */
    public List<StaffDTO> getStaffByRole(String role) {
        Connection cn = null;
        List<StaffDTO> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet table = null;

        try {
            cn = DBUtills.getConnection();
            // CẬP NHẬT CÂU SQL
            String sql = "SELECT StaffID, FullName, Role, Username, Phone, Email, Status, Address, IDNumber, DateOfBirth "
                       + "FROM STAFF WHERE Role = ? ORDER BY Role, Status";
            ps = cn.prepareStatement(sql);
            ps.setString(1, role);
            
            table = ps.executeQuery();
            if (table != null) {
                while (table.next()) {
                    // CẬP NHẬT CONSTRUCTOR DTO
                    StaffDTO staff = new StaffDTO(
                        table.getInt("StaffID"),
                        table.getString("FullName"),
                        table.getString("Role"),
                        table.getString("Username"),
                        "", // Password
                        table.getString("Phone"),
                        table.getString("Email"),
                        table.getString("Address"),
                        table.getString("IDNumber"),
                        table.getDate("DateOfBirth"),
                        table.getString("Status")
                    );
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
     * Lọc nhân viên chỉ theo Status.
     */
    public List<StaffDTO> getStaffByStatus(String status) {
        Connection cn = null;
        List<StaffDTO> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet table = null;

        try {
            cn = DBUtills.getConnection();
            // CẬP NHẬT CÂU SQL
            String sql = "SELECT StaffID, FullName, Role, Username, Phone, Email, Status, Address, IDNumber, DateOfBirth "
                       + "FROM STAFF WHERE Status = ? ORDER BY Role, Status";
            ps = cn.prepareStatement(sql);
            ps.setString(1, status); 
            
            table = ps.executeQuery();
            if (table != null) {
                while (table.next()) {
                    // CẬP NHẬT CONSTRUCTOR DTO
                    StaffDTO staff = new StaffDTO(
                        table.getInt("StaffID"),
                        table.getString("FullName"),
                        table.getString("Role"),
                        table.getString("Username"),
                        "", // Password
                        table.getString("Phone"),
                        table.getString("Email"),
                        table.getString("Address"),
                        table.getString("IDNumber"),
                        table.getDate("DateOfBirth"),
                        table.getString("Status")
                    );
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
     * Lọc nhân viên theo cả Role và Status.
     */
    public List<StaffDTO> getStaffByRoleAndStatus(String role, String status) {
        Connection cn = null;
        List<StaffDTO> list = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet table = null;

        try {
            cn = DBUtills.getConnection();
            // CẬP NHẬT CÂU SQL
            String sql = "SELECT StaffID, FullName, Role, Username, Phone, Email, Status, Address, IDNumber, DateOfBirth "
                       + "FROM STAFF WHERE Role = ? AND Status = ? ORDER BY Role, Status";
            ps = cn.prepareStatement(sql);
            ps.setString(1, role);
            ps.setString(2, status);
            
            table = ps.executeQuery();
            if (table != null) {
                while (table.next()) {
                    // CẬP NHẬT CONSTRUCTOR DTO
                    StaffDTO staff = new StaffDTO(
                        table.getInt("StaffID"),
                        table.getString("FullName"),
                        table.getString("Role"),
                        table.getString("Username"),
                        "", // Password
                        table.getString("Phone"),
                        table.getString("Email"),
                        table.getString("Address"),
                        table.getString("IDNumber"),
                        table.getDate("DateOfBirth"),
                        table.getString("Status")
                    );
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
     * Tạo một nhân viên mới.
     */
    public int createStaff(StaffDTO staff) throws SQLException {
        Connection cn = null;
        PreparedStatement ps = null;
        int result = 0;

        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                // CẬP NHẬT CÂU SQL INSERT: Thêm DateOfBirth
                String sql = "INSERT INTO STAFF (FullName, Role, Username, PasswordHash, Phone, Email, Address, IDNumber, DateOfBirth, Status) "
                           + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                
                ps = cn.prepareStatement(sql);
                ps.setString(1, staff.getFullName());
                ps.setString(2, staff.getRole());
                ps.setString(3, staff.getUserName());
                ps.setString(4, staff.getPassword()); // DTO lưu PasswordHash trong trường "password"
                ps.setString(5, staff.getPhone());
                ps.setString(6, staff.getEmail());
                ps.setString(7, staff.getAddress());
                ps.setString(8, staff.getIdNumber());
                ps.setDate(9, staff.getDateOfBirth()); // Thêm DateOfBirth
                ps.setString(10, staff.getStatus());

               result = ps.executeUpdate(); // Trả về số dòng bị ảnh hưởng
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Ném lỗi (ví dụ: lỗi UNIQUE) để Controller bắt
            throw new SQLException("Lỗi khi tạo nhân viên: " + e.getMessage()); 
        } finally {
            if (ps != null) ps.close();
            if (cn != null) cn.close();
        }
        return result;
    }
    
    public boolean checkUsernameExisted(String username) {
        boolean result = false;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();

            String sql = "SELECT * FROM STAFF WHERE Username = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet table = ps.executeQuery();

            while (table.next()) {
                result = true;  //true có nghĩa là username đó đã tồn tại rồi -> báo lỗi
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
    
}