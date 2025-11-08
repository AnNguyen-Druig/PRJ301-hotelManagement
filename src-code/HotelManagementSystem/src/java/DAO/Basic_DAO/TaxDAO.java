/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.TaxDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
                if (table != null) {
                    while (table.next()) {
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

    public ArrayList<TaxDTO> getAllTax() {
        ArrayList<TaxDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT [TaxID],[TaxName],[TaxValue],[Description],[LastUpdated]\n"
                        + "FROM dbo.TAX_CONFIG ";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int taxID = table.getInt("TaxID");
                        String taxName = table.getString("TaxName");
                        double taxValue = table.getDouble("TaxValue");
                        String description = table.getString("Description");
                        Date LastUpdated = table.getDate("LastUpdated");
                        TaxDTO t = new TaxDTO(taxID, taxName, taxValue, description, LastUpdated);
                        result.add(t);
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

    public int updateTaxValue(int taxID, double taxValue) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "  UPDATE TAX_CONFIG SET TaxValue = ?,LastUpdated = GETDATE() WHERE TaxID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setDouble(1, taxValue);
                st.setInt(2, taxID);
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

    public double originalTaxValue(int taxID) {
        Connection cn = null;
        double result = 0;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT TaxValue\n"
                        + "  FROM TAX_CONFIG\n"
                        + "  WHERE TaxID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, taxID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
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
                e.printStackTrace();
            }
        }
        return result;
    }
}
