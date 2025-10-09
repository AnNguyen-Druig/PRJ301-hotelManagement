<%-- 
    Document   : signup
    Created on : Oct 9, 2025, 3:17:01 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Đăng Ký Thành Viên</title>
    </head>
    <body>
        <h1>Đăng Ký Thành Viên</h1>
        <form action="MainController" method="post">
            <p>Username: <input type="text" name="guest_username"></p>
            <p>Password: <input type="password" name="guest_password"></p>
            <p>Fullname: <input type="text" name="guest_fullname"></p>
            <p>Phone: <input type="tel" name="guest_phone"></p>
            <p>Email: <input type="email" name="guest_email"></p>
            <p>Address: <input type="text" name="guest_address"></p>
            <p>Date Of Birth: <input type="date" name="guest_dateofbirth"></p>
            <p>ID Number: <input type="number" name="guest_idnumber" min="10" max="12"></p>
        </form>
    </body>
</html>
