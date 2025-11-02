/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Admin;

import DAO.GuestDAO;
import DAO.StaffDAO;
import DTO.GuestDTO;
import DTO.StaffDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
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
@WebServlet(name = "SignUpStaffController", urlPatterns = {"/SignUpStaffController"})
public class SignUpStaffController extends HttpServlet {

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
            String username = request.getParameter("staff_username");
            String password = request.getParameter("staff_password");
            String password_again = request.getParameter("staff_password_again");
            String fullname = request.getParameter("staff_fullname");
            String phone = request.getParameter("staff_phone");
            String email = request.getParameter("staff_email");
            String address = request.getParameter("staff_address");
            String dateOfBirth = request.getParameter("staff_dateofbirth");
            String idNumber = request.getParameter("staff_idnumber");
            String role = request.getParameter("staff_role");
            String status = request.getParameter("staff_status");

            if (username != null && password != null && password_again != null && fullname != null
                    && phone != null && email != null && address != null && dateOfBirth != null && idNumber != null
                    && role != null && status != null) {

                StaffDAO staffDAO = new StaffDAO();
                boolean hasError = false;
                
                //Chuyển đổi dateOfBirth từ String sang Date.sql
                Date dateOfBirth_value = Date.valueOf(dateOfBirth);
                LocalDate dob = dateOfBirth_value.toLocalDate();
                // 2. Lấy ngày hiện tại
                LocalDate currentDate = LocalDate.now();
                // 3. Tính toán khoảng thời gian
                int age = Period.between(dob, currentDate).getYears();
                // 4. (Tùy chọn) Thêm kiểm tra độ tuổi
                if (age < 18) {
                    request.setAttribute("ERROR_DATEOFBIRTH", IConstants.ERR_NOT_ENOUGH_18);
                    hasError = true;
                }

                // Kiểm tra username
                if (staffDAO.checkUsernameExisted(username)) {
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
                    request.getRequestDispatcher(IConstants.SIGN_UP_STAFF_PAGE).forward(request, response);
                    return;
                }

                StaffDTO staff = new StaffDTO(fullname, role, username, password, phone, email, address, idNumber, dateOfBirth_value, status);
                int signUpStaff = staffDAO.createStaff(staff);
                if (signUpStaff != 0) {
                    request.getRequestDispatcher(IConstants.SIGNUP_SUCCESS_PAGE).forward(request, response);
                }
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
        request.getRequestDispatcher(IConstants.SIGN_UP_STAFF_PAGE).forward(request, response);
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
