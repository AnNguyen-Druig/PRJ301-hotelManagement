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
         <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styles.css">
    </head>
     <style>
        /* ==============================
           BOOKING INFORMATION PAGE STYLES
           ============================== */
        main {
            max-width: 800px;
            margin: 40px auto;
            background-color: #ffffff;
            padding: 40px 50px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        h2 {
            text-align: center;
            color: #004a99;
            margin-bottom: 30px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-weight: bold;
            color: #004a99;
            display: inline-block;
            width: 250px;
        }

        input[type="text"], input[type="email"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            width: calc(100% - 260px);
            font-size: 14px;
            background-color: #f9f9f9;
        }

        form div {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        button {
            background-color: #004a99;
            color: #fff;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            cursor: pointer;
            align-self: center;
            margin-top: 20px;
            transition: background-color 0.25s ease;
        }

        button:hover {
            background-color: #0066cc;
        }

        .message {
            text-align: center;
            color: red;
            font-weight: bold;
            margin-top: 15px;
        }

        @media (max-width: 768px) {
            main {
                padding: 25px;
            }

            form div {
                flex-direction: column;
                align-items: flex-start;
            }

            label {
                width: 100%;
                margin-bottom: 5px;
            }

            input[type="text"], input[type="email"] {
                width: 100%;
            }
        }
    </style>
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
                <label for="fullname">HO VA TEN: </label>
                <input type="text" name="guest_fullname" id="fullname" readonly="" value="<%= guest.getFullName()%>">
            </div>
            </br>

            <div>
                <label for="phone">SO DIEN THOAI: </label>
                <input type="text" name="guest_phone" id="phone" readonly="" value="<%= guest.getPhone()%>">
            </div>
            </br>

            <div>
                <label for="email">EMAIL:</label>
                <input type="email" name="guest_email" id="email" readonly="" value="<%= guest.getEmail()%>">
            </div>
            </br>

            <div>
                <label for="IDNumber">SO CAN CUOC CONG DAN: </label>
                <input type="text" name="guest_IDNumber" id="IDNumber" readonly="" value="<%= guest.getIDNumber()%>">
            </div>
            </br>

            <div>
                <label for="roomNumber">SO PHONG: </label>
                <input type="text" name="room_roomNumber" id="roomNumber" readonly="" value="<%= room.getRoomNumber()%>">
            </div> 
            </br>

            <div>
                <label for="typeName">LOAI PHONG: </label>
                <input type="text" name="room_typeName" id="typeName" readonly="" value="<%= room.getTypeName()%>">
            </div> 
            </br>

            <div>
                <label for="capacity">SUC CHUA: </label>
                <input type="text" name="room_capacity" id="capacity" readonly="" value="<%= room.getCapacity()%>">
            </div> 
            </br>

            <div>
                <label for="pricePerNight">GIA PHONG/MOT DEM: </label>
                <input type="text" name="room_pricePerNight" id="pricePerNight" readonly="" value="<%= String.format("%,.0f VND", room.getPricePerNight()).replace(',', '.')%>">
            </div>
            </br>

            <div>
                <label for="checkInDate">NGAY CHECK-IN:</label>
                <input type="text" id="checkInDate" name="booking_room_checkInDate" readonly="" value="<%= checkInDate%>">
            </div>
            </br>

            <div>
                <label for="checkOutDate">NGAY CHECK-OUT:</label>
                <input type="text" id="checkOutDate" name="booking_room_checkOutDate"  readonly="" value="<%= checkOutDate%>">
            </div>
            </br>

            <div>
                <label for="bookingDate">NGAY DAT PHONG:</label>
                <input type="text" id="bookingDate" name="booking_room_bookingDate" 
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
            } else {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            }
        %>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
