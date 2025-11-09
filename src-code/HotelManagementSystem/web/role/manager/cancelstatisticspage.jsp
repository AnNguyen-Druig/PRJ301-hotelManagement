<%--
    Document : cancelstatisticspage
    Created on : Oct 29, 2025, 1:39:21 PM
    Author : Admin
--%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Báo cáo - Thống kê Hủy phòng</title>

        <!-- CSS INTERNAL - ĐỒNG BỘ VỚI style.css -->
        <style>
            /* ===== CƠ BẢN - KHÔNG ĐỘNG VÀO HEADER/FOOTER ===== */
            body {
                background-color: #f8f9fa;
                color: #333333;
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 0;
            }

            h1 {
                color: #004a99;
                font-size: 2em;
                text-align: center;
                margin: 40px 0 30px;
                padding-bottom: 12px;
                border-bottom: 3px solid #004a99;
                display: inline-block;
                min-width: 400px;
                position: relative;
                left: 50%;
                transform: translateX(-50%);
                font-weight: bold;
            }

            /* ===== NỘI DUNG CHÍNH ===== */
            .cancel-container {
                max-width: 1000px;
                margin: 20px auto;
                background-color: #ffffff;
                padding: 35px;
                border-radius: 14px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            }

            .report-section {
                background-color: #f8fdff;
                padding: 22px;
                border-radius: 12px;
                border-left: 6px solid #004a99;
                margin-bottom: 30px;
                box-shadow: 0 3px 10px rgba(0, 74, 153, 0.1);
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }

            .report-section:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 16px rgba(0, 74, 153, 0.15);
            }

            .report-section h3 {
                color: #004a99;
                font-size: 1.35em;
                margin: 0 0 18px 0;
                font-weight: bold;
                text-align: center;
            }

            /* ===== FORM LỌC ===== */
            .filter-form {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                align-items: center;
                justify-content: center;
                padding: 18px;
                background-color: #e6f5ff;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            .filter-form label {
                font-weight: bold;
                color: #004a99;
                margin-right: 8px;
                white-space: nowrap;
            }

            .filter-form input[type="date"] {
                padding: 10px 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 1em;
                min-width: 160px;
            }

            .filter-form input[type="submit"] {
                background-color: #004a99;
                color: white;
                border: none;
                padding: 10px 22px;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
                font-size: 1em;
                transition: background-color 0.3s ease;
            }

            .filter-form input[type="submit"]:hover {
                background-color: #003366;
            }

            /* ===== THỐNG KÊ NHỎ ===== */
            .statistic {
                margin-bottom: 14px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 10px;
                font-size: 1.05em;
            }

            .statistic-label {
                font-weight: bold;
                color: #004a99;
                min-width: 220px;
            }

            .statistic-value {
                font-weight: bold;
                font-size: 1.3em;
                color: #004a99;
                font-family: 'Courier New', monospace;
            }

            /* ===== BẢNG DỮ LIỆU ===== */
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 18px 0;
                font-size: 1em;
                background-color: #ffffff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            table th {
                background-color: #004a99;
                color: white;
                padding: 14px 12px;
                text-align: center;
                font-weight: bold;
                font-size: 1.05em;
            }

            table td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #e0e0e0;
                transition: background-color 0.2s ease;
            }

            table tr:hover td {
                background-color: #f1f9ff;
            }

            table tr:nth-child(even) {
                background-color: #f8fdff;
            }

            /* ===== THÔNG BÁO ===== */
            .info-message {
                color: #0c5460;
                background-color: #d1ecf1;
                border: 1px solid #bee5eb;
                padding: 12px;
                border-radius: 8px;
                text-align: center;
                margin: 15px 0;
                font-style: italic;
            }

            .error-message {
                color: #721c24;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                padding: 14px;
                border-radius: 8px;
                text-align: center;
                margin: 15px 0;
                font-weight: bold;
            }

            /* ===== NÚT QUAY LẠI ===== */
            .back-link {
                display: block;
                text-align: center;
                margin: 40px 0 20px;
            }

            .back-link a {
                display: inline-block;
                background-color: #004a99;
                color: white;
                text-decoration: none;
                padding: 14px 30px;
                border-radius: 8px;
                font-weight: bold;
                font-size: 1.1em;
                transition: all 0.3s ease;
                box-shadow: 0 3px 8px rgba(0, 74, 153, 0.2);
            }

            .back-link a:hover {
                background-color: #003366;
                transform: translateY(-2px);
                box-shadow: 0 6px 14px rgba(0, 74, 153, 0.3);
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 768px) {
                .cancel-container {
                    margin: 15px;
                    padding: 25px;
                }

                h1 {
                    font-size: 1.6em;
                    min-width: 300px;
                }

                .filter-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-form label,
                .filter-form input {
                    width: 100%;
                }

                .statistic {
                    flex-direction: column;
                    text-align: center;
                }

                .statistic-label {
                    min-width: auto;
                    margin-bottom: 5px;
                }

                table {
                    font-size: 0.9em;
                }

                table th, table td {
                    padding: 8px 6px;
                }
            }

            @media (max-width: 576px) {
                table {
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />

        <%
            Integer totalBookings = (Integer) request.getAttribute("TOTAL_BOOKINGS");
            Integer totalCancellations = (Integer) request.getAttribute("TOTAL_CANCELLATIONS");
            Double cancellationRate = (Double) request.getAttribute("CANCELLATION_RATE");
            String formattedRate = (cancellationRate != null) ? String.format("%.2f", cancellationRate) : "0.00";

            Integer cancellationsInRange = (Integer) request.getAttribute("CANCELLATIONS_IN_RANGE");
            String startDateFilter = (String) request.getAttribute("START_DATE_FILTER");
            String endDateFilter = (String) request.getAttribute("END_DATE_FILTER");

            Map<String, Integer> cancellationsByMonth = (Map<String, Integer>) request.getAttribute("CANCELLATIONS_BY_MONTH");
            Map<String, Integer> cancellationsByRoomType = (Map<String, Integer>) request.getAttribute("CANCELLATIONS_BY_ROOM_TYPE");

            String errMsg = (String) request.getAttribute("ERROR");
            if (errMsg == null) {
                errMsg = "";
            }

            String errMsgRT = (String) request.getAttribute("ERROR_ROOMTYPE_LIST");
            if (errMsgRT == null) {
                errMsgRT = "";
            }

            if (totalBookings == null) {
                totalBookings = 0;
            }
            if (totalCancellations == null) {
                totalCancellations = 0;
            }
            if (startDateFilter == null) {
                startDateFilter = "";
            }
            if (endDateFilter == null)
                endDateFilter = "";
        %>

        <h1>Báo cáo - Thống kê Hủy phòng</h1>

        <div class="cancel-container">

            <!-- 1-3. Thống kê tổng quát -->
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

            <!-- 4. Hủy theo khoảng thời gian -->
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
                <% } else if (!startDateFilter.isEmpty() || !endDateFilter.isEmpty()) {%>
                <p class="error-message"><%= errMsg%></p>
                <% } else { %>
                <p class="info-message">Chọn khoảng thời gian để xem thống kê.</p>
                <% } %>
            </div>

            <!-- 5. Hủy theo Tháng/Năm -->
            <div class="report-section">
                <h3>5. Số lượt hủy theo Tháng/Năm</h3>
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
                            <td><strong><%= entry.getValue()%></strong></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else {%>
                <p class="info-message"><%= errMsg.isEmpty() ? "Không có dữ liệu hủy theo tháng." : errMsg%></p>
                <% } %>
            </div>

            <!-- 6. Hủy theo Loại phòng -->
            <div class="report-section">
                <h3>6. Số lượt hủy theo Loại phòng</h3>
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
                            <td><strong><%= entry.getValue()%></strong></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else {%>
                <p class="info-message"><%= errMsgRT.isEmpty() ? "Không có dữ liệu hủy theo loại phòng." : errMsgRT%></p>
                <% }%>
            </div>

            <!-- NÚT QUAY LẠI -->
            <div class="back-link">
                <a href="MainController?action=gobackmanager">Quay lại Dashboard</a>
            </div>
        </div>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>