<%-- 
    Document   : booking
    Created on : Oct 7, 2025, 1:28:11 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Page</title>
    </head>
    <body>
        <h1>Booking Page</h1>
        <form action="MainController" method="post">
            <p>GuestID</p>
            <p>Room Type
                <select name="roomtype">
                    <option></option>
                </select>
            </p>
            <p>RoomID</p>
            <p>Check-in Date<input type="date" name="checkindate"></p>
            <p>Check-out Date<input type="date" name="checkoutdate"></p>
        </form>
    </body>
</html>
