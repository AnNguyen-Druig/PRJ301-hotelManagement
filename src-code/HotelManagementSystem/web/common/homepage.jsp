<%-- 
    Document   : home_page
    Created on : Oct 1, 2025, 7:06:34 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
    </head>
    <body>
        <a href="<%=request.getContextPath()%>/MainController?action=default"">
            <img src="<%=request.getContextPath()%>/img/logo.jpg" alt="Logo"/>
        </a>
        <a href="MainController?action=booking">Booking</a>
        <a href="MainController?action=Login Staff">Đăng Nhập/Đăng Ký</a>
    </body>
</html>
