<%-- 
    Document   : bookingroomview
    Created on : Oct 19, 2025, 2:35:31 PM
    Author     : ASUS
--%>

<%@page import="DTO.BookingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mylib.IConstants"%>
<%@page import="DTO.GuestDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            GuestDTO guest = (GuestDTO) session.getAttribute("USER");
            if (guest == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
        %>
        <h2>Các Đơn Đặt Phòng Đã Giữ Chỗ</h2>
        <%
            ArrayList<BookingDTO> listReservedBooking = (ArrayList<BookingDTO>) request.getAttribute("RESERVED_BOOKING");
            if (listReservedBooking != null && !listReservedBooking.isEmpty()) {
        %>
        <table>
            <tr>
                <th>Booking ID</th>
                <th>Guest ID</th>
                <th>Guest Name</th>
                <th>Room ID</th>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Check-in Date</th>
                <th>Check-out Date</th>
                <th>Booking Date</th>
                <th>Status</th>
                    <%
                        for (BookingDTO b : listReservedBooking) {
                    %>
            <tr> 
                <td><%= b.getBookingID()%></td>
                <td><%= b.getGuestID()%></td>
                <td><%= b.getGuestName()%></td>
                <td><%= b.getRoomID()%></td>
                <td><%= b.getRoomNumber()%></td>
                <td><%= b.getRoomType()%></td>
                <td><%= b.getCheckInDate()%></td>
                <td><%= b.getCheckOutDate()%></td>
                <td><%= b.getBookingDate()%></td>
                <td><%= b.getStatus()%></td>
            </tr> 
            <%
                }
            %>
        </table>
        <%
            } else {
                String error = (String) request.getAttribute("ERROR");
                if (error != null && !error.isEmpty()) {
                    out.print(error);
                } else {
                    out.print("Không có thông tin phòng giữ chỗ");
                }
            }
        %>
        <h2>Các Đơn Đặt Phòng Đang Ở</h2>
        <%
            ArrayList<BookingDTO> listCheckInBooking = (ArrayList<BookingDTO>) request.getAttribute("CHECKIN_BOOKING");
            if (listCheckInBooking != null && !listCheckInBooking.isEmpty()) {
        %>
        <table>
            <tr>
                <th>Booking ID</th>
                <th>Guest ID</th>
                <th>Guest Name</th>
                <th>Room ID</th>
                <th>Room Number</th>
                <th>Room Type</th>
                <th>Check-in Date</th>
                <th>Check-out Date</th>
                <th>Booking Date</th>
                <th>Status</th>
                    <%
                        for (BookingDTO b : listCheckInBooking) {
                    %>
            <tr> 
                <td><%= b.getBookingID()%></td>
                <td><%= b.getGuestID()%></td>
                <td><%= b.getGuestName()%></td>
                <td><%= b.getRoomID()%></td>
                <td><%= b.getRoomNumber()%></td>
                <td><%= b.getRoomType()%></td>
                <td><%= b.getCheckInDate()%></td>
                <td><%= b.getCheckOutDate()%></td>
                <td><%= b.getBookingDate()%></td>
                <td><%= b.getStatus()%></td>
                <td>
                    <form action="MainController">
                        <input type="hidden" name="bookingId" value="<%= b.getBookingID() %>">
                        <button type="submit" name="action" value="<%= IConstants.AC_CHOOSE_SERVICE_PAGE %>">Đặt dịch vụ</button>
                        <button type="submit" name="action" value="<%= IConstants.AC_CHECKOUT_BOOKING_ROOM %>">CheckOut Phòng</button>
                    </form>
                </td>
            </tr> 
            <%
                }
            %>
        </table>
        <%
                } else {
                    String error = (String) request.getAttribute("ERROR");
                    if (error != null && !error.isEmpty()) {
                        out.print(error);
                    } else {
                        out.print("Không có thông tin phòng đã checkin");
                    }
                }
            }
        %>
    </body>
</html>
