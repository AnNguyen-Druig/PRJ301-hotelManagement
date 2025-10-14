<%-- 
    Document   : service
    Created on : Oct 2, 2025, 3:19:33 PM
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="DTO.RoomDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service DashBoard</title>
        <style> table, th, td { border: 1px solid black; border-collapse: collapse; padding: 8px; } </style>
    </head>
    <body>
        <jsp:useBean id="USER" scope="session" class="DTO.StaffDTO"/>    
        <h1>Welcome back, ${USER.fullName}</h1>
        <h4><a href="MainController?action=logout">Logout</a><h4>
        
        <table style="width:100%">
            <thead>
                <tr>
                    <th>RoomID</th>
                    <th>RoomType</th>
                    <th>RoomStatus</th>
                    <th>ChooseRoom</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<RoomDTO> list = (List<RoomDTO>) request.getAttribute("ALLROOM");
                    if (list != null && !list.isEmpty()) {
                        for (RoomDTO room : list) {
                %>
                <tr>
                    <form action="MainController" method="POST">
                        <td><%= room.getRoomNumber() %></td>
                        <td><%= room.getTypeName() %></td>
                        <td><%= room.getRoomStatus() %></td>
                        <td><button type="submit" name="action" value="ChooseService">Choose</button></td>
                    </form>
                </tr>
                <%
                        }
                    } else {
                        out.print("<tr><td colspan='4' style='text-align:center;'>Không có thông tin phòng.</td></tr>");
                    }
                    String error = (String) request.getAttribute("ERROR");
                    if (error != null) {
                         out.print("<tr><td colspan='4' style='color:red; text-align:center;'>" + error + "</td></tr>");
                    }
                %>
            </tbody>
    </body>
</html>
