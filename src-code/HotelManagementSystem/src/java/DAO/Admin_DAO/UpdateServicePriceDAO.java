/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Admin_DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mylib.DBUtills;

/**
 *
 * @author ASUS
 */
public class UpdateServicePriceDAO {

    public int updateServicePrice(int serviceID, double servicePrice) {
        Connection cn = null;
        int result = 0;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "UPDATE SERVICE SET Price = ? WHERE ServiceID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setDouble(1, servicePrice);
                st.setInt(2, serviceID);
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
                e.printStackTrace();
            }
        }
        return result;
    }

    public double originalPrice(int serviceID) {
        Connection cn = null;
        double result = 0;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "Select Price\n"
                        + "From SERVICE\n"
                        + "Where ServiceID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, serviceID);
                ResultSet table = st.executeQuery();
                if(table!=null) {
                    while(table.next()) {
                        result = table.getDouble("Price");
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
}
