<%-- 
    Document   : bookingroompage
    Created on : Oct 12, 2025, 2:48:06 PM
    Author     : ASUS
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.RoomDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="DTO.GuestDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            GuestDTO guest = (GuestDTO) session.getAttribute("USER");
            if (guest == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
                String typeName = "";
                Date checkInDate = null;
                Date checkOutDate = null;
                if (request.getParameter("roomtype") != null && request.getParameter("booking_room_checkInDate")!=null && request.getParameter("booking_room_checkOutDate")!=null) {
                    typeName = request.getParameter("roomtype");
                    checkInDate =  Date.valueOf(request.getParameter("booking_room_checkInDate"));
                    checkOutDate = Date.valueOf(request.getParameter("booking_room_checkOutDate"));
                }
        %>
        
        <form action="MainController" method="POST">
            <label for="roomtype">Loai Phong</label>
            <select id="roomtype" name="roomtype" required="">
                <option value="<%= typeName %>">---Chọn---</option>
                <option value="AllRoom">AllRoom</option>
                <option value="Single">Single</option>
                <option value="Double">Double</option> 
                <option value="Suite">Suite</option>
                <option value="Deluxe">Deluxe</option>
                <option value="Family">Family</option>
                <option value="Executive">Executive</option>
            </select>
            </br> 
            <label for="checkInDate">NGAY CHECK-IN:</label>
            <span>
                <!-- kiểm tra xem checkInDate co after today không-->
                <% String errorCheckInDate = (String) request.getAttribute("ERRORCHECKINDATE");
                    if (errorCheckInDate != null && !errorCheckInDate.trim().isEmpty()) {
                        out.print(errorCheckInDate +": "+ LocalDate.now(ZoneId.of("Asia/Ho_Chi_Minh")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
                    } %>
            </span></br>
            <input type="date" id="checkInDate" name="booking_room_checkInDate" required="" value="<%= checkInDate %>"></br>  
                
            <label for="checkOutDate">NGAY CHECK-OUT:</label>
            <span> 
                <!-- kiểm tra ngày checkOut phải sau ngày chekIn -->
                 <% String errorCheckOutDate = (String) request.getAttribute("ERRORCHECKOUTDATE");
                    if (errorCheckOutDate != null && !errorCheckOutDate.trim().isEmpty()) {
                        out.print(errorCheckOutDate +": "+ (checkInDate));
                    } %>
            </span> </br> 
            <input type="date" id="checkOutDate" name="booking_room_checkOutDate" required=""  value="<%= checkOutDate %>"></br>
            
            <input type="submit" value="filterroom" name="action">
        </form>
            
            
            
            
<!--         TH1: khi vừa bấm booking ở trang guest.jsp thì sẽ show ra hết các phòng status = "Available" (ko cần roomType, CheckInDate, CheckOutDate);
             TH2: show ra tất cả các phòng thoả status = "Available" và roomType và checkInDate checkOutDtae-->
<!--         TH3: show ra tất cả các phòng thoả từ ngày checkin đến checkout-->

        <%
            //Hiển thị thông tin tìm kiếm
            if(typeName!="" && checkInDate!=null && checkOutDate!=null){
                %>
                <h3>Bạn vừa tìm kiếm: </h3>
                <h4>Loại phòng: <%= typeName %></h4>
                <h4>Ngày CheckIn: <%= checkInDate %></h4>
                <h4>Ngày CheckOut: <%= checkOutDate %></h4>  
                <%
            }
            //Hiển thị danh sách phòng
            ArrayList<RoomDTO> roomList = (ArrayList<RoomDTO>) request.getAttribute("ALLROOM");
            if (roomList != null && !roomList.isEmpty()) {
                for (RoomDTO r : roomList) {
        %>
        <p>RoomID: <%= r.getRoomID()%></p>
        <p>TypeName: <%= r.getTypeName()%></p>
        <p>Capacity: <%= r.getCapacity()%></p>
        <p>PricePerNight: <%= r.getPricePerNight()%></p>
        <form action="MainController" method="POST">
            <input type="hidden" name="roomID" value="<%= r.getRoomID()%>">
            <input type="hidden" name="guestID" value="<%= guest.getGuestID()%>">
        <!-- Nếu bấm gửi qua mà checkInDate và checkOutDate đều = null thì sẽ gửi error về thông báo cần phải chọn checkIn và checkOut-->
            <input type="hidden" name="booking_room_checkInDate" value=" <%= checkInDate %>">
            <input type="hidden" name="booking_room_checkOutDate" value=" <%= checkOutDate %>">
            <button type="submit" value="bookingroom" name="action">Dat Phong</button>
        </form>

        <%
                    }
                } else {
                    String error = (String) request.getAttribute("ERROR");
                    if (error != null && !error.trim().isEmpty()) {
                        out.print(error);
                    }
                }
            }
        %>
    </body>
</html>
