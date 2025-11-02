/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.PaymentDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mylib.DBUtills;

/**
 *
 * @author ASUS
 */
public class PaymentDAO {

    public int savePaymentStatusPending(int bookindID, double amount, String paymentMethod) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO PAYMENT (BookingID, Amount, PaymentMethod, Status)\n"
                        + "VALUES (?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookindID);
                st.setDouble(2, amount);
                st.setString(3, paymentMethod);
                st.setString(4, "Pending");
                result = st.executeUpdate();
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

    public PaymentDTO getPaymentByBookingID(int bookingID) {
        PaymentDTO result = null;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT *\n"
                        + "FROM dbo.PAYMENT\n"
                        + "WHERE BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingID);
                ResultSet table = st.executeQuery();
                if(table!=null) {
                    while(table.next()) {
                        int paymentID = table.getInt("PaymentID");
                        Date paymentDate = table.getDate("PaymentDate");
                        double amount = table.getDouble("Amount");
                        String paymentMethod = table.getString("PaymentMethod");
                        String status = table.getString("Status");
                        result = new PaymentDTO(paymentID, bookingID, paymentDate, amount, paymentMethod, status);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
