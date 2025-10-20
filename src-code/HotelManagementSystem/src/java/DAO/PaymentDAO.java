/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
}
