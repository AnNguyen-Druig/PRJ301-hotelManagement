/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Admin;

import DAO.Basic_DAO.GuestDAO;
import DAO.Basic_DAO.StaffDAO;
import DTO.Basic_DTO.GuestDTO;
import DTO.Basic_DTO.StaffDTO;
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
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
            String action = request.getParameter("action");

            if (username != null && password != null && password_again != null && fullname != null
                    && phone != null && email != null && address != null && dateOfBirth != null && idNumber != null
                    && role != null && status != null) {
                //Phân biệt Signup và Update bằng staffID vì Signup ko có staffID
                String staffIDStr = request.getParameter("staffID");

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
                //staffID == null thì là signup nên cần kiểm tra
                if (staffIDStr == null) {
                    if (staffDAO.checkUsernameExisted(username)) {
                        request.setAttribute("ERROR_USERNAME", IConstants.ERR_INVALID_USERNAME);
                        hasError = true;
                    }
                } else { //nếu khác null là update
                    int staffID = Integer.parseInt(staffIDStr.trim());
                    //lấy tên gốc 
                    String originalUsername = staffDAO.getUsernameByStaffID(staffID);

                    //chỉ kiểm tra trùng lặp username khi mà tên gốc khác tên username hứng ở trên
                    if (!username.equals(originalUsername) && staffDAO.checkUsernameExisted(username)) {
                        request.setAttribute("ERROR_USERNAME", IConstants.ERR_INVALID_USERNAME);
                        hasError = true;
                    }
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
                } else if (request.getParameter("staffID") == null) {
                    if (staffDAO.checkIDNumberExisted(idNumber)) {
                        request.setAttribute("ERROR_IDNUMBER", IConstants.ERR_IDNUMBER_EXISTED);
                        hasError = true;
                    }
                }

                if (hasError && action.equals(IConstants.AC_SIGN_UP_STAFF)) {
                    request.getRequestDispatcher(IConstants.SIGN_UP_STAFF_PAGE).forward(request, response);
                    return;
                } else if (hasError && action.equals(IConstants.AC_EDIT_STAFF)) {
                    //khi có lỗi quay về editpage thì STAFF trong requestScope đã biến mất nên cần phải gửi lại STAFF
                    int staffID = Integer.parseInt(staffIDStr.trim());
                    StaffDTO staff = staffDAO.getStaffByID(staffID);
                    request.setAttribute("STAFF", staff);
                    request.getRequestDispatcher(IConstants.EDIT_STAFF_PAGE).forward(request, response);
                    return;
                }

                if (action.equals(IConstants.AC_SIGN_UP_STAFF)) {
                    StaffDTO staff = new StaffDTO(fullname, role, username, password, phone, email, address, idNumber, dateOfBirth_value, status);
                    int signUpStaff = staffDAO.createStaff(staff);
                    if (signUpStaff != 0) {
                        request.setAttribute("SUCCESS", IConstants.SUCC_SIGNUP);
                        request.getRequestDispatcher(IConstants.SIGN_UP_STAFF_PAGE).forward(request, response);
                    }
                } else {
                    //staffID tu editpage gui qua 
                    int staffID = Integer.parseInt(staffIDStr.trim());
                    if (action.equals(IConstants.AC_EDIT_STAFF)) {
                        int updateStaff = staffDAO.updateStaff(staffID, username, password, phone, email, address, role, dateOfBirth_value, status);
                        if (updateStaff != 0) {
                            request.setAttribute("SUCCESS_MSG", IConstants.SUCC_UPDATE_STAFF);
                        } else {
                            request.setAttribute("ERROR_MSG", IConstants.ERR_UPDATE_STAFF);
                        }
                        //lấy đối tượng STAFF nếu người dùng muốn update tiếp
                        StaffDTO staff = staffDAO.getStaffByID(staffID);
                        request.setAttribute("STAFF", staff);
                        request.getRequestDispatcher(IConstants.EDIT_STAFF_PAGE).forward(request, response);
                    }
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
