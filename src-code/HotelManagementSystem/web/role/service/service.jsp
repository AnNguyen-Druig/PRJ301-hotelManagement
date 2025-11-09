<%-- 
    Document   : service
    Created on : Oct 2, 2025, 3:19:33 PM
    Author     : Admin
--%>

<%@page import="DTO.Service_DTO.GetBookingRoomForServiceDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service DashBoard</title>
        <style>
            /* === ĐỒNG BỘ VỚI STYLE CHUNG === */
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
                border: 1px solid #e9ecef;
            }

            .card h3 {
                margin-top: 0;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #004a99;
                display: inline-block;
                font-size: 1.35rem;
            }

            /* === BẢNG BOOKING === */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
                background-color: #ffffff;
                border: 1px solid #e9ecef;
            }

            th {
                background-color: #004a99;
                color: white;
                padding: 1rem 0.75rem;
                text-align: center;
                font-weight: 600;
                font-size: 0.95rem;
                border: 1px solid #003366;
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

            .status-checkin {
                background-color: #d1ecf1;
                color: #0c5460;
            }
            .status-reserved {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-checkout {
                background-color: #d4edda;
                color: #155724;
            }
            .status-occupied {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            /* === NÚT HÀNH ĐỘNG === */
            .action-buttons {
                display: flex;
                gap: 0.5rem;
                justify-content: center;
                align-items: center;
                flex-wrap: wrap;
            }

            .btn {
                background: linear-gradient(135deg, #004a99, #003366);
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-size: 0.9rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 90px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .btn:hover {
                background: linear-gradient(135deg, #003366, #002244);
            }

            .btn-secondary {
                background: linear-gradient(135deg, #28a745, #218838);
            }

            .btn-secondary:hover {
                background: linear-gradient(135deg, #218838, #1e7e34);
            }

            .btn-info {
                background: linear-gradient(135deg, #17a2b8, #138496);
            }

            .btn-info:hover {
                background: linear-gradient(135deg, #138496, #117a8b);
            }

            /* === LINK BÁO CÁO === */
            .report-link {
                display: inline-block;
                background: linear-gradient(135deg, #6c757d, #5a6268);
                color: white;
                padding: 0.65rem 1.3rem;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                margin-top: 0.5rem;
                transition: all 0.3s ease;
            }

            .report-link:hover {
                background: linear-gradient(135deg, #5a6268, #484f54);
                text-decoration: none;
                color: white;
            }

            /* === THÔNG BÁO LỖI === */
            .error-message {
                color: #e74c3c;
                font-weight: 500;
                padding: 0.75rem 1rem;
                background: #fdf2f2;
                border-left: 4px solid #e74c3c;
                border-radius: 5px;
                margin: 1rem 0;
            }

            /* === THÔNG BÁO KHÔNG CÓ DỮ LIỆU === */
            .no-data {
                text-align: center;
                padding: 2rem;
                color: #6c757d;
                font-style: italic;
                background: #f8f9fa;
                border-radius: 10px;
                margin: 1rem 0;
            }

            footer h2, footer h3, footer h4 {
                color: #fff !important;
                font-weight: 600;
            }

            /* === FORM STYLING === */
            form {
                margin: 0;
            }

            /* === RESPONSIVE === */
            @media (max-width: 768px) {
                .action-buttons {
                    flex-direction: column;
                }

                .action-buttons .btn {
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
        %>
        <div class="dashboard-container">
            <!-- Chào mừng -->
            <div class="card">
                <h1>Xin chào, <%= staff.getFullName() %> (Nhân viên dịch vụ)</h1>
                <p><a href="MainController?action=logout">Đăng xuất</a></p>
                <a href="MainController?action=reportpage" class="report-link">📊 Báo cáo các dịch vụ sử dụng chi tiết</a>
            </div>

            <!-- Danh sách phòng -->
            <div class="card">
                <h3>Danh Sách Phòng Đặt Dịch Vụ</h3>

                <%-- Hiển thị thông báo lỗi nếu có --%>
                <%
                    String error = (String) request.getAttribute("ERROR");
                    if (error != null) {
                %>
                <div class="error-message"><%= error %></div>
                <%
                    }
                %>

                <%
                    List<GetBookingRoomForServiceDTO> list = (List<GetBookingRoomForServiceDTO>) request.getAttribute("ALLROOM");
                    if (list != null && !list.isEmpty()) {
                %>
                <table>
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Room ID</th>
                            <th>Tên Khách</th>
                            <th>Trạng Thái Phòng</th>
                            <th>Ngày Check-in</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (GetBookingRoomForServiceDTO room : list) {
                                String statusClass = "status status-" + room.getStatus().toLowerCase().replace(" ", "");
                %>
                <tr>
                            <td data-label="Booking ID"><%= room.getBookingID()%></td>
                            <td data-label="Room ID"><%= room.getRoomID()%></td>
                            <td data-label="Tên Khách"><%= room.getGuestName() %></td>
                            <td data-label="Trạng Thái Phòng">
                                <span class="<%= statusClass %>"><%= room.getStatus()%></span>
                            </td>
                            <td data-label="Ngày Check-in"><%= room.getCheckinDate() %></td>
                            <td data-label="Hành Động">
                                <div class="action-buttons">
                        <form action="MainController" method="POST" style="display:inline">
                            <input type="hidden" name="bookingId" value="<%= room.getBookingID()%>"/>
                                        <button type="submit" name="action" value="ChooseService" class="btn btn-secondary">Chọn dịch vụ</button>
                                    </form>
                                    <form action="MainController" method="POST" style="display:inline">
                            <input type="hidden" name="bookingId" value="<%= room.getBookingID()%>"/>
                                        <button type="submit" name="action" value="ViewServiceCtrl" class="btn btn-info">Xem dịch vụ</button>
                        </form>
                                </div>
                    </td>
                </tr>
                <%
                    }
                        %>
                    </tbody>
                </table>
                <%
                } else {
                %>
                <p class="no-data">Không có thông tin phòng.</p>
                <%
                    }
                %>
            </div>
        </div>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
