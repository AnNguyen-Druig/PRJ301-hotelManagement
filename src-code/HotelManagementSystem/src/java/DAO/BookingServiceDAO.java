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
                String sql = "Insert dbo.BOOKING_SERVICE(BookingID, ServiceID, Quantity, Status) values (?,?,?,?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, BookingID );
                st.setInt(2, ServiceID);
                st.setInt(3, quantity);
                st.setString(4,"Pending");
                result = st.executeUpdate();
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
