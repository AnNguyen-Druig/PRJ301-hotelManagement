/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Guest;

import DAO.Basic_DAO.BookingDAO;
import DTO.Basic_DTO.BookingDTO;
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
@WebServlet(name = "CancelBookingRoomController", urlPatterns = {"/CancelBookingRoomController"})
public class CancelBookingRoomController extends HttpServlet {

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
        String bookingID = request.getParameter("bookingID");
        String checkInDate = request.getParameter("checkInDate");
        Date checInDate_value = Date.valueOf(checkInDate);
        //Check ngày ngày HUỶ phải trước ngày CheckIn
        Date today = new Date(System.currentTimeMillis());
        if (today.before(checInDate_value)) {
            BookingDAO bookingRoomDAO = new BookingDAO();
            boolean cancel = bookingRoomDAO.updateStatusBooking(Integer.parseInt(bookingID.trim()), "Canceled");
            if (cancel == true) {
                request.setAttribute("MESSAGE", IConstants.SUCC_CANCEL_BOOKING_ROOM);
                request.getRequestDispatcher(IConstants.CTL_VIEW_BOOKING).forward(request, response);
            } else {
                request.setAttribute("MESSAGE", IConstants.ERR_CANCEL_BOOKING_ROOM);
                request.getRequestDispatcher(IConstants.CTL_VIEW_BOOKING).forward(request, response);
            }
        } else {
            request.setAttribute("MESSAGE", IConstants.ERR_CANCELDATE_BEFORE_CHECKINDATE + checInDate_value);
            request.getRequestDispatcher(IConstants.CTL_VIEW_BOOKING).forward(request, response);
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
