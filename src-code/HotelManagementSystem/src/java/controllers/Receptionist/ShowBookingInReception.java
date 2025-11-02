/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Receptionist;

import DAO.Basic_DAO.BookingRoomDAO;
import DTO.Basic_DTO.BookingDTO;
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
 * @author Admin
 */
@WebServlet(name = "ShowBookingInReception", urlPatterns = {"/ShowBookingInReception"})
public class ShowBookingInReception extends HttpServlet {

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
        // Khởi tạo url mặc định là trang receptionist
        String url = IConstants.RECEPTIONIST_PAGE;

        try {
            // 1. Lấy selectedStatus, đặt giá trị mặc định là "All" --> Vì tải trang lần đầu thì selectedStatus chưa có giá trị
            String selectedStatus = request.getParameter("selectedStatus");
            if (selectedStatus == null || selectedStatus.trim().isEmpty()) {
                selectedStatus = "All"; // Mặc định hiển thị tất cả khi vào trang lần đầu
            }

            // 2. Khởi tạo DAO và list
            BookingRoomDAO bookingDAO = new BookingRoomDAO();
            ArrayList<BookingDTO> list = null; 

            // 3. Gọi DAO dựa trên selectedStatus
            if (selectedStatus.equals("All")) {
                list = bookingDAO.getAllBookingRoomGuest();
            } else {
                // Các trường hợp khác gọi cùng 1 hàm lọc
                list = bookingDAO.getBookingListByStatus(selectedStatus);
            }

            // 4. Đặt kết quả vào request
            if (list != null && !list.isEmpty()) {
                request.setAttribute("ALLBOOKING", list);
            } else {
                // Nếu list rỗng hoặc null, đặt thông báo lỗi
                request.setAttribute("BOOKING_LIST_ERROR", IConstants.ERR_EMPTYBOOKING + " (Trạng thái: " + selectedStatus + ")");
            }

            // 5. Đặt lại SELECTED_STATUS để dropdown nhớ lựa chọn
            request.setAttribute("SELECTED_STATUS", selectedStatus);

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi nghiêm trọng, đặt status mặc định
            request.setAttribute("SELECTED_STATUS", "All"); // Đặt về mặc định khi lỗi
        } finally {
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
