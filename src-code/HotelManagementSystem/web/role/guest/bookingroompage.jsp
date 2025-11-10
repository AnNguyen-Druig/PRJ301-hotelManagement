<%-- 
    Document   : bookingroompage
    Created on : Oct 12, 2025, 2:48:06 PM
    Author     : ASUS
--%>

<%@page import="DTO.Guest_DTO.ShowRoomDTO"%>
<%@page import="DTO.Basic_DTO.GuestDTO"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
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
        .red {
            color: red
        }
        main {
            max-width: 1100px;
            margin: 40px auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.05);
            padding: 40px;
        }

        h1, h2, h3, h4 {
            color: #004a99;
            text-align: center;
        }

        form {
            text-align: center;
            margin: 20px auto;
        }

        label {
            font-weight: bold;
            color: #004a99;
        }

        select, input[type="date"] {
            padding: 8px 12px;
            margin: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
            width: 200px;
        }

        input[type="submit"], button {
            background-color: #004a99;
            color: #fff;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.25s ease;
            font-size: 14px;
            margin-top: 10px;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #0066cc;
        }

        .red {
            color: red;
            text-align: center;
            margin: 10px 0;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
            background-color: #fff;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px 10px;
            text-align: center;
            font-size: 14px;
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

        .search-info {
            text-align: center;
            margin: 20px 0;
            color: #004a99;
        }

        .room-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            margin: 15px 0;
            background-color: #f9fbff;
            box-shadow: 0 0 4px rgba(0,0,0,0.05);
        }

        .room-card p {
            margin: 5px 0;
        }

        .room-card form {
            text-align: right;
            margin-top: 10px;
        }
        
    </style>
</style>
<body>
    <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
    <%
        GuestDTO guest = (GuestDTO) session.getAttribute("USER");
        if (guest == null) {
            request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
        } else {

            String checkInStr = request.getParameter("booking_room_checkInDate");
            String checkOutStr = request.getParameter("booking_room_checkOutDate");

    %>        

    <form action="MainController" method="POST">    
        <label for="roomtype">Loai Phong</label>
        <select id="roomtype" name="roomtype" required="">
            <option value="">---Chọn---</option>
            <option value="AllRoom" ${param.roomtype == 'AllRoom' ? 'selected' : ''}>AllRoom</option>
            <option value="Single"  ${param.roomtype == 'Single' ? 'selected' : ''}>Single</option>
            <option value="Double"  ${param.roomtype == 'Double' ? 'selected' : ''}>Double</option> 
            <option value="Suite"  ${param.roomtype == 'Suite' ? 'selected' : ''}>Suite</option>
            <option value="Deluxe"  ${param.roomtype == 'Deluxe' ? 'selected' : ''}>Deluxe</option>
            <option value="Family"  ${param.roomtype == 'Family' ? 'selected' : ''}>Family</option>
            <option value="Executive" ${param.roomtype == 'Executive' ? 'selected' : ''}>Executive</option>
        </select>
        </br> 
        <label for="checkInDate">NGAY CHECK-IN:</label>
        <span class="red">
            <!-- kiểm tra xem checkInDate co after today không-->
            ${requestScope.ERRORCHECKINDATE} ${requestScope.TODAY}
        </span></br>
        <input type="date" id="checkInDate" name="booking_room_checkInDate" required="" value="<%= checkInStr%>"></br>  

        <label for="checkOutDate">NGAY CHECK-OUT:</label>
        <span class="red"> 
            <!-- kiểm tra ngày checkOut phải sau ngày chekIn -->
            ${requestScope.ERRORCHECKOUTDATE}
        </span> </br> 
        <input type="date" id="checkOutDate" name="booking_room_checkOutDate" required=""  value="<%= checkOutStr%>"></br>

        <input type="submit" value="<%= IConstants.AC_FILTER_ROOM%>" name="action">
    </form>
    <p class="red">${requestScope.ERROR_REQUIRED}</p>



    <!--         TH1: khi vừa bấm booking ở trang guest.jsp thì sẽ show ra hết các phòng status = "Available" (ko cần roomType, CheckInDate, CheckOutDate);
                 TH2: show ra tất cả các phòng thoả status = "Available" và roomType và checkInDate checkOutDtae-->
    <!--         TH3: show ra tất cả các phòng thoả từ ngày checkin đến checkout-->

    <%
        //Hiển thị thông tin tìm kiếm
        if (checkInStr != null && checkOutStr != null) {
    %>
    <div class="search-info">
        <h3>Bạn vừa tìm kiếm: </h3>
        <h4>Loại phòng: ${param.roomtype}</h4>
        <h4>Ngày CheckIn: <%= checkInStr%></h4>
        <h4>Ngày CheckOut: <%= checkOutStr%></h4>
    </div>
    <%
        }
        //Hiển thị danh sách phòng
        ArrayList<ShowRoomDTO> roomList = (ArrayList<ShowRoomDTO>) request.getAttribute("ALLROOM");
        if (roomList != null && !roomList.isEmpty()) {
            for (ShowRoomDTO r : roomList) {
    %>
    <div class="room-card">
        <p>TypeName: <%= r.getTypeName()%></p>
        <p>RoomNumber: <%= r.getRoomNumber()%></p>
        <p>Capacity: <%= r.getCapacity()%></p>
        <p>PricePerNight: <%= String.format("%,.0f VND", r.getPricePerNight()).replace(',', '.')%></p>
        <form action="MainController" method="POST">
            <input type="hidden" name="roomID" value="<%= r.getRoomID()%>">
            <!-- Nếu bấm gửi qua mà checkInDate và checkOutDate đều = null thì sẽ gửi error về thông báo cần phải chọn checkIn và checkOut-->
            <input type="hidden" name="booking_room_checkInDate" value=" <%= checkInStr%>">
            <input type="hidden" name="booking_room_checkOutDate" value=" <%= checkOutStr%>">
            <button type="submit" value="<%= IConstants.AC_BOOKING_ROOM%>" name="action">Dat Phong</button>
        </form>
    </div>
    <%
                }
            } else { //thông báo het phong tu FilterController
                String error = (String) request.getAttribute("ERROR");
                if (error != null && !error.trim().isEmpty()) {
                    out.print(error);
                }
            }
        }
    %>
    <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
</body>
</html>
