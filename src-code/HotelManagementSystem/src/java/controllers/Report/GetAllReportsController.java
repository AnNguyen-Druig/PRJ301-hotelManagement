/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package controllers.Report;

import DAO.ReportDAO;
import DTO.ReportDTO;
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
 * @author Nguyễn Đại
 */
@WebServlet(name="GetAllReportsController", urlPatterns={"/GetAllReportsController"})
public class GetAllReportsController extends HttpServlet {
   
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
            ReportDAO dao = new ReportDAO();
            
            // Load Report 1 data
            ArrayList<ReportDTO> report1List = dao.report1();
            request.setAttribute("REPORT_1_LIST", report1List);
            
            // Load Report 2 data
            ArrayList<ReportDTO> report2List = dao.report2();
            request.setAttribute("REPORT_2_LIST", report2List);
            
            //Load Report 3 data
            ArrayList<ReportDTO> report3List = dao.report3();
            request.setAttribute("REPORT_3_LIST", report3List);
            
            // Set show all reports
            request.setAttribute("SHOW_REPORT", "all");
            
            // Forward to the main report page
            request.getRequestDispatcher(IConstants.REPORT_MAIN_PAGE).forward(request, response);
          
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("Error", "Error loading reports: " + e.getMessage());
            request.getRequestDispatcher(IConstants.REPORT_MAIN_PAGE).forward(request, response);
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
