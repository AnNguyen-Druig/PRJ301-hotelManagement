/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.Service;

import DAO.ServiceDAO;
import DTO.ServiceDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nguyễn Đại
 */
@WebServlet(name="AddServiceController", urlPatterns={"/AddServiceController"})
public class AddServiceController extends HttpServlet {
   
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
        try {
            String id = request.getParameter("ServiceID");
            String bookingId = request.getParameter("bookingId");
            String cartKey = "CART_" + bookingId;
            
            HttpSession session = request.getSession();
            HashMap<ServiceDTO, Integer> cart = (HashMap)session.getAttribute(cartKey);
            ServiceDAO dao = new ServiceDAO();
            ServiceDTO service = dao.getService(Integer.parseInt(id));
            if(cart == null){
                cart = new HashMap<>();
                cart.put(service, 1);
            }else{
                ServiceDTO find = null;
                for (ServiceDTO s : cart.keySet()) {
                    if(s.getServiceId() == service.getServiceId()){
                        find = s;
                        break;
                    }
                }
                
                if(find != null){
                    int quantity = cart.get(find);
                    quantity++;
                    cart.put(find, quantity);
                }else{
                    cart.put(service, 1);
                }
            }
            session.setAttribute(cartKey, cart);
            // Giữ lại booking ID khi forward
//            if (bookingId != null) {
//                request.setAttribute("bookingId", bookingId);
//            }
            request.getRequestDispatcher("GetServiceController").forward(request, response);
        }catch(Exception e){
            
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
