/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Common;

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
                    url = IConstants.CTL_LOGIN;
                    break;
                case IConstants.AC_LOGINGUEST:
                    url = IConstants.CTL_LOGIN;
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
                case IConstants.AC_FILTER_ROOM:
                    url = IConstants.CTL_FILTERROOM;
                    break;
                case IConstants.AC_UPDATE_STATUS:
                    url = IConstants.CTL_MANAGE_ROOM_STATUS;
                    break;
                case IConstants.AC_PERFORM_UPDATE: 
                    url = IConstants.CTL_MANAGE_ROOM_STATUS;
                    break;
                case IConstants.AC_SAVE_BOOKING_ROOM:
                    url = IConstants.CTL_SAVE_BOOKING_ROOM;
                    break;
                case IConstants.AC_GET_ROOM_SERVICE:
                    url = IConstants.CTL_SERVICE_ROOM_CONTROLLER;
                    break;
                case IConstants.AC_CHOOSE_SERVICE_PAGE:
                    url = IConstants.CTL_GET_SERVICE_CONTROLLER;
                    break;
                case IConstants.AC_GO_STATUS:
                    url = IConstants.CTL_MANAGE_ROOM_STATUS;
                    break;
                case IConstants.AC_MAKENEWBOOKING:
                    url = IConstants.CTL_BOOKINGBY_GUESTIDNUMBER;
                    break;
                case IConstants.AC_UPDATE_BOOKING:
                    url = IConstants.CTL_UPDATE_BOOKING_IN_RECEPTION;
                    break;
                case IConstants.AC_TURNBACK_RECEPTION:
                    url = IConstants.CTL_SHOW_BOOKING_IN_RECEPTION;
                    break;
                case IConstants.AC_VIEW_BOOKING:
                    url = IConstants.CTL_VIEW_BOOKING;
                    break;
                case IConstants.AC_SAVE_BOOKING_SERVICE:
                    url = IConstants.CTL_EDIT_SERVICE;
                    break;
                case IConstants.AC_UPDATE_BOOKING_SERVICE:
                    url = IConstants.CTL_EDIT_SERVICE;
                    break;
                case IConstants.AC_DELETE_BOOKING_SERVICE:
                    url = IConstants.CTL_EDIT_SERVICE;
                    break;
                case IConstants.AC_ADD_SERVICE:
                    url = IConstants.CTL_ADD_SERVICE;
                    break;
                case IConstants.AC_SAVE_BOOKING_UPDATE:
                    url = IConstants.CTL_SAVE_BOOKING_UPDATE;
                    break;
                case IConstants.AC_CHECKOUT_BOOKING_ROOM:
                    url = IConstants.CTL_GET_BOOKING_ROOM;
                    break;
                case IConstants.AC_SAVE_PAYMENT_AND_INVOICE:
                    url = IConstants.CTL_SAVE_PAYMENT_AND_INVOICE;
                    break;
                case IConstants.AC_CHANGE_STATUS_CHECKIN:
                    url = IConstants.CTL_CHANGE_STATUS_BOOKING_CHECKIN;
                    break;
                case IConstants.AC_CHANGE_STATUS_CANCEL:
                    url = IConstants.CTL_CHANGE_STATUS_BOOKING_CANCEL;
                    break;
                case IConstants.AC_CHANGE_STATUS_CHECKOUT:
                    url = IConstants.CTL_CHANGE_STATUS_BOOKING_CHECKOUT;
                    break;
                case IConstants.AC_CHANGE_STATUS_COMPLETE:
                    url = IConstants.CTL_CHANGE_STATUS_BOOKING_COMPLETE;
                    break;
                case IConstants.AC_VIEW_REPORT_PAGE:
                    url = IConstants.REPORT_MAIN_PAGE;
                    break;
                case IConstants.AC_REPORT_1_PAGE:
                    url = IConstants.REPORT_1_PAGE;
                    break;
                case IConstants.AC_REPORT_2_PAGE:
                    url = IConstants.REPORT_2_PAGE;
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
