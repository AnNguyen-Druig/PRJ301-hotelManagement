/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers.RoomHouseKeeping;

import DAO.Basic_DAO.RoomDAO;
import DAO.HouseKeepingDAO.GetRoomForHouseKeepingDAO;
import DTO.Basic_DTO.RoomDTO;
import DTO.HouseKeeping_DTO.GetRoomForHouseKeepingDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mylib.IConstants;

/**
 *
 * @author Nguyễn Đại
 */
@WebServlet(name="ManageRoomStatus", urlPatterns={"/ManageRoomStatus"})
public class ManageRoomStatus extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // controllers/ManageRoomStatus.java

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = IConstants.MANAGE_ROOM_STATUS;
        try {
            GetRoomForHouseKeepingDAO dao = new GetRoomForHouseKeepingDAO();
            ArrayList<GetRoomForHouseKeepingDTO> list = dao.getAllRoomsForManager();
            if(list != null && !list.isEmpty()){
                request.setAttribute("ROOM_LIST", list);
            }else{
                request.setAttribute("ERROR", "No room found in database");
            }
        }catch(Exception e){
            e.printStackTrace();
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
        String url = IConstants.MANAGE_ROOM_STATUS;
       try {
            String action = request.getParameter("action");
            GetRoomForHouseKeepingDAO dao = new GetRoomForHouseKeepingDAO();

            if (IConstants.AC_PERFORM_UPDATE.equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                String newStatus = request.getParameter("newStatus");
                dao.updateRoomStatus(roomId, newStatus);
            }
            
            List<GetRoomForHouseKeepingDTO> roomList = dao.getAllRoomsForManager();
            request.setAttribute("ROOM_LIST", roomList);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
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
