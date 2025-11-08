<%-- 
    Document   : bookinginformationpage
    Created on : Oct 12, 2025, 10:14:28 PM
    Author     : ASUS
--%>

<%@page import="DTO.Guest_DTO.ShowRoomDTO"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="DTO.Basic_DTO.GuestDTO"%>
<%@page import="java.sql.Date"%>
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
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <%
            ShowRoomDTO room = (ShowRoomDTO) request.getAttribute("ROOM");
            GuestDTO guest = (GuestDTO) session.getAttribute("USER");
            Date checkInDate = (Date) request.getAttribute("CHECKINDATE");
            Date checkOutDate = (Date) request.getAttribute("CHECKOUTDATE");
            if (room != null && guest != null && checkInDate != null && checkOutDate != null) {
        %>
        <h2>KIỂM TRA THÔNG TIN ĐẶT PHÒNG</h2>
        <form action="MainController" method="POST">
            <div>
                <lable for="fullname">HO VA TEN: </lable>
                <input type="text" name="guest_fullname" id="fullname" readonly="" value="<%= guest.getFullName()%>">
            </div>
            </br>

            <div>
                <lable for="phone">SO DIEN THOAI: </lable>
                <input type="number" name="guest_phone" id="phone" readonly="" value="<%= guest.getPhone()%>">
            </div>
            </br>

            <div>
                <lable for="email">EMAIL: </lable>
                <input type="email" name="guest_email" id="email" readonly="" value="<%= guest.getEmail()%>">
            </div>
            </br>

            <div>
                <lable for="IDNumber">SO CAN CUOC CONG DAN: </lable>
                <input type="number" name="guest_IDNumber" id="IDNumber" readonly="" value="<%= guest.getIDNumber()%>">
            </div>
            </br>

            <div>
                <lable for="roomNumber">SO PHONG: </lable>
                <input type="text" name="room_roomNumber" id="roomNumber" readonly="" value="<%= room.getRoomNumber()%>">
            </div> 
            </br>

            <div>
                <lable for="typeName">LOAI PHONG: </lable>
                <input type="text" name="room_typeName" id="typeName" readonly="" value="<%= room.getTypeName()%>">
            </div> 
            </br>

            <div>
                <lable for="capacity">SUC CHUA: </lable>
                <input type="number" name="room_capacity" id="capacity" readonly="" value="<%= room.getCapacity()%>">
            </div> 
            </br>

            <div>
                <lable for="pricePerNight">GIA PHONG/MOT DEM: </lable>
                <input type="text" name="room_pricePerNight" id="pricePerNight" readonly="" value="<%= String.format("%,.0f VND", room.getPricePerNight()).replace(',', '.')%>">
            </div>
            </br>

            <div>
                <label for="checkInDate">NGAY CHECK-IN:</label>
                <input type="date" id="checkInDate" name="booking_room_checkInDate" readonly="" value="<%= checkInDate%>">
            </div>
            </br>

            <div>
                <label for="checkOutDate">NGAY CHECK-OUT:</label>
                <input type="date" id="checkOutDate" name="booking_room_checkOutDate"  readonly="" value="<%= checkOutDate%>">
            </div>
            </br>

            <div>
                <label for="bookingDate">NGAY DAT PHONG:</label>
                <input type="date" id="bookingDate" name="booking_room_bookingDate" 
                       value="<%= LocalDate.now(ZoneId.of("Asia/Ho_Chi_Minh")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%>" 
                       readonly>
            </div>
            </br> 
            <input type="hidden" name="roomID" value="<%= room.getRoomID()%>">
            <input type="hidden" name="guestID" value="<%= guest.getGuestID()%>">
            <!--   gửi theo booking_room_checkInDate và booking_room_checkOutDate vẫn còn trong request đến SaveBookingRoom để BookingRoomController nhận ròi gửi lại trang này -->
            <input type="hidden" name="booking_room_checkInDate" value="<%= request.getParameter("booking_room_checkInDate")%>">
            <input type="hidden" name="booking_room_checkOutDate" value="<%= request.getParameter("booking_room_checkOutDate")%>">
            <%
                String msg = (String) request.getAttribute("MSG");
                if (msg != null && !msg.isEmpty()) {
                    out.print(msg);
                } else {
            %>
            <button type="submit" name="action" value="<%= IConstants.AC_SAVE_BOOKING_ROOM%>">Booking</button>
            <%
                }
            %>          
        </form>
        <%
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (staff != null) {
        %>
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="<%= IConstants.AC_TURNBACK_RECEPTION%>">Quay về trang Receptionist</button>
        </form>
        <%
        } else {
        %>
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="<%= IConstants.AC_GO_BACK_GUEST_PAGE%>">Quay về trang Guest</button>
        </form>
        <%
                }
            } else {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            }
        %>
    </body>
</html>
