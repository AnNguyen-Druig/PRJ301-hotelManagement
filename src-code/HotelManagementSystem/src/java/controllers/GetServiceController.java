/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import DAO.ServiceDAO;
import DTO.ServiceDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name="GetServiceController", urlPatterns={"/GetServiceController"})
public class GetServiceController extends HttpServlet {
   
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
            // Lấy booking ID từ request parameter hoặc session
            String bookingId = request.getParameter("bookingId");
            HttpSession session = request.getSession();
            
            // Nếu không có trong request, lấy từ session
            if (bookingId == null || bookingId.isEmpty()) {
                bookingId = (String) session.getAttribute("BOOKING_ID");
            }
            
            if (bookingId == null || bookingId.isEmpty()) {
                request.setAttribute("ERROR", "Missing bookingId");
            } else {
                // Lưu vào session để dùng lại
                session.setAttribute("BOOKING_ID", bookingId);
            }
            ServiceDAO dao = new ServiceDAO();
            ArrayList<ServiceDTO> list = dao.getAllService();
            if(list != null && !list.isEmpty()){
                request.setAttribute("ALLSERVICE", list);
                request.getRequestDispatcher(IConstants.CHOOSE_SERVICE_PAGE).forward(request, response);
            }else{
                request.setAttribute("ERROR", "There no service found please check your database");
                request.getRequestDispatcher(IConstants.CHOOSE_SERVICE_PAGE).forward(request, response);
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
