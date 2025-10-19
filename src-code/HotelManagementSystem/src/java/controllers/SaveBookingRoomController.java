/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import DAO.BookingRoomDAO;
import DAO.RoomDAO;
import DTO.BookingDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mylib.IConstants;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "SaveBookingRoomController", urlPatterns = {"/SaveBookingRoomController"})
public class SaveBookingRoomController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String fullname = request.getParameter("guest_fullname");
            String phone = request.getParameter("guest_phone");
            String email = request.getParameter("guest_email");
            String IDNumber = request.getParameter("guest_IDNumber");
            String typeName = request.getParameter("room_typeName");
            String capacity = request.getParameter("room_capacity");
            String pricePerNight = request.getParameter("room_pricePerNight");
            String checkInDate = request.getParameter("booking_room_checkInDate");
            String checkOutDate = request.getParameter("booking_room_checkOutDate");
            String bookingDate = request.getParameter("booking_room_bookingDate");
            int roomID = Integer.parseInt(request.getParameter("roomID"));
            int guestID = Integer.parseInt(request.getParameter("guestID"));
            String bookingStatus = request.getParameter("bookingStatus");
            
            if (fullname != null && !fullname.trim().isEmpty()
                    && phone != null && !phone.trim().isEmpty()
                    && email != null && !email.trim().isEmpty()
                    && IDNumber != null && !IDNumber.trim().isEmpty()
                    && typeName != null && !typeName.trim().isEmpty()
                    && capacity != null && !capacity.trim().isEmpty()
                    && pricePerNight != null && !pricePerNight.trim().isEmpty()
                    && checkInDate != null && !checkInDate.trim().isEmpty()
                    && checkOutDate != null && !checkOutDate.trim().isEmpty()
                    && bookingDate != null && !bookingDate.trim().isEmpty()) {

                //Chuyển đổi dateOfBirth từ String sang Date.sql
                Date checkInDate_value = Date.valueOf(checkInDate);
                Date checkOutDate_value = Date.valueOf(checkOutDate);
                Date bookingDate_value = Date.valueOf(bookingDate);
                
                
                BookingDTO bookingRoom = new BookingDTO(guestID, roomID, checkInDate_value, checkOutDate_value, bookingDate_value, bookingStatus);
                BookingRoomDAO bookingRoomDAO = new BookingRoomDAO();
                int saveBookingRoom = bookingRoomDAO.saveBookingRoom(bookingRoom);
                
                RoomDAO roomDAO = new RoomDAO();
                int updateRoomStatus = roomDAO.updateRoomStatus(roomID); 
                
                if(saveBookingRoom!=0 && updateRoomStatus!=0) {
                    request.getRequestDispatcher(IConstants.SIGNUP_SUCCESS_PAGE).forward(request, response);
                } else {
                    
                }
                
                
                
            }
        } catch (Exception e) {
             e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
