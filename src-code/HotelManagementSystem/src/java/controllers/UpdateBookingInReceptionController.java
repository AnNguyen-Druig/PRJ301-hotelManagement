package controllers;

import DAO.BookingRoomDAO;

import DAO.RoomDAO; // Đảm bảo bạn đã import RoomDAO

import DTO.BookingDTO;
import DTO.RoomDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mylib.IConstants;

@WebServlet(name = "UpdateBookingInReceptionController", urlPatterns = {"/UpdateBookingInReceptionController"})
public class UpdateBookingInReceptionController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = IConstants.BOOKING_ROOM_DETAIL_PAGE; // Mặc định là trang chi tiết

        try {
            // 1. Lấy bookingID
            String bookingID_str = request.getParameter("bookingID");
            int bookingID = Integer.parseInt(bookingID_str);

            // 2. Khởi tạo DAO
            BookingRoomDAO bookingDAO = new BookingRoomDAO();
            RoomDAO roomDAO = new RoomDAO();

            // 3. Lấy dữ liệu
            BookingDTO booking = bookingDAO.getBookingByBookingIDInReception(bookingID);
            List<RoomDTO> allRoomTypes = roomDAO.getAllRoomType();

            int roomTypeIdToLoad; // Biến để lưu ID loại phòng cần tải danh sách phòng trống
            // 4. Xử lý tải lại danh sách phòng
            String selectedRoomTypeIdStr = request.getParameter("roomTypeID");
            if (selectedRoomTypeIdStr != null && !selectedRoomTypeIdStr.isEmpty()) {
                roomTypeIdToLoad = Integer.parseInt(selectedRoomTypeIdStr);
                request.setAttribute("SELECTED_ROOM_TYPE_ID", roomTypeIdToLoad);
            } else {
                roomTypeIdToLoad = booking.getRoomTypeID();
            }
            List<RoomDTO> availableRooms = roomDAO.getAvailableRoomsByTypeId(roomTypeIdToLoad);
            request.setAttribute("AVAILABLE_ROOMS_LIST", availableRooms);

            // 5. Gửi dữ liệu sang JSP
            request.setAttribute("BOOKING_DETAIL", booking);
            request.setAttribute("ROOM_TYPES_LIST", allRoomTypes);

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi, đặt thông báo và đổi URL sang trang an toàn
            request.setAttribute("ERROR_MESSAGE", "Không thể tải dữ liệu. Lỗi: " + e.getMessage());
            url = IConstants.RECEPTIONIST_PAGE;
        } finally {
            // SỬA LỖI: Đặt lệnh forward vào khối finally.
            // Điều này đảm bảo trình duyệt LUÔN nhận được phản hồi.
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
    }// </editor-f
}
