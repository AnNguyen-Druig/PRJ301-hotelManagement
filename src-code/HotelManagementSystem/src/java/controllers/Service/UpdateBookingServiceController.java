/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Service;

import DAO.Basic_DAO.BookingServiceDAO;
import DAO.Basic_DAO.ServiceDAO;
import DTO.Basic_DTO.BookingDTO;
import DTO.Basic_DTO.BookingServiceDTO;
import DTO.Basic_DTO.RoomDTO;
import DTO.Basic_DTO.ServiceDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mylib.IConstants;

/**
 *
 * @author Nguyễn Đại
 */
@WebServlet(name="UpdateBookingServiceController", urlPatterns={"/UpdateBookingServiceController"})
public class UpdateBookingServiceController extends HttpServlet {
   
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
        String url = IConstants.CTL_GET_BOOKING_SERVICE;
        try {
            BookingServiceDAO dao = new BookingServiceDAO();
            int bookingServiceId = Integer.parseInt(request.getParameter("bookingServiceId"));
            String newStatus     = request.getParameter("newStatus");
            int bookingId  = Integer.parseInt(request.getParameter("bookingId")); 
            if(newStatus != null && !newStatus.equalsIgnoreCase("Completed") || !newStatus.equalsIgnoreCase("Canceled")){               
                dao.updateStatus(bookingServiceId, newStatus);
            }
            request.setAttribute("bookingId", bookingId);
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
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
