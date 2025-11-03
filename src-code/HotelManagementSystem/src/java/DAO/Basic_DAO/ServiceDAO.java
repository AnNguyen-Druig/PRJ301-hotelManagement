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
}
