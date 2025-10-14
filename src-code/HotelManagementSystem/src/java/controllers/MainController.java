/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mylib.IConstants;

/**
 *
 * @author Admin
 */
public class MainController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = IConstants.DEFAULT_PAGE;
        try {
            String action = request.getParameter("action");
            if (action == null) {
                action = IConstants.AC_DEFAULT;
            }

            switch (action) {
                case IConstants.AC_DEFAULT:
                    url = IConstants.DEFAULT_PAGE;
                    break;
                case IConstants.AC_SIGNUP:
                    url = IConstants.CTL_SIGNUP;
                    break;
                case IConstants.AC_LOGINSTAFF:
                    url = IConstants.CTL_LOGINSTAFF;
                    break;
                case IConstants.AC_LOGINGUEST:
                    url = IConstants.CTL_LOGINGUEST;
                    break;
                case IConstants.AC_LOGOUT:
                    url = IConstants.CTL_LOGOUT;
                    break;
                case IConstants.AC_BOOKING:
                    url = IConstants.CTL_GETROOM ;
                    break;
                case IConstants.AC_BOOKING_ROOM:
                    url = IConstants.CTL_BOOKING_ROOM;
                    break;
<<<<<<< HEAD
                case IConstants.AC_UPDATE_STATUS:
                    url = IConstants.CTL_MANAGE_ROOM_STATUS;
                    break;
                case IConstants.AC_PERFORM_UPDATE: 
                    url = IConstants.CTL_MANAGE_ROOM_STATUS;
=======
                case IConstants.AC_SAVE_BOOKING_ROOM:
                    url = IConstants.CTL_SAVE_BOOKING_ROOM;
>>>>>>> 85193788154a760a9aeeb7745e3a7b6335f93a1b
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                request.getRequestDispatcher(url).forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
