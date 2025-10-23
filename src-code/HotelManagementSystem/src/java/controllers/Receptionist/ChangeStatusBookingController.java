///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controllers.Receptionist;
//
//import DAO.BookingRoomDAO;
//import DTO.BookingDTO;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.Date;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import mylib.IConstants;
//
///**
// *
// * @author Admin
// */
//@WebServlet(name = "ChangeStatusBookingController", urlPatterns = {"/ChangeStatusBookingController"})
//public class ChangeStatusBookingController extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try {
//            //Nhận parameter từ bookingroomdetail.jsp
//            String action = request.getParameter("action");
//            if (action != null && !action.trim().isEmpty()) {
//                String bookingID = request.getParameter("bookingID");
//                String roomID = request.getParameter("roomID");
//                String checkInDate = request.getParameter("checkInDate");
//                String checkOutDate = request.getParameter("checkOutDate");
//                String status = request.getParameter("status");
//                //Check khác null và rỗng
//                if (bookingID != null && !bookingID.trim().isEmpty()
//                        && roomID != null && !roomID.trim().isEmpty()
//                        && checkInDate != null && !checkInDate.trim().isEmpty()
//                        && checkOutDate != null && !checkOutDate.trim().isEmpty()
//                        && status != null && !status.trim().isEmpty()) {
//
//                    //Convert sang đúng kiểu dữ liệu trong DB
//                    int bookingID_value = Integer.parseInt(bookingID);
//                    int roomID_value = Integer.parseInt(roomID);
//                    Date checkInDate_value = Date.valueOf(checkInDate);
//                    Date checkOutDate_value = Date.valueOf(checkOutDate);
//
//                    BookingRoomDAO bookingDAO = new BookingRoomDAO();
//                    BookingDTO booking = new BookingDTO(bookingID_value, roomID_value, checkInDate_value, checkOutDate_value, status);
//                    int saveAndUpdateStatus = 0;
//
//                    if (action.equals("Check In")) {
//                        booking.getStatus().equals("CheckIn");
//                        saveAndUpdateStatus = bookingDAO.saveAndUpdateStatusBooking(booking);
//                    } else if (action.equals("Cancel Booking")) {
//                        booking.getStatus().equals("Canceled");
//                        saveAndUpdateStatus = bookingDAO.saveAndUpdateStatusBooking(booking);
//                    } else if (action.equals("Check Out")) {
//                        booking.getStatus().equals("CheckOut");
//                        saveAndUpdateStatus = bookingDAO.saveAndUpdateStatusBooking(booking);
//                    } else if (action.equals("Approve Checkout")) {
//                        booking.getStatus().equals("Complete");
//                        saveAndUpdateStatus = bookingDAO.saveAndUpdateStatusBooking(booking);
//                    }
//
//                    if (saveAndUpdateStatus != 0) {
//                        request.setAttribute("SUCCESS", IConstants.SUCC_SAVE_UPDATE_BOOKING);
//                    } else {
//                        request.setAttribute("ERROR", IConstants.ERR_SAVE_UPDATE_BOOKING);
//                    }
//                    request.getRequestDispatcher(IConstants.CTL_UPDATE_BOOKING_IN_RECEPTION + "?bookingID=" + bookingID).forward(request, response);
//                }
//            }
//        } catch (Exception e) {
//        } finally {
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
