<%-- 
    Document   : admin
    Created on : Oct 2, 2025, 3:18:57 PM
    Author     : Admin
--%>

<%@page import="DTO.StaffDTO"%>
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
        %>
        
        <h1>Welcome <%= staff.getFullName() %> Staff!</h1>
        <h4><a href="MainController?action=logout">Logout</a><h4>
    </body>
</html>
