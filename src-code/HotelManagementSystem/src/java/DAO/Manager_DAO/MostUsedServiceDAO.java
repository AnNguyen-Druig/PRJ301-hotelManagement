/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Manager_DAO;

import DTO.Manager_DTO.MostUsedServiceDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mylib.DBUtills;

/**
 *
 * @author Admin
 */
public class MostUsedServiceDAO {

    //Hàm này dùng để lấy ra Danh sách Service sử dụng nhiều nhất từ nhiều nhất đến ít nhất
    public ArrayList<MostUsedServiceDTO> getMostUsedService() {
        ArrayList<MostUsedServiceDTO> list = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT\n"
                        + "    s.ServiceID,\n"
                        + "	s.ServiceType,\n"
                        + "    s.ServiceName,\n"
                        + "    SUM(bs.Quantity) AS [Số lượng sử dụng] \n"
                        + "FROM\n"
                        + "    SERVICE s\n"
                        + "JOIN\n"
                        + "    BOOKING_SERVICE bs ON s.ServiceID = bs.ServiceID\n"
                        + "WHERE\n"
                        + "    bs.Status IN ('Pending', 'Completed') \n"
                        + "GROUP BY\n"
                        + "    s.ServiceID, s.ServiceType, s.ServiceName \n"
                        + "ORDER BY\n"
                        + "    [Số lượng sử dụng] DESC";
                ps = cn.prepareStatement(sql);
                table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int serviceID = table.getInt("ServiceID");
                        String serviceType = table.getString("ServiceType");
                        String serviceName = table.getString("ServiceName");
                        int countNumService = table.getInt("Số lượng sử dụng");
                        MostUsedServiceDTO service = new MostUsedServiceDTO(serviceID, serviceName, serviceType, countNumService);
                        list.add(service);
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
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    //Hàm này dùng để lấy ra Danh sách các Service có doanh thu từ Cao nhất đến Thấp nhất
    public ArrayList<MostUsedServiceDTO> getHighestIncomeServiceList() {
        ArrayList<MostUsedServiceDTO> list = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT\n"
                        + "    s.ServiceID,\n"
                        + "	s.ServiceType,\n"
                        + "    s.ServiceName,\n"
                        + "	SUM(bs.Quantity * s.Price) AS [Doanh thu]\n"
                        + "FROM\n"
                        + "    SERVICE s\n"
                        + "JOIN\n"
                        + "    BOOKING_SERVICE bs ON s.ServiceID = bs.ServiceID\n"
                        + "WHERE\n"
                        + "    bs.Status IN ('Pending', 'Completed') \n"
                        + "GROUP BY\n"
                        + "    s.ServiceID, s.ServiceType, s.ServiceName \n"
                        + "ORDER BY\n"
                        + "    [Doanh thu] DESC";
                ps = cn.prepareStatement(sql);
                table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int serviceID = table.getInt("ServiceID");
                        String serviceType = table.getString("ServiceType");
                        String serviceName = table.getString("ServiceName");
                        float highestIncomeService = table.getFloat("Doanh thu");
                        MostUsedServiceDTO service = new MostUsedServiceDTO(serviceID, serviceName, serviceType, highestIncomeService);
                        list.add(service);
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
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    //Hàm này dùng để lấy ra 1 Service có Doanh thu Cao nhất
    public MostUsedServiceDTO getHighestIncomeService() {
        MostUsedServiceDTO result = null;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 1\n"
                        + "    s.ServiceID,\n"
                        + "	s.ServiceType,\n"
                        + "    s.ServiceName,\n"
                        + "	SUM(bs.Quantity * s.Price) AS [Doanh thu]\n"
                        + "FROM\n"
                        + "    SERVICE s\n"
                        + "JOIN\n"
                        + "    BOOKING_SERVICE bs ON s.ServiceID = bs.ServiceID\n"
                        + "WHERE\n"
                        + "    bs.Status IN ('Pending', 'Completed') \n"
                        + "GROUP BY\n"
                        + "    s.ServiceID, s.ServiceType, s.ServiceName \n"
                        + "ORDER BY\n"
                        + "    [Doanh thu] DESC";
                ps = cn.prepareStatement(sql);
                table = ps.executeQuery();
                if (table != null && table.next()) {
                    int serviceID = table.getInt("ServiceID");
                    String serviceType = table.getString("ServiceType");
                    String serviceName = table.getString("ServiceName");
                    float highestIncomeService = table.getFloat("Doanh thu");
                    MostUsedServiceDTO service = new MostUsedServiceDTO(serviceID, serviceName, serviceType, highestIncomeService);
                    result = service;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    //Hàm này dùng để lấy ra 1 Service có Doanh thu Thấp nhất
    public MostUsedServiceDTO getLowestIncomeService() {
        MostUsedServiceDTO result = null;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 1\n"
                        + "    s.ServiceID,\n"
                        + "	s.ServiceType,\n"
                        + "    s.ServiceName,\n"
                        + "	SUM(bs.Quantity * s.Price) AS [Doanh thu]\n"
                        + "FROM\n"
                        + "    SERVICE s\n"
                        + "JOIN\n"
                        + "    BOOKING_SERVICE bs ON s.ServiceID = bs.ServiceID\n"
                        + "WHERE\n"
                        + "    bs.Status IN ('Pending', 'Completed') \n"
                        + "GROUP BY\n"
                        + "    s.ServiceID, s.ServiceType, s.ServiceName \n"
                        + "ORDER BY\n"
                        + "    [Doanh thu] ASC";
                ps = cn.prepareStatement(sql);
                table = ps.executeQuery();
                if (table != null && table.next()) {
                    int serviceID = table.getInt("ServiceID");
                    String serviceType = table.getString("ServiceType");
                    String serviceName = table.getString("ServiceName");
                    float lowestIncomeService = table.getFloat("Doanh thu");
                    MostUsedServiceDTO service = new MostUsedServiceDTO(serviceID, serviceName, serviceType, lowestIncomeService);
                    result = service;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
