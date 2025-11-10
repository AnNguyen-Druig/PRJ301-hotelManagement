<%-- 
    Document   : guest
    Created on : Oct 9, 2025, 2:56:32 PM
    Author     : Admin
--%>

<%@page import="DTO.Guest_DTO.BookingRoomDetailDTO"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Basic_DTO.GuestDTO"%>
<%@page import="mylib.IConstants"%>
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
           GUEST PAGE STYLES (phụ)
           ============================== */

        main {
            padding: 40px;
            max-width: 1200px;
            margin: 0 auto;
            background-color: #ffffff;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
            border-radius: 10px;
        }

        h1, h2 {
            color: #004a99;
            text-align: center;
            margin-top: 0;
        }

        /* Nút hành động */
        button {
            background-color: #004a99;
            color: #fff;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.25s ease;
            font-size: 14px;
        }

        button:hover {
            background-color: #0066cc;
        }

        /* Bảng hiển thị dữ liệu */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 14px;
            background-color: #fff;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px 10px;
            text-align: center;
        }

        th {
            background-color: #004a99;
            color: #fff;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f2f6fa;
        }

        tr:hover {
            background-color: #e8f1ff;
        }

        /* Thông báo / message */
        .message {
            text-align: center;
            color: #004a99;
            font-weight: 600;
            margin: 20px 0;
        }

        .error {
            text-align: center;
            color: #cc0000;
            font-weight: 600;
            margin: 20px 0;
        }
    </style>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <%
            GuestDTO guest = (GuestDTO) session.getAttribute("USER");
            if (guest == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
        %>
        <h1>Welcome <%= guest.getFullName()%> Guest!</h1>
        <form action="MainController" method="POST">
            <div style="text-align:center; margin-bottom:30px;">
                <button type="submit" name="action" value="<%= IConstants.AC_BOOKING%>">Đặt phòng ngay</button>
            </div>   
        </form>
        <h2>Các Đơn Đặt Phòng Đã Giữ Chỗ</h2>
        <%  //Nhận thông tin HUY DAT PHONG
            String message = (String) request.getAttribute("MESSAGE");
            if (message != null && !message.isEmpty()) {
                out.println(message);
        %></br><%
            }
            //Kết thúc thông tin Huy Dat Phong

            ArrayList<BookingRoomDetailDTO> listReservedBooking = (ArrayList<BookingRoomDetailDTO>) request.getAttribute("RESERVED_BOOKING");
            if (listReservedBooking != null && !listReservedBooking.isEmpty()) {
        %>
        <table>
            <tr>
                <th>Số phòng</th>
                <th>Họ và tên khách hàng</th>
                <th>Loại phòng</th>
                <th>Ngày check-in</th>
                <th>Ngày check-out</th>
                <th>Ngày đặt phòng</th>
                <th>Giá tiền/một đêm</th>
                <th>Trạng thái Booking</th>
                <th>Hành động</th>
                    <%
                        for (BookingRoomDetailDTO b : listReservedBooking) {
                    %>
            <tr> 
                <td><%= b.getRoomNumber()%></td>
                <td><%= b.getGuestName()%></td>
                <td><%= b.getRoomType()%></td>
                <td><%= b.getCheckInDate()%></td>
                <td><%= b.getCheckOutDate()%></td>
                <td><%= b.getBookingDate()%></td>
                <td><%= String.format("%,.0f VND",b.getPricePerNight()).replace(',', '.') %></td>
                <td><%= b.getStatus()%></td>
                <td>
                    <form action="MainController" method="POST">
                        <input type="hidden" name="bookingID" value="<%= b.getBookingID()%>">
                        <input type="hidden" name="checkInDate" value="<%= b.getCheckInDate() %>">
                        <button type="submit" name="action" value="<%= IConstants.AC_CANCEL_BOOKING_ROOM%>">Huỷ đặt phòng</button> 
                    </form>
                </td>
            </tr> 
            <%
                }
            %>
        </table>
        <%
            } else {
                String error = (String) request.getAttribute("ERROR");
                if (error != null && !error.isEmpty()) {
                    out.println(error);
                } else {
                    out.print("Không có thông tin phòng giữ chỗ");
                }
            }
        %>
        <h2>Các Đơn Đặt Phòng Đang Ở</h2>
        <%
            ArrayList<BookingRoomDetailDTO> listCheckInBooking = (ArrayList<BookingRoomDetailDTO>) request.getAttribute("CHECKIN_BOOKING");
            if (listCheckInBooking != null && !listCheckInBooking.isEmpty()) {
        %>
        <table>
            <tr>
                <th>Số phòng</th>
                <th>Họ và tên khách hàng</th>
                <th>Loại phòng</th>
                <th>Ngày check-in</th>
                <th>Ngày check-out</th>
                <th>Ngày đặt phòng</th>
                <th>Giá tiền/một đêm</th>
                <th>Trạng thái Booking</th>
                <th>Hành động</th>
                    <%
                        for (BookingRoomDetailDTO b : listCheckInBooking) {
                    %>
            <tr> 
                <td><%= b.getRoomNumber()%></td>
                <td><%= b.getGuestName()%></td>
                <td><%= b.getRoomType()%></td>
                <td><%= b.getCheckInDate()%></td>
                <td><%= b.getCheckOutDate()%></td>
                <td><%= b.getBookingDate()%></td>
                <td><%= String.format("%,.0f VND",b.getPricePerNight()).replace(',', '.') %></td>
                <td><%= b.getStatus()%></td>
                <td>
                    <form action="MainController">
                        <input type="hidden" name="bookingId" value="<%= b.getBookingID()%>">
                        <button type="submit" name="action" value="<%= IConstants.AC_CHOOSE_SERVICE_PAGE%>">Đặt dịch vụ</button>
                        <button type="submit" name="action" value="<%= IConstants.AC_CHECKOUT_BOOKING_ROOM%>">CheckOut Phòng</button>
                    </form>
                </td>
            </tr> 
            <%
                }
            %>
        </table>
        <%
                    } else {
                        String error = (String) request.getAttribute("ERROR");
                        if (error != null && !error.isEmpty()) {
                            out.println(error);
                        } else {
                            out.print("Không có thông tin phòng đã checkin");
                        }
                    }
                }
        %>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
