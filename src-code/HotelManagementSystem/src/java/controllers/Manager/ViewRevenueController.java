/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Manager;

import DAO.Basic_DAO.InvoiceDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;
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
@WebServlet(name = "ViewRevenueController", urlPatterns = {"/ViewRevenueController"})
public class ViewRevenueController extends HttpServlet {

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
        String url = IConstants.VIEW_REVENUE_REPORT_PAGE;
        try {
            //Khai báo DAO cần thiết
            InvoiceDAO invoiceDAO = new InvoiceDAO();

            //Hứng dữ liệu từ revenuereportpage.jsp
            String selectDate = request.getParameter("selectDate");
            String selectMonth = request.getParameter("month");
            String selectYear = request.getParameter("year");
            String selectYearOnly = request.getParameter("selectYear");

            //Lấy ngày mặc định khi tải trang lần đầu
            String defaultToday = java.time.LocalDate.now().toString();

            //Khai báo các biến dùng để thực hiện chức năng tính doanh thu ngày, tháng/năm
            Double totalRevenueByDate = null;
            Double totalRevenueByMonth = null;
            Double totalRevenueByYear = null;
            int selectMonth_value;
            int selectYear_value;
            int selectYearOnly_value;
            if (selectDate != null && !selectDate.trim().isEmpty()
                    && defaultToday != null && !defaultToday.trim().isEmpty()
                    && selectMonth != null && !selectMonth.trim().isEmpty()
                    && selectYear != null && !selectYear.trim().isEmpty()
                    && selectYearOnly != null && !selectYearOnly.trim().isEmpty()) {

                //Convert kiểu dữ liệu
                Date selectDate_value = Date.valueOf(selectDate);

                selectMonth_value = Integer.parseInt(selectMonth);
                selectYear_value = Integer.parseInt(selectYear);
                selectYearOnly_value = Integer.parseInt(selectYearOnly);

                totalRevenueByDate = invoiceDAO.getTotalRevenueByDate(selectDate_value);
                if (totalRevenueByDate != null) {
                    request.setAttribute("REVENUE_BY_SELECT_DATE", totalRevenueByDate);
                }
                request.setAttribute("SELECTED_DATE", selectDate);

                if (selectMonth_value < 1 || selectMonth_value > 12) {
                    request.setAttribute("ERROR", IConstants.ERR_INVALID_ROOM_MONTH);
                } else {
                    totalRevenueByMonth = invoiceDAO.getTotalRevenueByMonth(selectMonth_value, selectYear_value);
                    if (totalRevenueByMonth != null) {
                        request.setAttribute("REVENUE_BY_MONTH", totalRevenueByMonth);
                    } else {
                        request.setAttribute("ERROR", IConstants.ERR_EMPTY_TOTAL_REVENUE);
                    }
                    request.setAttribute("SELECT_MONTH", selectMonth_value);
                    request.setAttribute("SELECT_YEAR", selectYear_value);
                }
                
                totalRevenueByYear = invoiceDAO.getTotalRevenueByYear(selectYearOnly_value);
                if(totalRevenueByYear != null) {
                    request.setAttribute("REVENUE_BY_SELECT_YEAR", totalRevenueByYear);
                }
                request.setAttribute("SELECTED_YEAR_ONLY", selectYearOnly_value);
            } else if (selectDate == null || selectDate.trim().isEmpty()
                    || selectMonth == null || selectMonth.trim().isEmpty()
                    || selectYear == null || selectYear.trim().isEmpty()
                    || selectYearOnly == null || selectYearOnly.trim().isEmpty()) {
                Date defaultToday_value = Date.valueOf(defaultToday);
                totalRevenueByDate = invoiceDAO.getTotalRevenueByDate(defaultToday_value);
                if (totalRevenueByDate != null) {
                    request.setAttribute("REVENUE_BY_SELECT_DATE", totalRevenueByDate);
                }
                request.setAttribute("SELECTED_DATE", defaultToday);
                Calendar now = Calendar.getInstance();
                selectMonth_value = now.get(Calendar.MONTH) + 1; //+ 1: vì MONTH nó tính tháng 1 là 0 --> bắt đầu là 0 nên phải + 1
                selectYear_value = now.get(Calendar.YEAR);
                if (selectMonth_value < 1 || selectMonth_value > 12) {
                    request.setAttribute("ERROR", IConstants.ERR_INVALID_ROOM_MONTH);
                } else {
                    totalRevenueByMonth = invoiceDAO.getTotalRevenueByMonth(selectMonth_value, selectYear_value);
                    if (totalRevenueByMonth != null) {
                        request.setAttribute("REVENUE_BY_MONTH", totalRevenueByMonth);
                    } else {
                        request.setAttribute("ERROR", IConstants.ERR_EMPTY_TOTAL_REVENUE);
                    }
                    request.setAttribute("SELECT_MONTH", selectMonth_value);
                    request.setAttribute("SELECT_YEAR", selectYear_value);
                }
                
                selectYearOnly_value = now.get(Calendar.YEAR);
                totalRevenueByYear = invoiceDAO.getTotalRevenueByYear(selectYearOnly_value);
                if(totalRevenueByYear != null) {
                    request.setAttribute("REVENUE_BY_SELECT_YEAR", totalRevenueByYear);
                }
                request.setAttribute("SELECTED_YEAR_ONLY", selectYearOnly_value);
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
