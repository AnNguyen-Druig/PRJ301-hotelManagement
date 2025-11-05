/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Guest;

import DAO.Basic_DAO.BookingDAO;
import DAO.Basic_DAO.BookingServiceDAO;
import DAO.Guest_DAO.BookingRoomDetailDAO;
import DTO.Basic_DTO.BookingDTO;
import DTO.Basic_DTO.BookingServiceDTO;
import DTO.Guest_DTO.BookingRoomDetailDTO;
import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet(name="GetBookingRoomController", urlPatterns={"/GetBookingRoomController"})
public class GetBookingRoomController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int bookingID = Integer.parseInt(request.getParameter("bookingId").trim());
        
        //lấy đối tượng BookingRoom
        BookingRoomDetailDAO bookingRoomDetailDAO = new BookingRoomDetailDAO();
        BookingRoomDetailDTO bookingRoomDetailDTO = bookingRoomDetailDAO.getBookingRoomDetailByBookingID(bookingID);
        request.setAttribute("BOOKING_ROOM", bookingRoomDetailDTO);
        
        //lấy list BookingService mà BookingRoom đã đặt
        BookingServiceDAO bookingServiceDAO = new BookingServiceDAO();
        ArrayList<BookingServiceDTO> listBookingService = bookingServiceDAO.getBookingServiceByBookingID(bookingID);
        request.setAttribute("LIST_BOOKING_SERVICE", listBookingService);
        
        request.getRequestDispatcher(IConstants.CHECKOUT_PAGE).forward(request, response);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
