/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Manager;

import DAO.Basic_DAO.RoomDAO;
import DAO.Manager_DAO.RoomOccupancyDAO;
import DTO.Manager_DTO.RoomOccupancyDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
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
@WebServlet(name = "ViewRoomOccupancyRateController", urlPatterns = {"/ViewRoomOccupancyRateController"})
public class ViewRoomOccupancyRateController extends HttpServlet {

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
        String url = IConstants.VIEW_ROOM_OCCUPANCY_PAGE;
        try {
            // 1. Khởi tạo DAO cần thiết
            RoomOccupancyDAO roomOccDAO = new RoomOccupancyDAO();
            RoomDAO roomDAO = new RoomDAO();

            // 2. Thực hiện việc 1) Tính tổng số phòng hiện có
            int totalRoom = roomOccDAO.countTotalRoom();

            // 3. Thực hiện việc 2) Số lượng phòng theo từng Room Type
            Map<String, Integer> roomTypeList = roomOccDAO.countTotalRoomByRoomType();

            // 4. Thực hiện việc 3) Top 10 phòng được đặt nhiều nhất trong tháng/năm
            //                   4) Tỷ lệ phòng được đặt trong tháng/năm
            String checkInMonth = request.getParameter("month");
            String checkInYear = request.getParameter("year");
            int checkInMonth_value;
            int checkInYear_value;

            // 5. Kiểm tra checkInMonth và checkInYear có bị null không
            if (checkInMonth == null || checkInMonth.trim().isEmpty()
                    || checkInYear == null || checkInYear.trim().isEmpty()) {

                //Nếu null thì lấy tháng/năm mặc định theo giờ hệ thống
                Calendar now = Calendar.getInstance();
                checkInMonth_value = now.get(Calendar.MONTH) + 1; //+ 1: vì MONTH nó tính tháng 1 là 0 --> bắt đầu là 0 nên phải + 1
                checkInYear_value = now.get(Calendar.YEAR);
            } else {
                checkInMonth_value = Integer.parseInt(checkInMonth);
                checkInYear_value = Integer.parseInt(checkInYear);
            }

            // 6. Kiểm tra xem tháng có hợp lệ hay ko: có nằm trong khoảng từ th1-th12 ko
            if (checkInMonth_value < 1 || checkInMonth_value > 12) {
                request.setAttribute("ERROR", IConstants.ERR_INVALID_ROOM_MONTH);
            } else {
                ArrayList<RoomOccupancyDTO> highestRoomList = roomOccDAO.getRoomOccupancyRatePerMonth(checkInMonth_value, checkInYear_value);
                if (highestRoomList != null && !highestRoomList.isEmpty()) {
                    request.setAttribute("ROOM_OCCUPANCY_LIST", highestRoomList);
                } else {
                    request.setAttribute("ERROR", IConstants.ERR_EMPTY_ROOM_OCCUPANCY_LIST);
                }

                Map<String, Object> roomOccRateList = roomOccDAO.getMonthlyOccupancyPercentage(checkInMonth_value, checkInYear_value);
                if (roomOccRateList != null && !roomOccRateList.isEmpty()) {
                    request.setAttribute("OCCUPANCY_STATS", roomOccRateList);
                } else {
                    request.setAttribute("ERROR", IConstants.ERR_EMPTY_ROOM_OCCUPANCY_RATE_LIST);
                }
            }

            request.setAttribute("TOTAL_ROOMS", totalRoom);
            request.setAttribute("ROOM_COUNT_BY_TYPE", roomTypeList);
            request.setAttribute("SELECTED_MONTH", checkInMonth_value);
            request.setAttribute("SELECTED_YEAR", checkInYear_value);

        } catch (Exception e) {
            e.printStackTrace();
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
