package controllers.Receptionist;

import DAO.Basic_DAO.BookingRoomDAO;

import DAO.Basic_DAO.RoomDAO; // Đảm bảo bạn đã import RoomDAO

import DTO.Basic_DTO.BookingDTO;
import DTO.Basic_DTO.RoomDTO;
import java.io.IOException;
import java.util.ArrayList;
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
            // Lấy message từ SaveUpdateBookingController (nếu có)
            String successMsgFromSave = (String) request.getAttribute("SUCCESS");
            String errorMsgFromSave = (String) request.getAttribute("ERROR");
            // Đặt lại vào request để JSP có thể đọc được
            if (successMsgFromSave != null) {
                request.setAttribute("SUCCESS", successMsgFromSave); // Giữ nguyên tên attribute
            }
            if (errorMsgFromSave != null) {
                request.setAttribute("ERROR", errorMsgFromSave); // Giữ nguyên tên attribute
            }

            // 1. Lấy bookingID
            String bookingID_str = request.getParameter("bookingID");
            int bookingID = Integer.parseInt(bookingID_str);

            // 2. Khởi tạo DAO
            BookingRoomDAO bookingDAO = new BookingRoomDAO();
            RoomDAO roomDAO = new RoomDAO();

            // 3. Lấy dữ liệu
            BookingDTO booking = bookingDAO.getBookingByBookingIDInReception(bookingID);
            List<RoomDTO> allRoomTypes = roomDAO.getAllRoomType();

            int roomTypeIdToLoad = 0; // Biến để lưu ID loại phòng cần tải danh sách phòng trống
            int selectedRoomTypeID = 0;
            // 4. Xử lý tải lại danh sách phòng
            String selectedRoomTypeIdStr = request.getParameter("roomTypeID");
            if (selectedRoomTypeIdStr != null && !selectedRoomTypeIdStr.isEmpty()) {
                selectedRoomTypeID = Integer.parseInt(selectedRoomTypeIdStr);
                if(selectedRoomTypeID != 0) {
                    roomTypeIdToLoad = selectedRoomTypeID;
                    request.setAttribute("SELECTED_ROOM_TYPE_ID", roomTypeIdToLoad);
                }
            } else {
                roomTypeIdToLoad = booking.getRoomTypeID();
            }
            
            // 5. Lấy danh sách Room có status là 'Available'
            List<RoomDTO> availableRooms = roomDAO.getAvailableRoomsByTypeId(roomTypeIdToLoad);
            
            // 6. Tạo lại danh sách Room để hiển thị room đã bị Booking chuyển status từ 'Available' thành 'Occupied'
            ArrayList<RoomDTO> listContainRoomBooking = new ArrayList<>();
            RoomDTO room = new RoomDTO();
            room.setRoomID(booking.getRoomID());
            room.setRoomNumber(booking.getRoomNumber());
            listContainRoomBooking.add(room);   //Thêm room đã bị Booking chuyển status thành 'Occupied'
            
            // 7. Thêm các room có status là 'Available' khác(nếu có và KHÁC phòng hiện tại của booking) 
            //  từ danh sách 'availableRooms' vào danh sách cuối cùng 'listContainRoomBooking'.
            //  để tiếp tục thực hiện nhiệm vụ cho status 'Reserved'
            if(availableRooms != null && !availableRooms.isEmpty()) {
                for (RoomDTO availableRoom : availableRooms) {
                    //Chỉ thêm khi nó khác với phòng hiện tại (phòng đã đc Booking chuyển status thành 'Occupied')
                    if(availableRoom.getRoomID() != booking.getRoomID()) {
                        listContainRoomBooking.add(availableRoom);
                    }
                }
            }

            // 8. Gửi dữ liệu sang JSP
            request.setAttribute("AVAILABLE_ROOMS_LIST", listContainRoomBooking);
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
