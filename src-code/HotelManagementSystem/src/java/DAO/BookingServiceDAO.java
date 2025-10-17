/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.ServiceDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import mylib.DBUtills;

/**
 *
 * @author Nguyễn Đại
 */
public class BookingServiceDAO {
    public int saveBookingService(int BookingID, int ServiceID, int quantity){
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if(cn != null){
                cn.setAutoCommit(false);
                String sql = "Insert dbo.BOOKING_SERVICE values (?,?,?,?)";
                PreparedStatement st = cn.prepareStatement(sql);
                Date serviceDate = new Date(System.currentTimeMillis());
                st.setInt(1, BookingID );
                st.setInt(2, ServiceID);
                st.setDate(3, serviceDate);
                st.setInt(4, quantity);
                
                cn.commit();
                cn.setAutoCommit(true);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try {
                if(cn!=null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    } 
}
