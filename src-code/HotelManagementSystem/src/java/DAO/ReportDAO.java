/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.ReportDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mylib.DBUtills;

/**
 *
 * @author Nguyễn Đại
 */
public class ReportDAO {
    public ArrayList<ReportDTO> report1(){
        ArrayList<ReportDTO> result = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT BS.ServiceDate, G.FullName, B.RoomID, S.ServiceName, BS.Quantity, BS.Status\n"
                            + "FROM DBO.BOOKING_SERVICE AS BS\n"
                            + "JOIN BOOKING AS B ON B.BookingID = BS.BookingID\n"
                            + "JOIN GUEST AS G ON G.GuestID = B.GuestID\n"
                            + "JOIN SERVICE AS S ON S.ServiceID = BS.ServiceID";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if(table != null){
                    while(table.next()){
                        Date serviceDate = table.getDate("ServiceDate");
                        String guestName = table.getString("FullName");
                        int roomId = table.getInt("RoomID");
                        String serviceName = table.getString("ServiceName");
                        int quantity = table.getInt("Quantity");
                        String status = table.getString("Status");
                        ReportDTO report = new ReportDTO(serviceDate, guestName, roomId, serviceName, quantity, status);
                        result.add(report);
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
    
    public ReportDTO report2(){
        ReportDTO result = null;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT BS.ServiceDate, G.FullName, B.RoomID, S.ServiceName, BS.Quantity, BS.Status\n"
                            + "FROM DBO.BOOKING_SERVICE AS BS\n"
                            + "JOIN BOOKING AS B ON B.BookingID = BS.BookingID\n"
                            + "JOIN GUEST AS G ON G.GuestID = B.GuestID\n"
                            + "JOIN SERVICE AS S ON S.ServiceID = BS.ServiceID";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if(table != null){
                    while(table.next()){
                        Date serviceDate = table.getDate("ServiceDate");
                        String guestName = table.getString("FullName");
                        int roomId = table.getInt("RoomID");
                        String serviceName = table.getString("ServiceName");
                        int quantity = table.getInt("Quantity");
                        String status = table.getString("Status");
                        result = new ReportDTO(serviceDate, guestName, roomId, serviceName, quantity, status);
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
