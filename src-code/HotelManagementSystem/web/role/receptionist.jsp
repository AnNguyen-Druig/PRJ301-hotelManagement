<%-- 
    Document   : receptionist
    Created on : Oct 2, 2025, 3:19:09 PM
    Author     : Admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DTO.StaffDTO"%>
<%@page import="DTO.BookingDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            StaffDTO staff = (StaffDTO) session.getAttribute("USER");
            String errorMsg = (String) request.getAttribute("ERROR");
            if (errorMsg == null) {
                errorMsg = "";
            }
        %>

        <h1>Welcome <%=staff.getFullName()%> Receptionist!</h1>
        <p><a href="MainController?action=logout">Logout</a></p>
        <h3>Tạo Booking</h3>
        <form action="MainController">
            <input type="text" name="guest_idnumber" placeholder="Nhập số CCCD">
            <input type="submit" name="action" value="Make new Booking">
            <span><%=errorMsg%></span>
        </form>
        <h3><a href="MainController?action=Signup">Đăng ký thành viên cho người dùng</a></h3>
        <%
            ArrayList<BookingDTO> bookingList = (ArrayList) request.getAttribute("ALLBOOKING");
            if (bookingList != null && !bookingList.isEmpty()) {
        %>
        <h3>Booking List</h3>
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
                <th>Action</th>
            </tr>

            <%
                for (BookingDTO b : bookingList) {
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
                <td><a href="MainController?action=UpdateBooking&bookingID=<%=b.getBookingID()%>">Update</a> <a href="MainController?action=CancelBooking&bookingID=<%=b.getBookingID()%>">Cancel</a></td>
            </tr> 
            <%
                }
            %>
        </table>
        <%
            } else {
        %>
                <p><%= errorMsg %></p>
        <%
        }
        %>
    </body>
</html>
