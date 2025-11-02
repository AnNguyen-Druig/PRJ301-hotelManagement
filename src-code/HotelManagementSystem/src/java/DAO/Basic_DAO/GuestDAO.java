/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.GuestDTO;
import DTO.Basic_DTO.StaffDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mylib.DBUtills;

/**
 *
 * @author Admin
 */
public class GuestDAO {

    public int signUpGuest(GuestDTO guest) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "INSERT INTO GUEST (FullName, Phone, Email, Address, IDNumber, DateOfBirth, Username, PasswordHash) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setNString(1, guest.getFullName());
            ps.setString(2, guest.getPhone());
            ps.setString(3, guest.getEmail());
            ps.setString(4, guest.getAddress());
            ps.setString(5, guest.getIDNumber());
            ps.setDate(6, guest.getDateOfBirth());
            ps.setString(7, guest.getUsername());
            ps.setString(8, guest.getPassword());

            result = ps.executeUpdate();

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

    public GuestDTO getLoginMember(String username, String password) {
        Connection cn = null;
        GuestDTO result = null;
        try {
            cn = DBUtills.getConnection();

            String sql = "SELECT GuestID, FullName, Phone, Email, Address, IDNumber, DateOfBirth, Username, PasswordHash FROM GUEST WHERE Username = ? AND PasswordHash = ? COLLATE Latin1_General_CS_AS;";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet table = ps.executeQuery();
            if (table != null) {
                while (table.next()) {
                    int guestID = table.getInt("GuestID");
                    String fullName = table.getString("FullName");
                    String address = table.getString("Address");
                    String phone = table.getString("Phone");
                    String email = table.getString("Email");
                    String idNumber = table.getString("IDNumber");
                    Date dateOfBirth = table.getDate("DateOfBirth");

                    result = new GuestDTO(guestID, fullName, phone, email, address, idNumber, dateOfBirth, username, password);
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

    //Hàm dùng để kiểm tra username có tồn tại hay chưa
    public boolean checkUsernameExisted(String username) {
        boolean result = false;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();

            String sql = "SELECT * FROM GUEST WHERE Username = ?";
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

    public GuestDTO getGuestByID(int guestID) {
        GuestDTO guest = null;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT [Username],[PasswordHash],[FullName],[Phone],[Email],[Address],[IDNumber],[DateOfBirth]"
                        + " FROM [dbo].[GUEST] "
                        + "WHERE [GuestID] = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, guestID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        String username = table.getString("Username");
                        String password = table.getString("PasswordHash");
                        String fullName = table.getString("FullName");
                        String address = table.getString("Address");
                        String phone = table.getString("Phone");
                        String email = table.getString("Email");
                        String idNumber = table.getString("IDNumber");
                        Date dateOfBirth = table.getDate("DateOfBirth");
                        guest = new GuestDTO(guestID, fullName, phone, email, address, idNumber, dateOfBirth, username, password);
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
        return guest;
    }

    public GuestDTO getGuestByIDNumber(String idnumber) {
        GuestDTO guest = null;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT [GuestID], [Username],[PasswordHash],[FullName],[Phone],[Email],[Address], [DateOfBirth]"
                        + " FROM [dbo].[GUEST] "
                        + "WHERE [IDNumber] = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, idnumber);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int guestID = table.getInt("GuestID");
                        String username = table.getString("Username");
                        String password = table.getString("PasswordHash");
                        String fullName = table.getString("FullName");
                        String address = table.getString("Address");
                        String phone = table.getString("Phone");
                        String email = table.getString("Email");
                        Date dateOfBirth = table.getDate("DateOfBirth");
                        guest = new GuestDTO(guestID, fullName, phone, email, address, idnumber, dateOfBirth, username, password);
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
        return guest;
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
}
