/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Service;

import DAO.Basic_DAO.BookingServiceDAO;
import DAO.Basic_DAO.ServiceDAO;
import DTO.Basic_DTO.BookingServiceDTO;
import DTO.Basic_DTO.ServiceDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name="GetBookingServiceController", urlPatterns={"/GetBookingServiceController"})
public class GetBookingServiceController extends HttpServlet {
   
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
          String bookingIdStr = request.getParameter("bookingId");
          if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
            request.setAttribute("ERROR", "Thiếu bookingId");
            request.getRequestDispatcher("ViewServicePage.jsp").forward(request, response);
            return;
          }
          int bookingId = Integer.parseInt(bookingIdStr);
          BookingServiceDAO bsDao = new BookingServiceDAO();
          ArrayList<BookingServiceDTO> list = bsDao.getBookingServiceByBookingID(bookingId);
          
            HashMap<Integer, ServiceDTO> serviceMap = new HashMap<>();
            ServiceDAO sDao = new ServiceDAO();
            if (list != null) {
              for (BookingServiceDTO bs : list) {
                int sid = bs.getServiceID();
                if (!serviceMap.containsKey(sid)) {
                  ServiceDTO s = sDao.getService(sid); // hàm đã có trong ServiceDAO
                  if (s != null) serviceMap.put(sid, s);
                }
              }
            }
      
          request.setAttribute("BOOKING_ID", bookingId);
          request.setAttribute("BOOKING_SERVICES", list);
          request.setAttribute("SERVICE_MAP", serviceMap);
          request.getRequestDispatcher("MainController?action=ViewService").forward(request, response);
        }catch(Exception e){
            e.printStackTrace();
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
