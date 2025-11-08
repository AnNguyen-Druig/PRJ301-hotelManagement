<%-- 
    Document   : checkoutpage
    Created on : Oct 20, 2025, 3:31:34 PM
    Author     : ASUS
--%>

<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="DTO.Basic_DTO.GuestDTO"%>
<%@page import="DTO.Guest_DTO.BookingRoomDetailDTO"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="DAO.Basic_DAO.RoomDAO"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="DTO.Basic_DTO.BookingServiceDTO"%>
<%@page import="DAO.Basic_DAO.ServiceDAO"%>
<%@page import="DTO.Basic_DTO.ServiceDTO"%>
<%@page import="DAO.Basic_DAO.TaxDAO"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <% GuestDTO guest = (GuestDTO) session.getAttribute("USER");
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (guest == null && staff == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
        %>  
        <h2>Bạn cần thanh toán trước khi checkout: </h2>
        <h3>Tiền phòng</h3>
        <%
            BookingRoomDetailDTO bookingRoomDetail = (BookingRoomDetailDTO) request.getAttribute("BOOKING_ROOM");
            double roomPrice = bookingRoomDetail.getPricePerNight();
            //Tính số ngày
            // 1. Chuyển đổi sang LocalDate
            LocalDate checkInLocalDate = bookingRoomDetail.getCheckInDate().toLocalDate();
            LocalDate checkOutLocalDate = bookingRoomDetail.getCheckOutDate().toLocalDate();

            // 2. Tính số ngày (số đêm)
            long numberOfNights = ChronoUnit.DAYS.between(checkInLocalDate, checkOutLocalDate);
        %>
        <!-- khi thanh toán thất bại sẽ thông báo lỗi ở đây --> 
        ${requestScope.ERROR};
        <table>
            <tr>
                <th>Số phòng</th>
                <th>Loại phòng</th>
                <th>Họ và tên người đặt phòng</th>
                <th>Ngày check-in</th>
                <th>Ngày check-out</th>
                <th>Ngày đặt phòng</th>
                <th>Số ngày ở</th>
                <th>Giá tiền/1 đêm</th>
            </tr>
            <tr>
                <td><%= bookingRoomDetail.getRoomNumber()%></td>
                <td><%= bookingRoomDetail.getRoomType()%></td>
                <td><%= bookingRoomDetail.getGuestName()%></td>
                <td><%= bookingRoomDetail.getCheckInDate()%></td>
                <td><%= bookingRoomDetail.getCheckOutDate()%></td>
                <td><%= bookingRoomDetail.getBookingDate()%></td>
                <td><%= numberOfNights%></td>
                <td><%= String.format("%,.0f VND", roomPrice).replace(',', '.')%></td>
            </tr>
        </table>
        <%
            double totalRoom = roomPrice * numberOfNights;
        %>
        <h4>Tổng tiền phòng là: <%= String.format("%,.0f VND", totalRoom).replace(',', '.')%></h4>


        <!-- ==================Phần BOOKING_SERVICE========================-->


        <h3>Tiền dịch vụ</h3>
        <%
            ArrayList<BookingServiceDTO> listBookingService = (ArrayList<BookingServiceDTO>) request.getAttribute("LIST_BOOKING_SERVICE");
            double totalService = 0;
            if (listBookingService == null || listBookingService.isEmpty()) {
        %>
        <h4>Không sử dụng dịch vụ</h4>
        <%
        } else {
        %>
        <table>
            <tr>
                <th>Tên dịch vụ</th>
                <th>Loại dịch vụ</th>
                <th>Ngày đặt dịch vụ</th>
                <th>Số lượng</th>
                <th>Giá tiền/1 phần</th>
                <th>Tiền cần thanh toán</th>
            </tr>
            <%   for (BookingServiceDTO bs : listBookingService) {
                    ServiceDAO serviceDAO = new ServiceDAO();
                    ServiceDTO service = serviceDAO.getService(bs.getServiceID());
                    double servicePrice = service.getPrice();
                    double pricePerService = servicePrice * bs.getQuantity();
                    totalService += pricePerService;
            %>
            <tr>
                <td><%= service.getServiceName()%></td>
                <td><%= service.getServiceType()%></td>
                <td><%= bs.getServiceDate()%></td>
                <td><%= bs.getQuantity()%></td>
                <td><%= String.format("%,.0f VND", servicePrice).replace(',', '.')%></td>
                <td><%= String.format("%,.0f VND", pricePerService).replace(',', '.')%></td>
            </tr>
            <%}%>
        </table>
        <%
            }
        %>
        <h4>Tổng tiền dịch vụ là: <%= String.format("%,.0f VND", totalService).replace(',', '.')%></h4>

        <%
            double total = totalRoom + totalService;

            //lấy VAT
            TaxDAO taxDAO = new TaxDAO();
            double VAT = taxDAO.getTaxValueByTaxName("VAT");
            double totalAfterVAT = (total * VAT) + total;
        %>
        <h3>TỔNG TIỀN CẦN THANH TOÁN (CHƯA TÍNH VAT) <%= String.format("%,.0f VND", total).replace(',', '.')%></h3>
        <h3>TỔNG TIỀN CẦN THANH TOÁN (ĐÃ TÍNH VAT) <%= String.format("%,.0f VND", totalAfterVAT).replace(',', '.')%></h3>
        <h3>Chọn phương thức thanh toán:</h3>

        <form action="MainController" method="post">
            <div>
                <input type="radio" id="cash" name="paymentMethod" value="Cash" checked>
                <label for="cash">Tiền mặt (Cash)</label>
            </div>

            <div>
                <input type="radio" id="credit" name="paymentMethod" value="Credit Card">
                <label for="credit">Thẻ tín dụng (Credit Card)</label>
            </div>

            <div>
                <input type="radio" id="debit" name="paymentMethod" value="Debit Card">
                <label for="debit">Thẻ ghi nợ (Debit Card)</label>
            </div>

            <div>
                <input type="radio" id="online" name="paymentMethod" value="Online">
                <label for="online">Thanh toán trực tuyến (Online)</label>
            </div>

            <br>
            <input type="hidden" name="bookingID" value="<%= bookingRoomDetail.getBookingID()%>">
            <input type="hidden" name="total" value="<%= totalAfterVAT%>">
            <button type="submit" name="action" value="<%= IConstants.AC_SAVE_PAYMENT_AND_INVOICE%>">Xác nhận thanh toán</button>
        </form> </br>
        <% if (staff != null) {
        %>
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="<%= IConstants.AC_TURNBACK_RECEPTION%>">Quay về trang Receptionist</button>
        </form>
        <%
        } else {
        %>
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="<%= IConstants.AC_GO_BACK_GUEST_PAGE%>">Quay về trang Guest</button>
        </form>
        <%
                }
            }%>
    </body>
</html>
