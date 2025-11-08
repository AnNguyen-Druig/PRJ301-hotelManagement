<%-- 
    Document   : cancelstatisticspage
    Created on : Oct 29, 2025, 1:39:21 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page import="java.util.Map"%>    <%-- <<< CHỈ CẦN IMPORT Map --%>
<%@page import="java.util.List"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Báo cáo - Thống kê Hủy phòng</title>
        <style>
            body {
                font-family: sans-serif;
                margin: 20px;
            }
            .report-section {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                border: 1px solid #dee2e6;
                margin-bottom: 20px;
            }
            .filter-form {
                margin-bottom: 15px;
                padding-bottom: 15px;
                border-bottom: 1px solid #dee2e6;
            }
            .statistic {
                margin-bottom: 10px;
            }
            .statistic-label {
                font-weight: bold;
                display: inline-block;
                min-width: 200px;
            }
            .statistic-value {
                font-size: 1.1em;
            }
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 8px;
                margin-top: 10px;
            }
            th {
                background-color: #e9ecef;
                text-align: left;
            }
            .back-link {
                margin-top: 20px;
                display: inline-block;
                padding: 8px 15px;
                background-color: #6c757d;
                color: white;
                text-decoration: none;
                border-radius: 4px;
            }
            .back-link:hover {
                background-color: #5a6268;
            }
            .error-message {
                color: red;
                font-weight: bold;
            }
            .info-message {
                color: #17a2b8;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <h1>Báo cáo - Thống kê Hủy phòng</h1>

        <%
            // Lấy dữ liệu tổng quát
            Integer totalBookings = (Integer) request.getAttribute("TOTAL_BOOKINGS");
            Integer totalCancellations = (Integer) request.getAttribute("TOTAL_CANCELLATIONS");
            Double cancellationRate = (Double) request.getAttribute("CANCELLATION_RATE");
            
            //Dùng để format hiển thị 2 chữ số thập phân
            String formattedRate = String.format("%.2f", cancellationRate);

            // Lấy dữ liệu hủy theo khoảng thời gian
            Integer cancellationsInRange = (Integer) request.getAttribute("CANCELLATIONS_IN_RANGE");
            String startDateFilter = (String) request.getAttribute("START_DATE_FILTER");
            String endDateFilter = (String) request.getAttribute("END_DATE_FILTER");

            // Lấy dữ liệu hủy theo tháng/năm - Ép kiểu sang Map (Interface)
            Map<String, Integer> cancellationsByMonth = (Map<String, Integer>) request.getAttribute("CANCELLATIONS_BY_MONTH");

            // Lấy dữ liệu hủy theo loại phòng - Ép kiểu sang Map (Interface)
            Map<String, Integer> cancellationsByRoomType = (Map<String, Integer>) request.getAttribute("CANCELLATIONS_BY_ROOM_TYPE");

            // Lấy lỗi chung
            String errMsg = (String) request.getAttribute("ERROR");
            if(errMsg == null) errMsg = "";
            
            //Loi cua phan danh sach Cancel Booking theo Room Type
            String errMsgRT = (String) request.getAttribute("ERROR_ROOMTYPE_LIST");
            if(errMsgRT == null) errMsgRT = "";

            // Giá trị mặc định
            if (totalBookings == null) {
                totalBookings = 0;
            }
            if (totalCancellations == null) {
                totalCancellations = 0;
            }
            if (cancellationRate == null) {
                cancellationRate = 0.0;
            }
            if (startDateFilter == null) {
                startDateFilter = "";
            }
            if (endDateFilter == null)
                endDateFilter = "";
        %>

        <%-- 1 & 2 & 3. Thống kê tổng quát --%>
        <div class="report-section">
            <h3>Thống kê Tổng quát</h3>
            <div class="statistic">
                <span class="statistic-label">1. Tổng số booking đã tạo:</span>
                <span class="statistic-value"><%= totalBookings%></span>
            </div>
            <div class="statistic">
                <span class="statistic-label">2. Tổng số lượt hủy (toàn bộ):</span>
                <span class="statistic-value"><%= totalCancellations%></span>
            </div>
            <div class="statistic">
                <span class="statistic-label">3. Tỷ lệ hủy (Tổng hủy / Tổng booking):</span>
                <span class="statistic-value"><%= formattedRate%>%</span>
            </div>
        </div>

        <%-- 4. Hủy theo khoảng thời gian --%>
        <div class="report-section">
            <h3>4. Số lượt hủy theo Khoảng thời gian</h3>
            <div class="filter-form">
                <form action="MainController" method="POST">
                    <label for="startDate">Từ ngày:</label>
                    <input type="date" id="startDate" name="startDate" value="<%= startDateFilter%>">
                    <label for="endDate">Đến ngày:</label>
                    <input type="date" id="endDate" name="endDate" value="<%= endDateFilter%>">
                    <input type="submit" name="action" value="ViewCancellationStatsReport">
                </form>
            </div>
            <% if (cancellationsInRange != null) {%>
            <div class="statistic">
                <span class="statistic-label">Số lượt hủy từ <%= startDateFilter%> đến <%= endDateFilter%>:</span>
                <span class="statistic-value"><%= cancellationsInRange%></span>
            </div>
            <% } else if (startDateFilter != "" || endDateFilter != "") { %>
            <p class="info-message"><%= errMsg %></p>
            <% } else { %>
            <p class="info-message">Chọn khoảng thời gian để xem thống kê.</p>
            <% } %>
        </div>

        <%-- 5. Hủy theo Tháng/Năm --%>
        <div class="report-section">
            <h3>5. Số lượt hủy theo Tháng/Năm (Dựa trên ngày đặt)</h3>
            <%-- Vòng lặp vẫn dùng Map.Entry --%>
            <% if (cancellationsByMonth != null && !cancellationsByMonth.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>Tháng/Năm</th>
                        <th>Số lượt hủy</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map.Entry<String, Integer> entry : cancellationsByMonth.entrySet()) {%>
                    <tr>
                        <td><%= entry.getKey()%></td>
                        <td><%= entry.getValue()%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else { %>
            <p class="info-message"><%= errMsg %></p>
            <% } %>
        </div>

        <%-- 6. Hủy theo Loại phòng --%>
        <div class="report-section">
            <h3>6. Số lượt hủy theo Loại phòng</h3>
            <%-- Vòng lặp vẫn dùng Map.Entry --%>
            <% if (cancellationsByRoomType != null && !cancellationsByRoomType.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>Loại phòng</th>
                        <th>Số lượt hủy</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map.Entry<String, Integer> entry : cancellationsByRoomType.entrySet()) {%>
                    <tr>
                        <td><%= entry.getKey()%></td>
                        <td><%= entry.getValue()%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else { %>
            <p class="info-message"><%= errMsgRT %></p>
            <% }%>
        </div>

        <%-- Nút quay lại --%>
        <a href="MainController?action=gobackmanager" class="back-link">Quay lại Dashboard</a>

    </body>
</html>