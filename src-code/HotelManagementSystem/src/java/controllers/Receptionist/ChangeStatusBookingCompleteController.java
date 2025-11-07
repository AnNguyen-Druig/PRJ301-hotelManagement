/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Receptionist;

import DAO.Basic_DAO.BookingDAO;
import DAO.Basic_DAO.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mylib.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ChangeStatusBookingCompleteController", urlPatterns = {"/ChangeStatusBookingCompleteController"})
public class ChangeStatusBookingCompleteController extends HttpServlet {

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
            //Nhận parameter từ bookingroomdetail.jsp
            String bookingID = request.getParameter("bookingID");
            String roomID = request.getParameter("roomID");
            String status = request.getParameter("status");

            //Check khác null và ko rỗng
            if (bookingID != null && !bookingID.trim().isEmpty()
                    && roomID != null && !roomID.trim().isEmpty()
                    && status != null && !status.trim().isEmpty()) {

                //Convert sang đúng kiểu dữ liệu trong DB
                int bookingID_value = Integer.parseInt(bookingID);
                int roomID_value = Integer.parseInt(roomID);

                //Khai báo các DAO cần thiết
                BookingDAO bookingDAO = new BookingDAO();
                RoomDAO roomDAO = new RoomDAO();

                //Khai báo biến để kiểm tra đã update status hay chưa
                boolean bookingUpdateStatus = false;
                boolean roomUpdateStatus = false;

                //Gọi DAO thực hiện update status cho Booking và Room
                bookingUpdateStatus = bookingDAO.updateStatusBooking(bookingID_value, "Complete");
                roomUpdateStatus = roomDAO.updateRoomStatus(roomID_value, "Dirty");
                if (bookingUpdateStatus == true && roomUpdateStatus == true) {
                    request.setAttribute("SUCCESS", IConstants.SUCC_SAVE_UPDATE_BOOKING);
                } else {
                    request.setAttribute("ERROR", IConstants.ERR_SAVE_UPDATE_BOOKING);
                }
                request.getRequestDispatcher(IConstants.CTL_UPDATE_BOOKING_IN_RECEPTION + "?bookingID=" + bookingID).forward(request, response);
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
