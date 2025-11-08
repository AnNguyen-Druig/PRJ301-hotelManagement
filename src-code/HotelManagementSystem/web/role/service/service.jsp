<%-- 
    Document   : service
    Created on : Oct 2, 2025, 3:19:33 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service DashBoard</title>
        <style> table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            padding: 8px;
        } </style>
    </head>
    <body>
        <jsp:useBean id="STAFF" scope="session" class="DTO.Basic_DTO.StaffDTO"/>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <h1>Welcome back, ${STAFF.fullName}</h1>
        <h4><a href="MainController?action=logout">Logout</a></h4>
        <h4><a href="MainController?action=reportpage">Báo cáo các dịch vụ sử dụng chi tiết</a></h4>

        <table style="width:100%">
            <thead>
                <tr>
                    <th>BookingID</th>
                    <th>RoomID</th>
                    <th>GuestName</th>
                    <th>RoomStatus</th>
                    <th>CheckInDate</th>
                    <th>ChooseRoom</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<BookingDTO> list = (List<BookingDTO>) request.getAttribute("ALLROOM");
                    if (list != null && !list.isEmpty()) {
                        for (BookingDTO room : list) {
                %>
            <form action="MainController" method="POST">
                <tr>

                    <td><%= room.getBookingID()%></td>
                    <td><%= room.getRoomID()%></td>
                    <td><%= room.getGuestName()%></td>
                    <td><%= room.getStatus()%></td>
                    <td><%= room.getCheckInDate()%></td>
                    <td><input type="hidden" name="bookingId" value="<%=room.getBookingID()%>"/>
                        <button type="submit" name="action" value="ChooseService">Choose</button>
                        <button type="submit" name="action" value="ViewServiceCtrl">View</button></td>

                </tr>
            </form>
            <%
                    }
                } else {
                    out.print("<tr><td colspan='7' style='text-align:center;'>Không có thông tin phòng.</td></tr>");
                }
                String error = (String) request.getAttribute("ERROR");
                if (error != null) {
                    out.print("<tr><td colspan='7' style='color:red; text-align:center;'>" + error + "</td></tr>");
                }
            %>
        </tbody>
    </table>

</body>
</html>
