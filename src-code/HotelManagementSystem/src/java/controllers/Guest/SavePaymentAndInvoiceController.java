
package controllers.Guest;

import DAO.Basic_DAO.BookingDAO;
import DAO.Basic_DAO.GuestDAO;
import DAO.Basic_DAO.InvoiceDAO;
import DAO.Basic_DAO.PaymentDAO;
import DAO.Guest_DAO.ShowRoomDAO;
import DAO.Receptionist_DAO.ShowBookingDAO;
import DTO.Basic_DTO.BookingDTO;
import DTO.Basic_DTO.GuestDTO;
import DTO.Basic_DTO.InvoiceDTO;
import DTO.Basic_DTO.PaymentDTO;
import DTO.Guest_DTO.ShowRoomDTO;
import DTO.Receptionist_DTO.ShowBookingDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mylib.IConstants;

import javax.servlet.annotation.WebServlet;

/**
 *
 * @author ASUS
 */
@WebServlet(name="SavePaymentAndInvoiceController", urlPatterns={"/SavePaymentAndInvoiceController"})
public class SavePaymentAndInvoiceController extends HttpServlet {
   
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
        int bookingID = Integer.parseInt(request.getParameter("bookingID").trim());
        double total = Double.parseDouble(request.getParameter("total").trim());
        String paymentMethod = request.getParameter("paymentMethod");
        
        ShowBookingDAO showBookingDAO = new ShowBookingDAO();
        BookingDAO booking = new BookingDAO();
        boolean updateBookingRoomStatus = booking.updateStatusBooking(bookingID, "CheckOut");
        ShowBookingDTO bookingRoom = showBookingDAO.getBookingByBookingIDInReception(bookingID);
        
        //Lay Room
        ShowRoomDAO roomDAO = new ShowRoomDAO();
        ShowRoomDTO room = roomDAO.getRoomByID(bookingRoom.getRoomID());
        request.setAttribute("ROOM", room);
        
        GuestDAO guestDAO = new GuestDAO();
        GuestDTO guest = guestDAO.getGuestByID(bookingRoom.getGuestID());
        request.setAttribute("GUEST_DETAIL", guest);
        
        //Ko lay Guest vi guest o session
             
        InvoiceDAO invoiceDAO = new InvoiceDAO();
        int saveInvoice = invoiceDAO.saveInvoiceStatusPaid(bookingID, total);
        InvoiceDTO invoice = invoiceDAO.getInvoiceByBookingID(bookingID);
        request.setAttribute("INVOICE", invoice);
        
        PaymentDAO paymentDAO = new PaymentDAO();
        int savePayment = paymentDAO.savePaymentStatusCompleted(bookingID, total, paymentMethod);
        PaymentDTO payment = paymentDAO.getPaymentByBookingID(bookingID);
        request.setAttribute("PAYMENT", payment);
        
        if(saveInvoice!=0 && savePayment!=0 && updateBookingRoomStatus==true) {
            request.getRequestDispatcher(IConstants.INVOICE_PAGE).forward(request, response);
        } else {
            request.setAttribute("ERROR", IConstants.ERR_SAVE_PAYMENT_AND_INVOICE);
            request.getRequestDispatcher(IConstants.CHECKOUT_PAGE).forward(request, response);
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
