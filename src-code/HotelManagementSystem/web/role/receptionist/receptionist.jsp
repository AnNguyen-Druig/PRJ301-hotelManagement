<%--
    Document : receptionist
    Created on : Oct 2, 2025, 3:19:09 PM
    Author : Admin
--%>
<%@page import="DTO.Receptionist_DTO.ShowBookingDTO"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Receptionist Dashboard</title>

        <!-- Nhúng CSS chung -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styles.css">

        <!-- CSS NỘI BỘ - ĐỒNG BỘ VỚI styles.css -->
        <style>
            /* === ĐỒNG BỘ VỚI styles.css === */
            body {
                background-color: #f8f9fa !important;
                color: #333333 !important;
                font-family: Arial, sans-serif !important;
                line-height: 1.6 !important;
                margin: 0;
                padding: 0;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            h1, h2, h3, h4, h5, h6 {
                color: #004a99 !important;
                margin: 1.2rem 0 0.8rem 0;
                font-weight: 600;
            }

            a {
                color: #004a99;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.2s ease;
            }

            a:hover {
                color: #003366;
                text-decoration: underline;
            }

            /* === CONTAINER CHÍNH === */
            .dashboard-container {
                flex: 1;
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 1.5rem;
                width: 100%;
            }

            /* === CARD SECTION === */
            .card {
                background: #ffffff;
                border-radius: 12px;
                padding: 1.5rem;
                margin-bottom: 1.8rem;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                border: 1px solid #e9ecef;
            }

            .card h3 {
                margin-top: 0;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #004a99;
                display: inline-block;
                font-size: 1.35rem;
            }

            /* === FORM TẠO BOOKING === */
            .make-booking-form {
                display: flex;
                gap: 0.8rem;
                align-items: center;
                flex-wrap: wrap;
            }

            .make-booking-form input[type="text"] {
                padding: 0.65rem 1rem;
                border: 1.5px solid #ccc;
                border-radius: 8px;
                font-size: 1rem;
                width: 260px;
                transition: border 0.3s ease;
            }

            .make-booking-form input[type="text"]:focus {
                outline: none;
                border-color: #004a99;
                box-shadow: 0 0 0 3px rgba(0, 74, 153, 0.15);
            }

            .btn {
                background: linear-gradient(135deg, #004a99, #003366);
                color: white;
                border: none;
                padding: 0.65rem 1.3rem;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 140px;
            }

            .btn:hover {
                background: linear-gradient(135deg, #003366, #002244);
                transform: translateY(-1px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .error-text {
                color: #e74c3c;
                font-weight: 500;
                margin-left: 0.5rem;
                font-size: 0.95rem;
            }

            /* === FILTER FORM === */
            .filter-form {
                display: flex;
                align-items: center;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .filter-form label {
                font-weight: 600;
                color: #333;
            }

            .filter-form select {
                padding: 0.65rem 1rem;
                border: 1.5px solid #ccc;
                border-radius: 8px;
                font-size: 1rem;
                background-color: white;
                min-width: 180px;
                cursor: pointer;
                transition: border 0.3s ease;
            }

            .filter-form select:focus {
                outline: none;
                border-color: #004a99;
                box-shadow: 0 0 0 3px rgba(0, 74, 153, 0.15);
            }

            /* === BẢNG BOOKING === */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
                background-color: #ffffff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            }

            th {
                background: linear-gradient(135deg, #004a99, #003366);
                color: white;
                padding: 1rem 0.75rem;
                text-align: center;
                font-weight: 600;
                font-size: 0.95rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            td {
                padding: 0.9rem 0.75rem;
                text-align: center;
                border-bottom: 1px solid #e9ecef;
                font-size: 0.95rem;
            }

            tr:nth-child(even) {
                background-color: #f8fbff;
            }

            tr:hover {
                background-color: #f0f7ff;
                transition: background-color 0.2s ease;
            }

            /* === TRẠNG THÁI MÀU SẮC === */
            .status {
                padding: 0.35rem 0.75rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-reserved {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-checkin {
                background-color: #d1ecf1;
                color: #0c5460;
            }
            .status-checkout {
                background-color: #d4edda;
                color: #155724;
            }
            .status-canceled {
                background-color: #f8d7da;
                color: #721c24;
            }
            .status-complete {
                background-color: #e2e3e5;
                color: #383d41;
            }

            /* === NÚT HÀNH ĐỘNG === */
            /* === NÚT HÀNH ĐỘNG (CẬP NHẬT) === */
            .action-link {
                display: inline-block;
                background: linear-gradient(135deg, #004a99, #003366);
                color: white;
                padding: 0.4rem 1rem;   /* tăng padding */
                border-radius: 8px;        /* bo góc lớn hơn */
                font-size: 0.95rem;        /* tăng kích thước chữ */
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
                transition: all 0.25s ease;
            }

            .action-link:hover {
                background: linear-gradient(135deg, #003366, #002244);
                transform: translateY(-2px);
                box-shadow: 0 5px 12px rgba(0, 0, 0, 0.2);
                text-decoration: none;
            }


            /* === THÔNG BÁO KHÔNG CÓ DỮ LIỆU === */
            .no-data {
                text-align: center;
                padding: 2rem;
                color: #e74c3c;
                font-style: italic;
                background: #fdf2f2;
                border-radius: 10px;
                margin: 1rem 0;
            }

            footer h2, footer h3, footer h4 {
                color: #fff !important;
                font-weight: 600;
            }

            /* === RESPONSIVE === */
            @media (max-width: 768px) {
                .make-booking-form,
                .filter-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .make-booking-form input[type="text"],
                .filter-form select {
                    width: 100%;
                }

                table, thead, tbody, th, td, tr {
                    display: block;
                }

                thead tr {
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }

                tr {
                    border: 1px solid #ccc;
                    border-radius: 8px;
                    margin-bottom: 1rem;
                    padding: 0.5rem;
                    background: white;
                }

                td {
                    border: none;
                    position: relative;
                    padding-left: 50%;
                    text-align: right;
                }

                td:before {
                    content: attr(data-label);
                    position: absolute;
                    left: 1rem;
                    width: 45%;
                    font-weight: 600;
                    color: #004a99;
                    text-align: left;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />

        <%
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (staff == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
                return;
            }

            String makeBookingErr = (String) request.getAttribute("ERROR");
            if (makeBookingErr == null) {
                makeBookingErr = "";
            }

            String selectedStatus = (String) request.getAttribute("SELECTED_STATUS");
            if (selectedStatus == null)
                selectedStatus = "All";
        %>

        <div class="dashboard-container">

            <!-- Chào mừng -->
            <div class="card">
                <h1>Xin chào, <%= staff.getFullName()%> (Lễ tân)</h1>
                <p><a href="MainController?action=logout">Đăng xuất</a></p>
            </div>

            <!-- Tạo Booking Mới -->
            <div class="card">
                <h3>Tạo Booking Mới</h3>
                <form action="MainController" class="make-booking-form">
                    <input type="text" name="guest_idnumber" placeholder="Nhập số CCCD/CMND khách" required>
                    <button type="submit" name="action" value="Make new Booking" class="btn">Đặt phòng</button>
                    <span class="error-text"><%= makeBookingErr%></span>
                </form>
                <p style="margin-top: 1rem;">
                    <a href="MainController?action=Signup">Đăng ký thành viên cho khách</a>
                </p>
            </div>

            <!-- Lọc Booking -->
            <div class="card">
                <h3>Lọc Danh Sách Booking</h3>
                <form action="MainController" class="filter-form">
                    <input type="hidden" name="action" value="TurnBackReceptionPage">
                    <label for="statusSelect">Trạng thái:</label>
                    <select name="selectedStatus" id="statusSelect" onchange="this.form.submit();">
                        <option value="All" <%= "All".equals(selectedStatus) ? "selected" : ""%>>Tất cả</option>
                        <option value="Reserved" <%= "Reserved".equals(selectedStatus) ? "selected" : ""%>>Reserved</option>
                        <option value="CheckIn" <%= "CheckIn".equals(selectedStatus) ? "selected" : ""%>>Check In</option>
                        <option value="CheckOut" <%= "CheckOut".equals(selectedStatus) ? "selected" : ""%>>Check Out</option>
                        <option value="Canceled" <%= "Canceled".equals(selectedStatus) ? "selected" : ""%>>Canceled</option>
                        <option value="Complete" <%= "Complete".equals(selectedStatus) ? "selected" : ""%>>Complete</option>
                    </select>
                </form>
            </div>

            <!-- Danh sách Booking -->
            <div class="card">
                <h3>
                    Danh Sách Booking
                    <% if (!"All".equals(selectedStatus)) {%>
                    <small style="color:#004a99; font-weight:normal;">(Trạng thái: <%= selectedStatus%>)</small>
                    <% } %>
                </h3>

                <%
                    ArrayList<ShowBookingDTO> bookingList = (ArrayList) request.getAttribute("ALLBOOKING");
                    String bookingListError = (String) request.getAttribute("BOOKING_LIST_ERROR");
                    if (bookingListError == null)
                        bookingListError = "";
                %>

                <% if (bookingList != null && !bookingList.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Guest ID</th>
                            <th>Tên khách</th>
                            <th>Room ID</th>
                            <th>Số phòng</th>
                            <th>Loại phòng</th>
                            <th>Check-in</th>
                            <th>Check-out</th>
                            <th>Ngày đặt</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (ShowBookingDTO b : bookingList) {
                                String statusClass = "status status-".concat(
                                        b.getStatus().toLowerCase().replace(" ", "")
                                );
                        %>
                        <tr>
                            <td data-label="Booking ID"><%= b.getBookingID()%></td>
                            <td data-label="Guest ID"><%= b.getGuestID()%></td>
                            <td data-label="Tên khách"><%= b.getGuestName()%></td>
                            <td data-label="Room ID"><%= b.getRoomID()%></td>
                            <td data-label="Số phòng"><%= b.getRoomNumber()%></td>
                            <td data-label="Loại phòng"><%= b.getRoomType()%></td>
                            <td data-label="Check-in"><%= b.getCheckInDate()%></td>
                            <td data-label="Check-out"><%= b.getCheckOutDate()%></td>
                            <td data-label="Ngày đặt"><%= b.getBookingDate()%></td>
                            <td data-label="Trạng thái"><span class="<%= statusClass%>"><%= b.getStatus()%></span></td>
                            <td data-label="Hành động">
                                <a href="MainController?action=UpdateBooking&bookingID=<%= b.getBookingID()%>" class="action-link">Cập nhật</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else {%>
                <p class="no-data">
                    <%= !bookingListError.isEmpty() ? bookingListError : "Không có booking nào phù hợp với trạng thái đã chọn."%>
                </p>
                <% }%>
            </div>

        </div>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>