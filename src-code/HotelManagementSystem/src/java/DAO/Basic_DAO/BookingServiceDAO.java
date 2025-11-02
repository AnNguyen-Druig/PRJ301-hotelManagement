/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.BookingServiceDTO;
import DTO.Basic_DTO.ServiceDTO;
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
public class BookingServiceDAO {

    public int saveBookingService(int BookingID, int ServiceID, int quantity) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "Insert dbo.BOOKING_SERVICE(BookingID, ServiceID, Quantity, Status, RequestTime) values (?,?,?,?,?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, BookingID);
                st.setInt(2, ServiceID);
                st.setInt(3, quantity);
                st.setString(4, "Pending");
                st.setInt(5, 15);
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

    public ArrayList<BookingServiceDTO> getBookingServiceByBookingID(int bookingID) {
        Connection cn = null;
        ArrayList<BookingServiceDTO> result = new ArrayList<>();
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "Select [Booking_Service_ID],bs.[BookingID],[ServiceID],[Quantity],[ServiceDate],bs.[Status],[AssignedStaff]\n"
                        + "FROM dbo.BOOKING_SERVICE as bs\n"
                        + "INNER JOIN dbo.BOOKING as b ON b.BookingID = bs.BookingID\n"
                        + "WHERE bs.BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingServiceID = table.getInt("Booking_Service_ID");
                        int serviceID = table.getInt("ServiceID");
                        int quantity = table.getInt("Quantity");
                        Date serviceDate = table.getDate("ServiceDate");
                        String status = table.getString("Status");
                        int AssignedStaff = table.getInt("AssignedStaff");
                        BookingServiceDTO bookingService = new BookingServiceDTO(bookingServiceID, bookingID, serviceID, quantity, serviceDate, status, AssignedStaff);
                        result.add(bookingService);
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
    
    public boolean updateStatus(int bookingServiceId, String newStatus){
        boolean result = false;
        Connection cn = null;
        try{
            cn = DBUtills.getConnection();
            String sql = "UPDATE dbo.BOOKING_SERVICE SET Status = ? WHERE Booking_Service_ID = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, newStatus);
            st.setInt(2, bookingServiceId);         
            int affect = st.executeUpdate();
            if(affect > 0){
                result = true;
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

