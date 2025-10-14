<%-- 
    Document   : service
    Created on : Oct 2, 2025, 3:19:33 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service DashBoard</title>
    </head>
    <body>
        <jsp:useBean id="USER" scope="session" class="DTO.StaffDTO"/>    
        <h1>Welcome back, ${USER.fullName}</h1>
        <h4><a href="MainController?action=logout">Logout</a><h4>
    </body>
</html>
