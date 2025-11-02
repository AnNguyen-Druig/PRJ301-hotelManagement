/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Guest;

import controllers.*;
import DAO.Basic_DAO.BookingRoomDAO;
import DTO.Basic_DTO.BookingDTO;
import DTO.Basic_DTO.GuestDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mylib.IConstants;

/**
 *
 * @author ASUS
 */
@WebServlet(name="ViewBookingController", urlPatterns={"/ViewBookingController"})
public class ViewBookingController extends HttpServlet {
   
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
        try {
            HttpSession session = request.getSession();
            GuestDTO guest = (GuestDTO) session.getAttribute("USER");
            int guestID = guest.getGuestID();
            BookingRoomDAO bookingRoomDAO = new BookingRoomDAO();
            ArrayList<BookingDTO> listAllBooking =  bookingRoomDAO.getAllBookingByGuestID(guestID);
            ArrayList<BookingDTO> listReservedBooking = new ArrayList<>();
            ArrayList<BookingDTO> listCheckInBooking = new ArrayList<>();
            if(listAllBooking!=null && !listAllBooking.isEmpty()) {
                for(BookingDTO b : listAllBooking) {
                    if(b.getStatus().equals("Reserved")) {
                        listReservedBooking.add(b);
                    } else if(b.getStatus().equals("CheckIn")) {
                        listCheckInBooking.add(b);
                    }
                }
                request.setAttribute("RESERVED_BOOKING", listReservedBooking);
                request.setAttribute("CHECKIN_BOOKING", listCheckInBooking);
                request.getRequestDispatcher(IConstants.BOOKING_ROOM_VIEW_PAGE).forward(request, response);
            } else {
                request.setAttribute("ERROR", IConstants.ERR_EMPTYBOOKING);
                request.getRequestDispatcher(IConstants.BOOKING_ROOM_VIEW_PAGE).forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
