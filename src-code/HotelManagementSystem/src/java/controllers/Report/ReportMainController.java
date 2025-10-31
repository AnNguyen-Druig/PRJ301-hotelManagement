/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Report;

import DAO.ReportDAO;
import DTO.ReportDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
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
@WebServlet(name="ReportMainController", urlPatterns={"/ReportMainController"})
public class ReportMainController extends HttpServlet {
   
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
        String action = request.getParameter("action");
        if (action == null) action = IConstants.REPORT_MAIN_PAGE;
        ReportDAO dao = new ReportDAO();
        ArrayList<ReportDTO> list = new ArrayList<>();
        try {
            switch(action){
                case "report1":
                    list = dao.report1();
                    if(list != null && !list.isEmpty()){
                        request.setAttribute("REPORT_1_LIST", list);
                        request.getRequestDispatcher("MainController?action=reportpage").forward(request, response);
                    }else{
                        request.setAttribute("Error", "Can't load report 1 please check database");
                        request.getRequestDispatcher("MainController?action=reportpage").forward(request, response);
                    }
                break;
                
                case "report2":
                    list = dao.report2();
                    if(list != null && !list.isEmpty()){
                        request.setAttribute("REPORT_2_LIST", list);
                        request.getRequestDispatcher("MainController?action=reportpage").forward(request, response);
                    }else{
                        request.setAttribute("Error", "Can't load report 2 please check database");
                        request.getRequestDispatcher("MainController?action=reportpage").forward(request, response);
                    }
                break;
                
                case "report3":
                    list = dao.report3();
                    if(list != null && !list.isEmpty()){
                        request.setAttribute("REPORT_3_LIST", list);
                        request.getRequestDispatcher("MainController?action=reportpage").forward(request, response);
                    }else{
                        request.setAttribute("Error", "Can't load report 3 please check database");
                        request.getRequestDispatcher("MainController?action=reportpage").forward(request, response);
                    }
                break;
                
                case "report4":
                    String serviceDateStr = request.getParameter("serviceDate");
                    if (serviceDateStr == null || serviceDateStr.trim().isEmpty()) {
                        request.setAttribute("Error", "Please choose a service date for report 4.");
                        request.getRequestDispatcher("MainController?action=reportpage").forward(request, response);
                        return;
                    }

                    Date serviceDate = Date.valueOf(serviceDateStr);
                    list = dao.report4(serviceDate);
                    request.setAttribute("SHOW_REPORT", "report4");
                    request.setAttribute("REPORT_4_DATE", serviceDateStr);
                    request.setAttribute("REPORT_4_LIST", list);
                    request.getRequestDispatcher("MainController?action=reportpage").forward(request, response);
                break;
                
                case "manaReport":
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
                break;
            }
          
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("Error", "Error loading report: " + e.getMessage());
            request.getRequestDispatcher("MainController?action=reportpage").forward(request, response);
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
