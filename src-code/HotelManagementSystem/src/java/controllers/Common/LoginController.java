/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Common;

import DAO.GuestDAO;
import DAO.StaffDAO;
import DTO.GuestDTO;
import DTO.StaffDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mylib.IConstants;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

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
        try {
            String action = request.getParameter("action");
            String username = request.getParameter("txtusername");
            String password = request.getParameter("txtpassword");
            HttpSession session = request.getSession();
            request.setAttribute("username", username);
            if (username != null && !username.trim().isEmpty()
                    && password != null && !password.trim().isEmpty()) {
                if (action.equalsIgnoreCase("Login Staff")) {
                    try {
                        StaffDAO staffDAO = new StaffDAO();
                        StaffDTO staff = staffDAO.getLoginStaff(username, password);
                        if (staff != null  && staff.getStatus().equals("Active")) {
                            session.setAttribute("USER", staff);

                            String role = staff.getRole();
                            String url = IConstants.LOGIN_PAGE;

                            switch (role) {
                                case "Admin":
                                    url = IConstants.CTL_GET_ALL_STAFF;
                                    break;
                                case "Receptionist":
                                    url = IConstants.CTL_SHOW_BOOKING_IN_RECEPTION;
                                    break;
                                case "Manager":
                                    url = IConstants.MANAGER_PAGE;
                                    break;
                                case "Housekeeping":
                                    request.getRequestDispatcher("MainController?action=" + IConstants.AC_GO_STATUS).forward(request, response);
                                    return;
                                case "ServiceStaff":
                                    request.getRequestDispatcher("MainController?action=" + IConstants.AC_GET_ROOM_SERVICE).forward(request, response);
                                    return;
                                default:
                                    url = IConstants.LOGIN_PAGE;
                                    break;
                            }
                            request.getRequestDispatcher(url).forward(request, response);
                        } else {
                            request.setAttribute("ERROR", IConstants.ERR_INVALID_LOGIN);
                            request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else if (action.equalsIgnoreCase("Login Member")) {
                    try {
                        GuestDAO guestDAO = new GuestDAO();
                        GuestDTO guest = guestDAO.getLoginMember(username, password);
                        if (guest != null) {
                            session.setAttribute("USER", guest);

                            String url = IConstants.GUEST_PAGE;
                            request.getRequestDispatcher(url).forward(request, response);
                        } else {
                            request.setAttribute("ERROR", IConstants.ERR_INVALID_LOGIN);
                            request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } else {
                request.setAttribute("ERROR", IConstants.ERR_EMPTY_FIELD);
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        // Lần đầu vào chỉ show form login, KHÔNG check lỗi
        request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
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
