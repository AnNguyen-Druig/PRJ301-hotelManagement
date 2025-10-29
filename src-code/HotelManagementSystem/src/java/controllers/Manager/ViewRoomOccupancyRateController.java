/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.Manager;

import DAO.RoomOccupancyDAO;
import DTO.RoomOccupancyDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "ViewRoomOccupancyRateController", urlPatterns = {"/ViewRoomOccupancyRateController"})
public class ViewRoomOccupancyRateController extends HttpServlet {

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
        String url = IConstants.VIEW_ROOM_OCCUPANCY_PAGE;
        try {
            String checkInMonth = request.getParameter("month");
            String checkInYear = request.getParameter("year");

            int checkInMonth_value = Integer.parseInt(checkInMonth);
            int checkInYear_value = Integer.parseInt(checkInYear);

            if (checkInMonth_value < 1 || checkInMonth_value > 12) {
                request.setAttribute("ERROR", IConstants.ERR_INVALID_ROOM_MONTH);
            } else {
                RoomOccupancyDAO roomDAO = new RoomOccupancyDAO();
                ArrayList<RoomOccupancyDTO> list = roomDAO.getRoomOccupancyRatePerMonth(checkInMonth_value, checkInYear_value);
                if (list != null && !list.isEmpty()) {
                    request.setAttribute("ROOM_OCCUPANCY_LIST", list);
                } else {
                    request.setAttribute("ERROR", IConstants.ERR_EMPTY_ROOM_OCCUPANCY_LIST);
                }
            }
            request.setAttribute("SELECTED_MONTH", checkInMonth_value);
            request.setAttribute("SELECTED_YEAR", checkInYear_value);

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
