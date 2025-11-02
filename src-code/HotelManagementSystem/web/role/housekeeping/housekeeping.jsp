<%-- 
    Document   : housekeeping
    Created on : Oct 2, 2025, 3:19:26 PM
    Author     : Admin
--%>

<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Housekeeping Dashboard</title>
        <style>
            body { font-family: sans-serif; }
            table, th, td { 
                border: 1px solid #ccc; 
                border-collapse: collapse; 
                padding: 10px; 
                text-align: left;
            }
            th { background-color: #f2f2f2; }
            .container { padding: 20px; }
            select, button { padding: 8px; margin-left: 5px; }
            h1, h4 { margin-bottom: 20px; }
            .service-form select { width: 150px; }
        </style>
    </head>
    <body>
        <div class="container">
            <% 
                StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
                if (staff != null) {
            %>
            <h1>Welcome back, <%= staff.getFullName() %>!</h1>
            <h4><a href="MainController?action=logout">Logout</a></h4>

            <h2>Quản Lý Phòng</h2>

            <%-- Hiển thị thông báo lỗi nếu có --%>
            <%
                String error = (String) request.getAttribute("ERROR");
                if (error != null) {
            %>
                <p style="color: red;"><%= error %></p>
            <%
                }
            %>

            <table style="width:100%">
                <thead>
                    <tr>
                        <th>Số Phòng</th>
                        <th>Loại Phòng</th>
                        <th>Trạng Thái</th>
                        <th>Cập Nhật Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<RoomDTO> list = (List<RoomDTO>) request.getAttribute("ROOM_LIST");
                        if (list != null && !list.isEmpty()) {
                            for (RoomDTO room : list) {
                    %>
                    <tr>
                        <td><%= room.getRoomNumber() %></td>
                        <td><%= room.getTypeName() %></td>
                        <td><%= room.getRoomStatus() %></td>

                        <td>
                            <form action="MainController" method="POST" style="display: flex; align-items: center;">
                                <input type="hidden" name="roomId" value="<%= room.getRoomID() %>" />
                                <select name="newStatus">
                                    <option value="Available" <% if ("Available".equals(room.getRoomStatus())) out.print("selected"); %>>Available</option>
                                    <option value="Dirty" <% if ("Dirty".equals(room.getRoomStatus())) out.print("selected"); %>>Dirty</option>
                                    <option value="Maintenance" <% if ("Maintenance".equals(room.getRoomStatus())) out.print("selected"); %>>Maintenance</option>
                                    <option value="Occupied" <% if ("Occupied".equals(room.getRoomStatus())) out.print("selected"); %>>Occupied</option>
                                </select>
                                <%-- Quan trọng: action của button trỏ đến action mới đã tạo --%>
                                <button type="submit" name="action" value="perform_room_update">Update</button>
                            </form>
                        </td>
                        
                        
                    <%
                            } // end for
                        } else {
                            out.print("<tr><td colspan='5' style='text-align:center;'>Không có thông tin phòng.</td></tr>");
                        }
                    %>
                    <div style="text-align: center; margin-top: 30px;">
                            <button class="back-btn" onclick="window.location.href='MainController?action=pendingpage'">Go to cleaning page</button>
                        </div>
                    <div style="text-align: center; margin-top: 30px;">
                            <button class="back-btn" onclick="window.location.href='MainController?action=housereport'">Go to report page</button>
                        </div>    
                </tbody>
            </table>

            <% } else {
                // Nếu chưa đăng nhập, chuyển về trang login
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } %>
        </div>
    </body>
</html>
