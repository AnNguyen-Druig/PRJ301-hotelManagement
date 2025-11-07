/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Report;

import DAO.Report_DAO.HouseKeepingReportDAO;
import DTO.Report_DTO.HouseKeepingReportDTO;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name="HouseKeepingReportController", urlPatterns={"/HouseKeepingReportController"})
public class HouseKeepingReportController extends HttpServlet {
   
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
            HouseKeepingReportDAO dao = new HouseKeepingReportDAO();
            ArrayList<HouseKeepingReportDTO> list = new ArrayList<>();
            if (action == null) action = IConstants.HOUSEKEEPING_REPORT_PAGE;
            switch(action){
                case "report1":
                    list = dao.getReport1();
                    if(list != null && !list.isEmpty()){
                        request.setAttribute("REPORT_1_LIST", list);
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }else{
                        request.setAttribute("Error", "Can't load report 1 please check database");
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }
                break;
                
                case "report2":
                    list = dao.getReport2();
                    if(list != null && !list.isEmpty()){
                        request.setAttribute("REPORT_2_LIST", list);
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }else{
                        request.setAttribute("Error", "Can't load report 2 please check database");
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }
                break;
                
                case "report3":
                    list = dao.getReport3();
                    if(list != null && !list.isEmpty()){
                        request.setAttribute("REPORT_3_LIST", list);
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }else{
                        request.setAttribute("Error", "Can't load report 3 please check database");
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }
                break;
                
                case "report4":
                    list = dao.getReport4();
                    if(list != null && !list.isEmpty()){
                        request.setAttribute("REPORT_4_LIST", list);
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }else{
                        request.setAttribute("Error", "Can't load report 4 please check database");
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }
                break;
                
                case "report5":
                    list = dao.getReport5();
                    if(list != null && !list.isEmpty()){
                        request.setAttribute("REPORT_5_LIST", list);
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }else{
                        request.setAttribute("Error", "Can't load report 5 please check database");
                        request.getRequestDispatcher("MainController?action=housereport").forward(request, response);
                    }
                break;
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
