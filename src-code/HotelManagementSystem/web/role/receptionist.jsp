<%-- 
    Document   : receptionist
    Created on : Oct 2, 2025, 3:19:09 PM
    Author     : Admin
--%>

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
            if(errorMsg == null) {
                errorMsg = "";
            }
        %>
        
        <h1>Welcome <%=staff.getFullName() %> Receptionist!</h1>
        <h4><a href="MainController?action=logout">Logout</a><h4>
        <a href="MainController?action=booking">Tạo Booking</a>
        <form action="MainController">
            <input type="text" name="guest_idnumber" placeholder="Nhập số CCCD">
            <input type="submit" name="action" value="Make new Booking">
            <span><%=errorMsg%></span>
        </form>
        <a href="MainController?action=Signup">Đăng ký thành viên cho người dùng</a>
        <h3>Booking List</h3>
                <table>
                    <tr>
                        <th>Booking ID</th>
                        <th>Guest ID</th>
                        <th>Room ID</th>
                        <th>Check-in Date</th>
                        <th>Check-out Date</th>
                        <th>Booking Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                </table>
    </body>
</html>
