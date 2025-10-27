/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mylib.DBUtills;

/**
 *
 * @author ASUS
 */
public class TaxDAO {

    public double getTaxValueByTaxName(String taxName) {
        double result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT TaxValue\n"
                        + "FROM dbo.TAX_CONFIG\n"
                        + "WHERE TaxName = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, taxName);
                ResultSet table = st.executeQuery();
                if(table!=null){
                    while(table.next()) {
                        result = table.getDouble("TaxValue");
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
            }
        }
        return result;
    }
}
