<%-- 
    Document   : bookinginformationpage
    Created on : Oct 12, 2025, 10:14:28 PM
    Author     : ASUS
--%>

<%@page import="java.sql.Date"%>
<%@page import="DTO.GuestDTO"%>
<%@page import="DTO.RoomDTO"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDateTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
            RoomDTO room = (RoomDTO) request.getAttribute("ROOM");
            GuestDTO guest = (GuestDTO) request.getAttribute("GUEST");
            Date checkInDate = (Date) request.getAttribute("CHECKINDATE");
            Date checkOutDate = (Date) request.getAttribute("CHECKOUTDATE");
            if(room!=null && guest!=null && checkInDate!=null && checkOutDate != null) {       
        %>
        <h2>KIỂM TRA THÔNG TIN ĐẶT PHÒNG</h2>
        <form action="MainController" method="POST">
            <div>
                <lable for="fullname">HO VA TEN: </lable>
                <input type="text" name="guest_fullname" id="fullname" value="<%= guest.getFullName() %>">
            </div>
            </br>
            
            <div>
                <lable for="phone">SO DIEN THOAI: </lable>
                <input type="number" name="guest_phone" id="phone" value="<%= guest.getPhone() %>">
            </div>
            </br>
 
            <div>
                <lable for="email">EMAIL: </lable>
                <input type="email" name="guest_email" id="email" value="<%= guest.getEmail() %>">
            </div>
            </br>
 
            <div>
                <lable for="IDNumber">SO CAN CUOC CONG DAN: </lable>
                <input type="number" name="guest_IDNumber" id="IDNumber" value="<%= guest.getIDNumber() %>">
            </div>
            </br>
 
            <div>
                <lable for="typeName">LOAI PHONG: </lable>
                <input type="text" name="room_typeName" id="typeName" value="<%= room.getTypeName() %>">
            </div> 
            </br>
 
            <div>
                <lable for="capacity">SUC CHUA: </lable>
                <input type="number" name="room_capacity" id="capacity" value="<%= room.getCapacity() %>">
            </div> 
            </br>
 
            <div>
                <lable for="pricePerNight">GIA PHONG/MOT DEM: </lable>
                <input type="number" name="room_pricePerNight" id="pricePerNight" value="<%= room.getPricePerNight() %>">
            </div>
            </br>
            
<!--            tao ham de check checkInDate va checkOutDate de xac dinh status cua BOOKING_ROOM-->
            <% String bookingStatus = "Reserved"; %>
            
            <div>
                <label for="checkInDate">NGAY CHECK-IN:</label>
                <input type="date" id="checkInDate" name="booking_room_checkInDate" value="<%= checkInDate %>">
            </div>
            </br>
 
            <div>
                <label for="checkOutDate">NGAY CHECK-OUT:</label>
                <input type="date" id="checkOutDate" name="booking_room_checkOutDate"  value="<%= checkOutDate %>">
            </div>
            </br>
 
            <div>
                <label for="bookingDate">NGAY DAT PHONG:</label>
                <input type="date" id="bookingDate" name="booking_room_bookingDate" 
                   value="<%= LocalDate.now(ZoneId.of("Asia/Ho_Chi_Minh")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %>" 
                   readonly>
            </div>
            </br> 
            <input type="hidden" name="roomID" value="<%= room.getRoomID() %>">
            <input type="hidden" name="guestID" value="<%= guest.getGuestID() %>">
            <input type="hidden" name="bookingStatus" value="<%= bookingStatus %>">
            <button type="submit" name="action" value="savebookingroom">Booking</button>
        </form>
         <% } %>
    </body>
</html>
