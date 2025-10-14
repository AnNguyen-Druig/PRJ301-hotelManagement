<%-- 
    Document   : housekeeping
    Created on : Oct 2, 2025, 3:19:26 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page import="DTO.StaffDTO"%>
<%@page import="DTO.RoomDTO"%>
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
            <% StaffDTO staff = (StaffDTO) session.getAttribute("USER"); 
        if (staff != null) {     
        %>
        <h1>Welcome back <%= staff.getFullName() %></h1>
        <%}else{
            request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
        }%>
        <h4><a href="MainController?action=logout">Logout</a><h4>
        <h4>Chúc một ngày tốt lành</h4>
        <ul>
            <li><a href=""></a>Record service usage</li>
            <li><a href=""></a>Update service completion status</li>
            <li><a href="MainController?action=update_status">Update room status</a></li>
        </ul>
    </body>
</html>
