/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import DAO.GuestDAO;
import DTO.GuestDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
@WebServlet(name = "SignUpController", urlPatterns = {"/SignUpController"})
public class SignUpController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String url = IConstants.SIGNUP_PAGE;
        try {
            String username = request.getParameter("guest_username");
            String password = request.getParameter("guest_password");
            String password_again = request.getParameter("guest_password_again");
            String fullname = request.getParameter("guest_fullname");
            String phone = request.getParameter("guest_phone");
            String email = request.getParameter("guest_email");
            String address = request.getParameter("guest_address");
            String dateOfBirth = request.getParameter("guest_dateofbirth");
            String idNumber = request.getParameter("guest_idnumber");
            String nhanThongBaoEmail = request.getParameter("nhanemail");

            if (username != null && password != null && password_again != null && fullname != null
                    && phone != null && email != null && address != null && dateOfBirth != null && idNumber != null) {

                //Chuyển đổi dateOfBirth từ String sang Date.sql
                Date dateOfBirth_value = Date.valueOf(dateOfBirth);

                request.setAttribute("username", username);
                request.setAttribute("fullname", fullname);
                request.setAttribute("phone", phone);
                request.setAttribute("email", email);
                request.setAttribute("address", address);
                request.setAttribute("dateOfBirth", dateOfBirth);
                request.setAttribute("idNumber", idNumber);
                request.setAttribute("nhanThongBaoEmail", nhanThongBaoEmail);

                String errorMsg = "";
                GuestDAO guestDAO = new GuestDAO();
                if (guestDAO.checkUsernameExisted(username)) {
                    errorMsg += "Username already existed! Enter another username!";
                }

                if (!password.equals(password_again)) {
                    errorMsg += "Password not match!";
                }

                if (errorMsg.length() > 0) {     //Nếu có lỗi xảy ra, báo lỗi đến signup.jsp
                    url = IConstants.SIGNUP_PAGE;
                } else {        //Nếu ko có lỗi -> Xử lý tiếp
                    GuestDTO guest = new GuestDTO(fullname, phone, email, address, idNumber, dateOfBirth_value, username, password);
                    guestDAO.signUpGuest(guest);
                    url = IConstants.SIGNUP_SUCCESS_PAGE;
                }

                request.getRequestDispatcher(url).forward(request, response);
            }

        } catch (Exception e) {
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
