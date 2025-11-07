/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Manager;

import DAO.Basic_DAO.BookingDAO;
import DTO.Basic_DTO.BookingDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.Map;
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
@WebServlet(name = "ViewCancellationStatsController", urlPatterns = {"/ViewCancellationStatsController"})
public class ViewCancellationStatsController extends HttpServlet {

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
        String url = IConstants.VIEW_CANCEL_STATISTICS_PAGE;

        try {
            // Khởi tạo DAO
            BookingDAO bookingDAO = new BookingDAO();

            // 1. Thực hiện việc 1. totalBooking
            int totalBooking = bookingDAO.countTotalBooking();

            // 2. Thực hiện việc 2. totalCancelBooking
            int totalCancelBooking = bookingDAO.countTotalCancelBooking();

            // 3. Thực hiện việc 3. rateCancelBooking
            // Sửa lại: Hàm DAO trả về String đã định dạng
            double rateCancelBooking = bookingDAO.rateCancelBooking();

            // 4. Thực hiện việc 4. Lượt Hủy theo khoảng thời gian
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            Integer totalCancelBookingInRange = null; // Dùng Integer để có thể là null

            if (startDate != null && !startDate.trim().isEmpty()
                    && endDate != null && !endDate.trim().isEmpty()) {

                Date startDate_value = Date.valueOf(startDate);
                Date endDate_value = Date.valueOf(endDate);

                // Gọi DAO 
                totalCancelBookingInRange = bookingDAO.countTotalCancelBookingInRange(startDate_value, endDate_value);

                // Gửi lại filter cho JSP
                request.setAttribute("START_DATE_FILTER", startDate);
                request.setAttribute("END_DATE_FILTER", endDate);
            }

            // 5. Thực hiện việc 5. Lượt Hủy theo Tháng/Năm
            Map<String, Integer> monthYearList = bookingDAO.countTotalCancelBookingInMonthYear();

            // 6. Thực hiện việc 6. Lượt Hủy theo Loại phòng
            // SỬA LỖI COPY-PASTE: Gọi đúng hàm
            Map<String, Integer> roomTypeList = bookingDAO.countTotalCancelBookingByRoomType();

            // 7. Đặt tất cả thuộc tính vào request
            request.setAttribute("TOTAL_BOOKINGS", totalBooking);
            request.setAttribute("TOTAL_CANCELLATIONS", totalCancelBooking);
            request.setAttribute("CANCELLATION_RATE", rateCancelBooking);
            if (totalCancelBookingInRange != null) { // Chỉ set nếu đã tính
                request.setAttribute("CANCELLATIONS_IN_RANGE", totalCancelBookingInRange);
            } else {
                request.setAttribute("ERROR", IConstants.ERR_EMPTY_CANCEL_BOOKING_INRANGE);
            }
            if(monthYearList != null && !monthYearList.isEmpty()) {
                request.setAttribute("CANCELLATIONS_BY_MONTH", monthYearList);
            } else {
                request.setAttribute("ERROR", IConstants.ERR_EMPTY_CANCEL_BOOKING_BY_MONTH);
            }
            if(roomTypeList != null && !roomTypeList.isEmpty()) {
                request.setAttribute("CANCELLATIONS_BY_ROOM_TYPE", roomTypeList);
            } else {
                request.setAttribute("ERROR_ROOMTYPE_LIST", IConstants.ERR_EMPTY_CANCEL_BOOKING_BY_ROOMTYPE);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", IConstants.ERR_EMPTY_CANCEL_BOOKING_LIST);
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
