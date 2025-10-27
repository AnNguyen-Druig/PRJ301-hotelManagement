/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.RoomHouseKeeping;

import DAO.HouseKeepingTaskDAO;
import DAO.RoomDAO;
import DTO.HouseKeepingTaskDTO;
import DTO.ServiceDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mylib.IConstants;

/**
 *
 * @author Nguyễn Đại
 */
@WebServlet(name="AcceptRoomController", urlPatterns={"/AcceptRoomController"})
public class AcceptRoomController extends HttpServlet {
   
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
            HouseKeepingTaskDAO dao = new HouseKeepingTaskDAO();
            int taskId = Integer.parseInt(request.getParameter("TaskID"));
            String newStatus = request.getParameter("newStatus");
            
            if(newStatus != null){
                boolean updateResult = dao.updateTaskStatus(taskId, newStatus);
                if(updateResult) {
                    request.setAttribute("SUCCESS", "Task status updated successfully!");
                } else {
                    request.setAttribute("ERROR", "Failed to update task status!");
                }
            }
            
            if(newStatus.equalsIgnoreCase("Completed")){
                RoomDAO dao2 = new RoomDAO();
                int roomId = Integer.parseInt(request.getParameter("RoomID"));
                dao2.updateRoomStatus(roomId, "Available");
            }
            
            // Load PENDING tasks
            ArrayList<HouseKeepingTaskDTO> pendingList = dao.getAllRoomPending();
            request.setAttribute("PENDING", pendingList);
            
            // Load PROGRESS tasks  
            ArrayList<HouseKeepingTaskDTO> progressList = dao.getAllRoomProgress();
            request.setAttribute("PROGRESS", progressList);
            
            request.getRequestDispatcher("MainController?action=cleanpage").forward(request, response);
            
        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "An error occurred while processing the request!");
            request.getRequestDispatcher("MainController?action=cleanpage").forward(request, response);
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
