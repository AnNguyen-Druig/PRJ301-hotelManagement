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

        //String url = IConstants.SIGNUP_PAGE;
        String url = "";
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

                GuestDAO guestDAO = new GuestDAO();
                boolean hasError = false;

                // Kiểm tra username
                if (guestDAO.checkUsernameExisted(username)) {
                    request.setAttribute("ERROR_USERNAME", IConstants.ERR_INVALID_USERNAME);
                    hasError = true;
                }

                // Kiểm tra mật khẩu
                if (!password.equals(password_again)) {
                    request.setAttribute("ERROR_PASSWORD", IConstants.ERR_INVALID_PASSWORDNOTMATCH);
                    hasError = true;
                } else if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")) {
                    request.setAttribute("ERROR_PASSWORD", IConstants.ERR_INVALID_PASSWORDFORM);
                    hasError = true;
                }

                // Kiểm tra họ tên
                if (!fullname.matches("^[A-Za-zÀ-ỹ\\s]+$")) {
                    request.setAttribute("ERROR_FULLNAME", IConstants.ERR_INVALID_FULLNAME);
                    hasError = true;
                }

                // Kiểm tra số điện thoại
                if (!phone.matches("^0\\d{9}$")) {
                    request.setAttribute("ERROR_PHONE", IConstants.ERR_INVALID_PHONE);
                    hasError = true;
                }

                // Kiểm tra email
                if (!email.matches("^[^@]+@[^@]+\\.[^@]+$")) {
                    request.setAttribute("ERROR_EMAIL", IConstants.ERR_INVALID_EMAIL);
                    hasError = true;
                }

                // Kiểm tra CCCD
                if (!idNumber.matches("^\\d{12}$")) {
                    request.setAttribute("ERROR_IDNUMBER", IConstants.ERR_INVALID_IDNUMBER);
                    hasError = true;
                }

                if (hasError) {
                    request.getRequestDispatcher(IConstants.SIGNUP_PAGE).forward(request, response);
                    return;
                }

                GuestDTO guest = new GuestDTO(fullname, phone, email, address, idNumber, dateOfBirth_value, username, password);
                guestDAO.signUpGuest(guest);
                url = IConstants.SIGNUP_SUCCESS_PAGE;

                request.getRequestDispatcher(url).forward(request, response);
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
        // Lần đầu vào chỉ show form signup, KHÔNG check lỗi
        request.getRequestDispatcher(IConstants.SIGNUP_PAGE).forward(request, response);
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
