/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.ServiceDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mylib.DBUtills;

/**
 *
 * @author Nguyễn Đại
 */
public class ServiceDAO {

    public ArrayList<ServiceDTO> getAllService() {
        ArrayList<ServiceDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "Select ServiceID, ServiceName, ServiceType, Price From dbo.SERVICE";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int ServiceId = table.getInt("ServiceID");
                        String ServiceName = table.getString("ServiceName");
                        String ServiceType = table.getString("ServiceType");
                        double Price = table.getDouble("Price");
                        ServiceDTO service = new ServiceDTO(ServiceId, ServiceName, ServiceType, Price);
                        result.add(service);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    public ServiceDTO getService(int id) {
        ServiceDTO result = null;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "Select * From dbo.SERVICE Where ServiceID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int ServiceID = table.getInt("ServiceID");
                        String ServiceName = table.getString("ServiceName");
                        String ServiceType = table.getString("ServiceType");
                        double Price = table.getDouble("Price");
                        result = new ServiceDTO(ServiceID, ServiceName, ServiceType, Price);
                    }
                }
            }
        } catch (Exception e) {

        }
        return result;
    }

    public ArrayList<ServiceDTO> getMostUsedService() {
        ArrayList<ServiceDTO> list = new ArrayList<>();
        Connection cn = null;
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
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int serviceID = table.getInt("ServiceID");
                        String serviceType = table.getString("ServiceType");
                        String serviceName = table.getString("ServiceName");
                        int countNumService = table.getInt("Số lượng sử dụng");
                        ServiceDTO service = new ServiceDTO(serviceID, serviceName, serviceType, countNumService);
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public ArrayList<ServiceDTO> getHighestIncomeServiceList() {
        ArrayList<ServiceDTO> list = new ArrayList<>();
        Connection cn = null;
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
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int serviceID = table.getInt("ServiceID");
                        String serviceType = table.getString("ServiceType");
                        String serviceName = table.getString("ServiceName");
                        float highestIncomeService = table.getFloat("Doanh thu");
                        ServiceDTO service = new ServiceDTO(serviceID, serviceName, serviceType, highestIncomeService);
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public ServiceDTO getHighestIncomeService() {
        ServiceDTO result = null;
        Connection cn = null;
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
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet table = ps.executeQuery();
                if (table != null && table.next()) {
                    int serviceID = table.getInt("ServiceID");
                    String serviceType = table.getString("ServiceType");
                    String serviceName = table.getString("ServiceName");
                    float highestIncomeService = table.getFloat("Doanh thu");
                    ServiceDTO service = new ServiceDTO(serviceID, serviceName, serviceType, highestIncomeService);
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    
    public ServiceDTO getLowestIncomeService() {
        ServiceDTO result = null;
        Connection cn = null;
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
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet table = ps.executeQuery();
                if (table != null && table.next()) {
                    int serviceID = table.getInt("ServiceID");
                    String serviceType = table.getString("ServiceType");
                    String serviceName = table.getString("ServiceName");
                    float lowestIncomeService = table.getFloat("Doanh thu");
                    ServiceDTO service = new ServiceDTO(serviceID, serviceName, serviceType, lowestIncomeService);
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
