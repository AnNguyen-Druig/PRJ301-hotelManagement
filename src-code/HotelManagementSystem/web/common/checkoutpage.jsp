<%-- 
    Document   : checkoutpage
    Created on : Oct 20, 2025, 3:31:34 PM
    Author     : ASUS
--%>

<%@page import="DAO.TaxDAO"%>
<%@page import="mylib.IConstants"%>
<%@page import="DTO.ServiceDTO"%>
<%@page import="DAO.ServiceDAO"%>
<%@page import="DTO.BookingServiceDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page import="DTO.RoomDTO"%>
<%@page import="DAO.RoomDAO"%>
<%@page import="DTO.BookingDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Bạn cần thanh toán trước khi checkout: </h2>
        <h3>Tiền phòng</h3>
        <%
            BookingDTO bookingRoom = (BookingDTO) request.getAttribute("BOOKING_ROOM");
            RoomDAO roomDAO = new RoomDAO();
            RoomDTO room = roomDAO.getRoomByID(bookingRoom.getRoomID());
            double roomPrice = room.getPricePerNight();
            //Tính số ngày
            // 1. Chuyển đổi sang LocalDate
            LocalDate checkInLocalDate = bookingRoom.getCheckInDate().toLocalDate();
            LocalDate checkOutLocalDate = bookingRoom.getCheckOutDate().toLocalDate();

            // 2. Tính số ngày (số đêm)
            long numberOfNights = ChronoUnit.DAYS.between(checkInLocalDate, checkOutLocalDate);
        %>
        <table>
            <tr>
                <th>Số phòng</th>
                <th>Loại phòng</th>
                <th>Họ và tên người đặt phòng</th>
                <th>Ngày check-in</th>
                <th>Ngày check-out</th>
                <th>Số ngày ở</th>
                <th>Giá tiền/1 đêm</th>
            </tr>
            <tr>
                <td><%= bookingRoom.getRoomNumber()%></td>
                <td><%= bookingRoom.getRoomType()%></td>
                <td><%= bookingRoom.getGuestName()%></td>
                <td><%= bookingRoom.getCheckInDate()%></td>
                <td><%= bookingRoom.getCheckOutDate()%></td>
                <td><%= numberOfNights%></td>
                <td><%= roomPrice%></td>
            </tr>
        </table>
        <%
            double totalRoom = roomPrice * numberOfNights;
        %>
        <h4>Tổng tiền phòng là: <%= totalRoom%></h4>


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
            <%                        for (BookingServiceDTO bs : listBookingService) {
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
                <td><%= servicePrice%></td>
                <td><%= pricePerService%></td>
            </tr>
            <%}%>
        </table>
        <%
            }
        %>
        <h4>Tổng tiền dịch vụ là: <%= totalService%></h4>

        <%
            double total = totalRoom + totalService;
            
            //lấy VAT
            TaxDAO taxDAO = new TaxDAO();
            double VAT = taxDAO.getTaxValueByTaxName("VAT");
            double totalAfterVAT = (total * VAT) + total;
        %>
        <h3>TỔNG TIỀN CẦN THANH TOÁN (CHƯA TÍNH VAT) <%= total %></h3>
        <h3>TỔNG TIỀN CẦN THANH TOÁN (ĐÃ TÍNH VAT) <%= totalAfterVAT %></h3>
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
            <input type="hidden" name="bookingID" value="<%= bookingRoom.getBookingID() %>">
            <input type="hidden" name="total" value="<%= totalAfterVAT %>">
            <button type="submit" name="action" value="<%= IConstants.AC_SAVE_PAYMENT_AND_INVOICE %>">Xác nhận thanh toán</button>
        </form>
    </body>
</html>
