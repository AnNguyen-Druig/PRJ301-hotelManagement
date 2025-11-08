/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Admin;

import DAO.Basic_DAO.ServiceDAO;
import DAO.Basic_DAO.TaxDAO;
import DTO.Basic_DTO.ServiceDTO;
import DTO.Basic_DTO.TaxDTO;
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
 * @author ASUS
 */
@WebServlet(name="GetAllTaxAndService", urlPatterns={"/GetAllTaxAndService"})
public class GetAllTaxAndService extends HttpServlet {
   
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
            TaxDAO taxDAO = new TaxDAO();
            ArrayList<TaxDTO> listTax = taxDAO.getAllTax();
            if(listTax!=null && !listTax.isEmpty()) {
                request.setAttribute("LIST_TAX", listTax);
            } else {
                request.setAttribute("ERROR_LISTTAX", IConstants.ERR_EMPTY_LIST_TAX);
            }
            
            ServiceDAO serviceDAO = new ServiceDAO();
            ArrayList<ServiceDTO> listService = serviceDAO.getAllService();
            if(listService!=null && !listService.isEmpty()) {
                request.setAttribute("LIST_SERVICE", listService);
            } else {
                request.setAttribute("ERROR_LISTSERVICE", IConstants.ERR_EMPTY_LIST_SERVICE);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(IConstants.SHOW_TAX_AND_SERVICE_PAGE).forward(request, response);
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
