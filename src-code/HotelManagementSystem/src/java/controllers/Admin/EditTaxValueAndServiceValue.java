/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Admin;

import DAO.Admin_DAO.UpdateServicePriceDAO;
import DAO.Basic_DAO.TaxDAO;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "EditTaxValueAndServiceValue", urlPatterns = {"/EditTaxValueAndServiceValue"})
public class EditTaxValueAndServiceValue extends HttpServlet {

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
            if (action.equals(IConstants.AC_EDIT_TAX_VALUE)) {
                double taxValue = Double.parseDouble(request.getParameter("taxvalue").trim());
                int taxID = Integer.parseInt(request.getParameter("taxid").trim());
                TaxDAO taxDAO = new TaxDAO();

                //kiểm tra xem có  = giá trị cũ ko
                double originalTaxValue = taxDAO.originalTaxValue(taxID);
                if (originalTaxValue == taxValue) {
                    request.setAttribute("MSG_TAX", IConstants.ERR_OLD_VALUE);
                } else {
                    int updateTaxValue = taxDAO.updateTaxValue(taxID, taxValue);
                    if (updateTaxValue != 0) {
                        request.setAttribute("MSG_TAX", IConstants.SUCC_EDIT_TAX_VALUE);
                    } else {
                        request.setAttribute("MSG_TAX", IConstants.SUCC_EDIT_TAX_VALUE);
                    }
                }

                request.getRequestDispatcher(IConstants.CTL_GET_ALL_TAX_AND_SERVICE).forward(request, response);
            } else if (action.equals(IConstants.AC_EDIT_SERVICE_PRICE)) {
                String servicePriceStr = request.getParameter("serviceprice");

                //thay đổi lại định dạng bên UI theo double
                double servicePrice = Double.parseDouble(servicePriceStr.trim().replace(".", ""));
                int serviceID = Integer.parseInt(request.getParameter("serviceid").trim());
                UpdateServicePriceDAO d = new UpdateServicePriceDAO();

                //Kiem tra xem co = gia cu khong
                double originalPrice = d.originalPrice(serviceID);
                if (originalPrice == servicePrice) {
                    request.setAttribute("MSG_SERVICE", IConstants.ERR_OLD_VALUE);
                } else {
                    int updateServicePrice = d.updateServicePrice(serviceID, servicePrice);
                    if (updateServicePrice != 0) {
                        request.setAttribute("MSG_SERVICE", IConstants.SUCC_EDIT_SERVICE_PRICE);
                    } else {
                        request.setAttribute("MSG_SERVICE", IConstants.ERR_EDIT_SERVICE_PRICE);
                    }
                }

                request.getRequestDispatcher(IConstants.CTL_GET_ALL_TAX_AND_SERVICE).forward(request, response);
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
