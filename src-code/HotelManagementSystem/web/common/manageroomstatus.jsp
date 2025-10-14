<%-- 
    Document   : managerooms
    Created on : Oct 12, 2025, 11:37:57 PM
    Author     : Nguyễn Đại
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DTO.RoomDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="DTO.RoomDTO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Room Status</title>
        <style> table, th, td { border: 1px solid black; border-collapse: collapse; padding: 8px; } </style>
    </head>
    <body>
        <h1>Quản Lý Trạng Thái Phòng</h1>
        
        <table style="width:100%">
            <thead>
                <tr>
                    <th>RoomID</th>
                    <th>RoomType</th>
                    <th>RoomStatus</th>
                    <th>UpdateStatus</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<RoomDTO> list = (List<RoomDTO>) request.getAttribute("ROOM_LIST");
                    if (list != null && !list.isEmpty()) {
                        for (RoomDTO room : list) {
                %>
                <tr>
                    <form action="MainController" method="POST">
                        <td><%= room.getRoomNumber() %></td>
                        <td><%= room.getTypeName() %></td>
                        <td><%= room.getRoomStatus() %></td>
                        <td>
                            <input type="hidden" name="roomId" value="<%= room.getRoomID() %>" />
                            <select name="newStatus">
                                <option value="Available" <% if ("Available".equals(String.valueOf(room.getRoomStatus()))) { out.print("selected"); } %>>Available</option>
                                <option value="Dirty" <% if ("Dirty".equals(String.valueOf(room.getRoomStatus()))) { out.print("selected"); } %>>Dirty</option>
                                <option value="Maintenance" <% if ("Maintenance".equals(String.valueOf(room.getRoomStatus()))) { out.print("selected"); } %>>Maintenance</option>
                                <option value="Occupied" <% if ("Occupied".equals(String.valueOf(room.getRoomStatus()))) { out.print("selected"); } %>>Occupied</option>
                            </select>
                            <button type="submit" name="action" value="perform_room_update">Update</button>
                        </td>
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
        </table>
        <p><a href="MainController?action=goback">Quay về Dashboard</a></p>
    </body>
</html>
