/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import DAO.BookingServiceDAO;
import DTO.ServiceDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mylib.IConstants;

/**
 *
 * @author Nguyễn Đại
 */
@WebServlet(name="EditServiceController", urlPatterns={"/EditServiceController"})
public class EditServiceController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
          String action = request.getParameter("action");
          int serviceId = Integer.parseInt(request.getParameter("serviceid").trim());
          int quantity = Integer.parseInt(request.getParameter("quantity").trim());
          int bookingId = Integer.parseInt(request.getParameter("bookingId").trim());
          HttpSession session = request.getSession();
//          String bookingId = (String) session.getAttribute("BOOKING_ID");
          String cartKey = "CART_" + bookingId;
          HashMap<ServiceDTO, Integer> cart=(HashMap<ServiceDTO, Integer>) session.getAttribute(cartKey);
          ServiceDTO find = null;
                for (ServiceDTO s : cart.keySet()) {
                    if(s.getServiceId() == serviceId){
                        find = s;
                        break;
                    }
                }    
                if (find != null) {
                    if(action.equalsIgnoreCase(IConstants.AC_SAVE_BOOKING_SERVICE)) {
                        BookingServiceDAO bookingServiceDAO = new BookingServiceDAO();
                        int result = bookingServiceDAO.saveBookingService(bookingId,serviceId, quantity);
                        if(result != 0) {
                            cart.remove(find);
                            request.setAttribute("SAVE_BOOKING_SERVICE", IConstants.SUCC_SAVE_BOOKING_SERVICE);
                        } else {
                            request.setAttribute("SAVE_BOOKING_SERVICE", IConstants.ERR_SAVE_BOOKING_SERVICE);
                        }
                    }
                    else if (action.equalsIgnoreCase(IConstants.AC_UPDATE_BOOKING_SERVICE)) {
                        cart.put(find,quantity);
                    } else {
                        cart.remove(find);
                    }
                    session.setAttribute(cartKey, cart);
                    // Giữ lại booking ID khi forward
//                    if (bookingId != null) {
//                        request.setAttribute("bookingId", bookingId);
//                    }
                    request.getRequestDispatcher("GetServiceController").forward(request, response);
                }
            
        }catch(Exception e){
            
        } 
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}

