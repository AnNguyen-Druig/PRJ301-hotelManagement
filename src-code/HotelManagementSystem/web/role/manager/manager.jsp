<%-- 
    Document   : manager
    Created on : Oct 2, 2025, 3:19:16 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page import="DTO.StaffDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Page</title>
    </head>
    <body>
        <jsp:useBean id="USER" scope="session" class="DTO.StaffDTO" />
        <h1>Welcome back, Manager ${USER.fullName}</h1>
        
        <h2>Choose your action:</h2>
        <p><a href="MainController?action=reportpage">View Report Statistic</a></p>
    </body>
</html>
