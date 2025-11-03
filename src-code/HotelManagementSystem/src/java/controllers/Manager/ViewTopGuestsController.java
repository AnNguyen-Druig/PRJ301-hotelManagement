/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Manager;

import DAO.Manager_DAO.TopFrequentGuestDAO;
import DTO.Manager_DTO.TopFrequentGuestDTO;
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
 * @author Admin
 */
@WebServlet(name="ViewTopGuestsController", urlPatterns={"/ViewTopGuestsController"})
public class ViewTopGuestsController extends HttpServlet {
   
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
        String url = IConstants.VIEW_TOP_GUEST_PAGE;
        try {
            TopFrequentGuestDAO topFrequentGuestDAO = new TopFrequentGuestDAO();
            ArrayList<TopFrequentGuestDTO> list = topFrequentGuestDAO.getTop10FrequentGuest();
            if(list != null && !list.isEmpty()) {
                request.setAttribute("ALL_GUEST_LIST", list);
            } else {
                request.setAttribute("ERROR", IConstants.ERR_GUESTLIST_EMPTY);
            }
            
            ArrayList<TopFrequentGuestDTO> highestMoneyList = topFrequentGuestDAO.getGuestHighestMoney();
            if(highestMoneyList != null && !highestMoneyList.isEmpty()) {
                request.setAttribute("HIGHEST_MONEY_LIST", highestMoneyList);
            } else {
                request.setAttribute("ERROR", IConstants.ERR_GUESTLIST_EMPTY);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
