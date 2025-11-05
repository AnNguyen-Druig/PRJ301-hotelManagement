<%-- 
    Document   : guest
    Created on : Oct 9, 2025, 2:56:32 PM
    Author     : Admin
--%>

<%@page import="DTO.Guest_DTO.BookingRoomDetailDTO"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Basic_DTO.GuestDTO"%>
<%@page import="mylib.IConstants"%>
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
        <h1>Welcome <%= guest.getFullName()%> Guest!</h1>
        <a href="MainController?action=logout">Logout</a>
        <form>
            <button type="submit" name="action" value="<%= IConstants.AC_BOOKING%>">Đặt phòng ngay</button>
        </form>
        <h2>Các Đơn Đặt Phòng Đã Giữ Chỗ</h2>
        <%  //Nhận thông tin HUY DAT PHONG
            String message = (String) request.getAttribute("MESSAGE");
            String bookingId = request.getParameter("bookingId");
            if (message != null && !message.isEmpty()) {
                out.println(message);
            }
            //Kết thúc thông tin Huy Dat Phong

            ArrayList<BookingRoomDetailDTO> listReservedBooking = (ArrayList<BookingRoomDetailDTO>) request.getAttribute("RESERVED_BOOKING");
            if (listReservedBooking != null && !listReservedBooking.isEmpty()) {
        %>
        <table>
            <tr>
                <th>Room Number</th>
                <th>Guest Name</th>
                <th>Room Type</th>
                <th>Check-in Date</th>
                <th>Check-out Date</th>
                <th>Booking Date</th>
                <th>PricePerNight</th>
                <th>Status</th>
                    <%
                        for (BookingRoomDetailDTO b : listReservedBooking) {
                    %>
            <tr> 
                <td><%= b.getRoomNumber()%></td>
                <td><%= b.getGuestName()%></td>
                <td><%= b.getRoomType()%></td>
                <td><%= b.getCheckInDate()%></td>
                <td><%= b.getCheckOutDate()%></td>
                <td><%= b.getBookingDate()%></td>
                <td><%= b.getPricePerNight() %></td>
                <td><%= b.getStatus()%></td>
                <td>
                    <form action="MainController" method="POST">
                        <input type="hidden" name="bookingID" value="<%= b.getBookingID()%>">
                        <input type="hidden" name="checkInDate" value="<%= b.getCheckInDate() %>">
                        <button type="submit" name="action" value="<%= IConstants.AC_CANCEL_BOOKING_ROOM%>">Huỷ đặt phòng</button> 
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
                    out.print("Không có thông tin phòng giữ chỗ");
                }
            }
        %>
        <h2>Các Đơn Đặt Phòng Đang Ở</h2>
        <%
            ArrayList<BookingRoomDetailDTO> listCheckInBooking = (ArrayList<BookingRoomDetailDTO>) request.getAttribute("CHECKIN_BOOKING");
            if (listCheckInBooking != null && !listCheckInBooking.isEmpty()) {
        %>
        <table>
            <tr>
                 <th>Room Number</th>
                <th>Guest Name</th>
                <th>Room Type</th>
                <th>Check-in Date</th>
                <th>Check-out Date</th>
                <th>Booking Date</th>
                <th>PricePerNight</th>
                <th>Status</th>
                    <%
                        for (BookingRoomDetailDTO b : listCheckInBooking) {
                    %>
            <tr> 
                <td><%= b.getRoomNumber()%></td>
                <td><%= b.getGuestName()%></td>
                <td><%= b.getRoomType()%></td>
                <td><%= b.getCheckInDate()%></td>
                <td><%= b.getCheckOutDate()%></td>
                <td><%= b.getBookingDate()%></td>
                <td><%= b.getPricePerNight() %></td>
                <td><%= b.getStatus()%></td>
                <td>
                    <form action="MainController">
                        <input type="hidden" name="bookingId" value="<%= b.getBookingID()%>">
                        <button type="submit" name="action" value="<%= IConstants.AC_CHOOSE_SERVICE_PAGE%>">Đặt dịch vụ</button>
                        <button type="submit" name="action" value="<%= IConstants.AC_CHECKOUT_BOOKING_ROOM%>">CheckOut Phòng</button>
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
