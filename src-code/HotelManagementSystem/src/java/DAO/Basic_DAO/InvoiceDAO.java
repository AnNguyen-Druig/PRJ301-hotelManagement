/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.InvoiceDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mylib.DBUtills;

/**
 *
 * @author ASUS
 */
public class InvoiceDAO {

    public int saveInvoiceStatusPaid(int bookindID, double amount) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO INVOICE (BookingID, TotalAmount, Status)\n"
                        + "VALUES (?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookindID);
                st.setDouble(2, amount);
                st.setString(3, "Paid");
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

    public InvoiceDTO getInvoiceByBookingID(int bookingID) {
        InvoiceDTO result = null;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT * \n"
                        + "FROM dbo.INVOICE\n"
                        + "WHERE BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int invoiceID = table.getInt("InvoiceID");
                        Date issueDate = table.getDate("IssueDate");
                        double totalAmount = table.getDouble("TotalAmount");
                        String status = table.getString("Status");
                        result = new InvoiceDTO(invoiceID, bookingID, issueDate, totalAmount, status);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public double getTotalRevenueByDate(Date date) {
        double result = 0.0;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT\n"
                        + "    SUM(TotalAmount) AS [Tổng Doanh Thu]\n"
                        + "FROM\n"
                        + "    INVOICE\n"
                        + "WHERE\n"
                        + "    Status = 'Paid'\n"
                        + "    AND IssueDate = ?";
                ps = cn.prepareStatement(sql);
                ps.setDate(1, date);
                table = ps.executeQuery();
                if (table != null && table.next()) {
                    result = table.getDouble("Tổng Doanh Thu");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if(ps != null) {
                    ps.close();
                }
                if(table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public double getTotalRevenueByMonth(int month, int year) {
        double result = 0.0;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT\n"
                        + "    SUM(TotalAmount) AS [Tổng Doanh Thu]\n"
                        + "FROM\n"
                        + "    INVOICE\n"
                        + "WHERE\n"
                        + "    Status = 'Paid'\n"
                        + "    AND MONTH(IssueDate) = ?  \n"
                        + "    AND YEAR(IssueDate) = ?";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, month);
                ps.setInt(2, year);
                table = ps.executeQuery();
                if (table != null && table.next()) {
                    result = table.getDouble("Tổng Doanh Thu");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if(ps != null) {
                    ps.close();
                }
                if(table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public double getTotalRevenueByYear(int year) {
        double result = 0.0;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT SUM(TotalAmount) AS [Tổng Doanh Thu] \n"
                        + "FROM INVOICE WHERE Status = 'Paid'\n"
                        + "AND YEAR(IssueDate) = ?";
                ps = cn.prepareStatement(sql);
                ps.setInt(1, year);
                table = ps.executeQuery();
                if (table != null && table.next()) {
                    result = table.getDouble("Tổng Doanh Thu");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if(ps != null) {
                    ps.close();
                }
                if(table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
