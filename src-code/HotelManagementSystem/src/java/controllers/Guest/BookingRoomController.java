/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Guest;


import DAO.Guest_DAO.ShowRoomDAO;
import DTO.Guest_DTO.ShowRoomDTO;
import java.io.IOException;
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
@WebServlet(name = "BookingRoomController", urlPatterns = {"/BookingRoomController"})
public class BookingRoomController extends HttpServlet {

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
            int roomID = Integer.parseInt(request.getParameter("roomID"));
            String checkInDate = request.getParameter("booking_room_checkInDate").trim();
            String checkOutDate = request.getParameter("booking_room_checkOutDate").trim();

            //nếu người dùng chưa chọn CheckIn và CheckOut ở trang bookingroompage.jsp thì gửi ERROR về lại trang đó kêu người dùng chọn
            if (checkInDate.equals("null") || checkOutDate.equals("null")) {
                request.setAttribute("ERROR_REQUIRED", IConstants.ERR_REQUIRE_SELECT_DATERANGE);
                request.getRequestDispatcher(IConstants.CTL_GETROOM).forward(request, response);

            } else {
                Date checkInDate_value = Date.valueOf(checkInDate.trim());
                Date checkOutDate_value = Date.valueOf(checkOutDate.trim());

                request.setAttribute("CHECKINDATE", checkInDate_value);
                request.setAttribute("CHECKOUTDATE", checkOutDate_value);

                ShowRoomDAO roomDAO = new ShowRoomDAO();
                ShowRoomDTO room = roomDAO.getRoomByID(roomID);
                request.setAttribute("ROOM", room);

                request.getRequestDispatcher(IConstants.BOOKING_ROOM_REGISTER_PAGE).forward(request, response);
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
