/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Guest;

import controllers.*;
import DAO.RoomDAO;
import DTO.RoomDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
@WebServlet(name = "FilterRoomController", urlPatterns = {"/FilterRoomController"})
public class FilterRoomController extends HttpServlet {

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
            String roomType = request.getParameter("roomtype");
            String checkInDate = request.getParameter("booking_room_checkInDate");
            String checkOutDate = request.getParameter("booking_room_checkOutDate");

            Date checkInDate_value = Date.valueOf(checkInDate);
            Date checkOutDate_value = Date.valueOf(checkOutDate);

            //Check checkInDate phai > now 
            Date today = new Date(System.currentTimeMillis());
            if (checkInDate_value.before(today) || checkInDate_value.equals(today)) {
                request.setAttribute("ERRORCHECKINDATE", IConstants.ERR_CHECKINDATE_ISBEFORE_TODAY);
                request.getRequestDispatcher(IConstants.BOOKING_ROOM_PAGE).forward(request, response);
            } else if (checkOutDate_value.before(checkInDate_value) || checkOutDate_value.equals(checkInDate_value)) {
                //checkOutDate > checkInDate
                request.setAttribute("ERRORCHECKOUTDATE", IConstants.ERR_CHECKOUTDATE_ISBEFORE_CHECKINDATE);
                request.getRequestDispatcher(IConstants.BOOKING_ROOM_PAGE).forward(request, response);
            } else {
                //Lấy tất cả phòng có status Available từ ngày checkIn đến checkOut (ko cần theo RoomType)
                if (roomType.equalsIgnoreCase("AllRoom")) {
                    RoomDAO d = new RoomDAO();
                    ArrayList<RoomDTO> list = d.filterAvailableRoomsByDateRange(checkInDate_value, checkOutDate_value);
                    if (list != null && !list.isEmpty()) {
                        request.setAttribute("ALLROOM", list);
                        request.getRequestDispatcher(IConstants.BOOKING_ROOM_PAGE).forward(request, response);
                    } else {
                        request.setAttribute("ERROR", IConstants.ERR_EMPTY_ROOM);
                        request.getRequestDispatcher(IConstants.BOOKING_ROOM_PAGE).forward(request, response);
                    }
                } else {
                    //Lấy phòng theo RoomType và checkIn,checkOut
                    RoomDAO d = new RoomDAO();
                    ArrayList<RoomDTO> list = d.filterRoomType(roomType, checkInDate_value, checkOutDate_value);
                    if (list != null && !list.isEmpty()) {
                        request.setAttribute("ALLROOM", list);
                        request.getRequestDispatcher(IConstants.BOOKING_ROOM_PAGE).forward(request, response);
                    } else {
                        request.setAttribute("ERROR", IConstants.ERR_EMPTY_ROOM);
                        request.getRequestDispatcher(IConstants.BOOKING_ROOM_PAGE).forward(request, response);
                    }
                }
            }

        } catch (Exception e) {
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
