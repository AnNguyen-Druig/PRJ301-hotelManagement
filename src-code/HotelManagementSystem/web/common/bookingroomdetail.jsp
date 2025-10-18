<%-- 
    File   : bookingdetail.jsp
--%>
<%@page import="DTO.BookingDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail</title>
    </head>
    <body>
        <%
            BookingDTO booking = (BookingDTO) request.getAttribute("BOOKING_DETAIL");
            if (booking != null) {
        %>
        <h1>Thông Tin Đặt Phòng - ID: <%= booking.getBookingID()%></h1>

        <form action="MainController" method="POST">
            <input type="hidden" name="bookingID" value="<%= booking.getBookingID()%>" />

            <p>Guest ID: <%= booking.getGuestID()%></p>
            <p>Guest Name: <%= booking.getGuestName()%></p>

            <a href="MainController?action=ShowAvailableRoomList">Xem danh sách phòng trống</a>
            <p>Room ID: <input type="number" min="0" name="roomid" value="<%= booking.getRoomID()%>"></p>
            <p>Room Number: <%= booking.getRoomNumber()%></p>
            <p>Room Type: <%= booking.getRoomType() %></p>


            <p>Check-in Date: <input type="date" name="checkInDate" value="<%= booking.getCheckInDate()%>"></p> 
            <p>Check-out Date: <input type="date" name="checkOutDate" value="<%= booking.getCheckOutDate()%>"></p> 
            <p>Booking Date: <%= booking.getBookingDate() %></p>
            
            <p>
                Status: 
                <select name="status">
                    <option value="Reserved" <%= "Reserved".equals(booking.getStatus()) ? "selected" : ""%>>Reserved</option>
                    <option value="CheckIn" <%= "CheckIn".equals(booking.getStatus()) ? "selected" : ""%>>CheckIn</option>
                    <option value="CheckOut" <%= "CheckOut".equals(booking.getStatus()) ? "selected" : ""%>>CheckOut</option>
                    <option value="Canceled" <%= "Canceled".equals(booking.getStatus()) ? "selected" : ""%>>Canceled</option>
                    <option value="Complete" <%= "Complete".equals(booking.getStatus()) ? "selected" : ""%>>Complete</option>
                </select>
            </p>


            <input type="submit" name="action" value="Save Changes" />
            <a href="MainController?action=TurnBackReceptionPage">Cancel</a>
        </form>
        <%
        } else {
        %>
        <h1>Booking not found!</h1>
        <%
            }
        %>
    </body>
</html>