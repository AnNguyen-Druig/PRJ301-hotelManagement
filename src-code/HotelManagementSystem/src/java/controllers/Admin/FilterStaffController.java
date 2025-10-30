/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Admin;

import DAO.StaffDAO;
import DTO.StaffDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mylib.IConstants;
import static mylib.IConstants.ADMIN_PAGE;

/**
 *
 * @author ASUS
 */
@WebServlet(name="FilterStaffController", urlPatterns={"/FilterStaffController"})
public class FilterStaffController extends HttpServlet {
   
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
            String role = request.getParameter("role");
            String status = request.getParameter("status");

            StaffDAO dao = new StaffDAO();
            List<StaffDTO> staffList = null; 

            boolean allRoles = role.equals("AllRoom");
            boolean allStatus = status.equals("AllStatus");

            if (allRoles && allStatus) {
                // Trường hợp 1: Xem tất cả
                staffList = dao.getAllStaff();
            } else if (!allRoles && allStatus) {
                // Trường hợp 2: Chỉ lọc theo Role
                staffList = dao.getStaffByRole(role);
            } else if (allRoles && !allStatus) {
                // Trường hợp 3: Chỉ lọc theo Status
                staffList = dao.getStaffByStatus(status);
            } else {
                // Trường hợp 4: Lọc theo CẢ Role VÀ Status
                staffList = dao.getStaffByRoleAndStatus(role, status);
            }
            request.setAttribute("STAFF_LIST", staffList);
        } catch (Exception e) {
            log("Error at GetAllStaffController: " + e.toString());
        } finally {
            // 6. Chuyển tiếp (forward) về lại trang admin.jsp
            request.getRequestDispatcher(IConstants.ADMIN_PAGE).forward(request, response);
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
