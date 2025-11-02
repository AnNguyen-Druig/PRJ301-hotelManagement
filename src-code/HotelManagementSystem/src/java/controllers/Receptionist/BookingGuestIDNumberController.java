/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Receptionist;

import DAO.Basic_DAO.GuestDAO;
import DTO.Basic_DTO.GuestDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mylib.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookingGuestIDNumberController", urlPatterns = {"/BookingGuestIDNumberController"})
public class BookingGuestIDNumberController extends HttpServlet {

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
        // Khai báo url mặc định
        String url = IConstants.CTL_GETROOM; // Mặc định chuyển đến trang chọn phòng

        try {
            String idnumber = request.getParameter("guest_idnumber");

            if (idnumber != null && !idnumber.trim().isEmpty()) {
                GuestDAO guestDAO = new GuestDAO();
                GuestDTO guest = guestDAO.getGuestByIDNumber(idnumber);

                if (guest != null) {
                    // Tìm thấy khách: Lưu vào session 
                    HttpSession session = request.getSession();
                    session.setAttribute("USER", guest); 
                } else {
                    // Không tìm thấy khách: Đặt lỗi và forward về CONTROLLER hiển thị danh sách
                    request.setAttribute("ERROR", IConstants.ERR_INVALID_EMPTYACCOUNT);
                    // Forward về ShowBookingInReceptionController
                    url = IConstants.CTL_SHOW_BOOKING_IN_RECEPTION;
                }
            } else {
                // Trường hợp người dùng không nhập gì mà nhấn nút
                request.setAttribute("ERROR", IConstants.ERR_EMPTY_GUEST_IDNUMBER);
                url = IConstants.CTL_SHOW_BOOKING_IN_RECEPTION; // Cũng forward về controller danh sách
            }
        } catch (Exception e) {
            e.printStackTrace();
            url = IConstants.CTL_SHOW_BOOKING_IN_RECEPTION; // Lỗi cũng forward về controller danh sách
        } finally {
            // Forward đến url đã xác định (CTL_GETROOM hoặc CTL_SHOW_BOOKING_IN_RECEPTION)
            request.getRequestDispatcher(url).forward(request, response);
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
