<%-- 
    Document   : roomoccupancypage
    Created on : Oct 27, 2025, 1:22:25 PM
    Author     : Admin
--%>
<%@page import="DTO.Manager_DTO.RoomOccupancyDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Báo cáo - Tỷ lệ Đặt phòng</title>
        <style>
            body {
                font-family: sans-serif;
                margin: 20px;
            }
            h1 {
                border-bottom: 2px solid #333;
                padding-bottom: 10px;
            }
            .report-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-top: 20px;
            }
            .report-section {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                border: 1px solid #dee2e6;
            }
            .report-section.full-width {
                grid-column: 1 / -1;
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
                min-width: 150px;
            }
            .statistic-value {
                font-size: 1.2em;
                color: #0056b3;
            }
            table, th, td {
                border: 1px solid #ccc;
                border-collapse: collapse;
                padding: 8px;
                margin-top: 10px;
                width: 100%;
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
            }
        </style>
    </head>
    <body>
        <h1>Báo cáo - Tỷ lệ Lấp đầy & Hoạt động Phòng</h1>

        <%
            // --- Lấy dữ liệu TĨNH (Toàn bộ khách sạn) ---
            Integer totalRooms = (Integer) request.getAttribute("TOTAL_ROOMS");
            Map<String, Integer> roomCountByType = (Map<String, Integer>) request.getAttribute("ROOM_COUNT_BY_TYPE");

            // --- Lấy dữ liệu LỌC (Theo tháng/năm) ---
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
            Integer selectedMonth = (Integer) request.getAttribute("SELECTED_MONTH");
            Integer selectedYear = (Integer) request.getAttribute("SELECTED_YEAR");

            // Đặt giá trị mặc định nếu null
            if (selectedMonth == null) {
                selectedMonth = Calendar.getInstance().get(Calendar.MONTH) + 1; // Tháng (0-11) + 1
            }
            if (selectedYear == null) {
                selectedYear = currentYear;
            }

            // Lấy kết quả báo cáo
            Map<String, Object> occupancyStats = (Map<String, Object>) request.getAttribute("OCCUPANCY_STATS");
            List<RoomOccupancyDTO> top10RoomList = (List<RoomOccupancyDTO>) request.getAttribute("ROOM_OCCUPANCY_LIST");
            String errMsg = (String) request.getAttribute("ERROR");
            if(errMsg == null) errMsg = "";
        %>

        <%-- Bố cục lưới cho các báo cáo --%>
        <div class.report-grid">

            <%-- 1. Tổng số phòng --%>
            <div class="report-section">
                <h3>1. Tổng số phòng Khách sạn hiện có</h3>
                <div class="statistic">
                    <span class="statistic-label">Tổng số phòng:</span>
                    <span class="statistic-value"><%= (totalRooms != null) ? totalRooms : "N/A"%></span>
                </div>
            </div>

            <%-- 2. Số lượng phòng theo loại --%>
            <div class="report-section">
                <h3>2. Số lượng phòng của từng RoomType có</h3>
                <% if (roomCountByType != null && !roomCountByType.isEmpty()) { %>
                <table>
                    <thead><tr><th>Loại phòng</th><th>Số lượng</th></tr></thead>
                    <tbody>
                        <% for (Map.Entry<String, Integer> entry : roomCountByType.entrySet()) {%>
                        <tr>
                            <td><%= entry.getKey()%></td>
                            <td><%= entry.getValue()%></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <p class="info-message">Không có dữ liệu về loại phòng.</p>
                <% } %>
            </div>

            <%-- Bộ lọc cho các báo cáo động --%>
            <div class="report-section full-width">
                <h3>Báo cáo động (theo Tháng/Năm)</h3>
                <div class="filter-form">
                    <form action="MainController" method="GET">
                        <input type="hidden" name="action" value="ViewRoomOccupancyRateReport">
                        <label for="monthSelect">Chọn Tháng:</label>
                        <select name="month" id="monthSelect" required>
                            <% for (int m = 1; m <= 12; m++) {
                                    String selectedAttr = (selectedMonth != null && m == selectedMonth) ? "selected" : "";
                            %>
                            <option value="<%= m%>" <%= selectedAttr%>>Tháng <%= m%></option>
                            <% }%>
                        </select>

                        <label for="yearInput">Chọn Năm:</label>
                        <input type="number" name="year" id="yearInput" value="<%= selectedYear%>" min="2000" max="<%= currentYear%>" required>

                        <input type="submit" value="Xem Báo cáo">
                    </form>
                </div>
            </div>

            <%-- ===== SỬA LẠI THỨ TỰ: MỤC 3 LÊN TRƯỚC ===== --%>
            <%-- 3. Top 10 phòng --%>
            <div class="report-section">
                <h3>3. Top 10 phòng được đặt nhiều nhất (Tháng <%= selectedMonth%>/<%= selectedYear%>)</h3>
                <% if (top10RoomList != null && !top10RoomList.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Hạng</th>
                            <th>Số phòng</th>
                            <th>Loại phòng</th>
                            <th>Số lượt đặt</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int rank = 1;
                            for (RoomOccupancyDTO room : top10RoomList) {
                        %>
                        <tr>
                            <td><%= rank++%></td>
                            <td><%= room.getRoomNumber()%></td>
                            <td><%= room.getTypeName()%></td>
                            <td><%= room.getRoomCount()%></td>
                        </tr>
                        <% } // Kết thúc vòng lặp %>
                    </tbody>
                </table>
                <% } else { %>
                <p class="info-message"><%= errMsg %></p>
                <% } %>
            </div>

            <%-- ===== SỬA LẠI THỨ TỰ: MỤC 4 XUỐNG DƯỚI ===== --%>
            <%-- 4. Tỷ lệ phòng được đặt --%>
            <div class="report-section">
                <%-- Sửa lại tiêu đề cho đúng yêu cầu của bạn --%>
                <h3>4. Tỷ lệ phòng được đặt (Tháng <%= selectedMonth%>/<%= selectedYear%>)</h3>
                <% if (occupancyStats != null && !occupancyStats.isEmpty()) {
                        Integer uniqueRoomsBooked = (Integer) occupancyStats.get("Số phòng đang được đặt");
                        Integer totalRoomsForCalc = (Integer) occupancyStats.get("Tổng số phòng");
                        Double occupancyPercentage = (Double) occupancyStats.get("Tỷ lệ phòng được đặt");

                        // Tính số phòng trống
                        int availableRooms = totalRoomsForCalc - uniqueRoomsBooked;
                %>
                <div class="statistic">
                    <span class="statistic-label">Số phòng được đặt (duy nhất):</span>
                    <span class="statistic-value"><%= uniqueRoomsBooked%></span>
                </div>
                <div class="statistic">
                    <span class="statistic-label">Số phòng trống:</span>
                    <span class="statistic-value"><%= availableRooms%></span>
                </div>
                <div class="statistic">
                    <span class="statistic-label">Tổng số phòng:</span>
                    <span class="statistic-value"><%= totalRoomsForCalc%></span>
                </div>
                <div class="statistic">
                    <span class="statistic-label">Tỷ lệ lấp đầy (Đặt/Tổng):</span>
                    <span class="statistic-value"><%= String.format("%.2f", occupancyPercentage)%>%</span>
                </div>
                <% } else { %>
                <p class="info-message"><%= errMsg %></p>
                <% }%>
            </div>

        </div> <%-- End report-grid --%>

        <%-- Nút quay lại --%>
        <a href="MainController?action=gobackmanager" class="back-link">Quay lại Dashboard</a>

    </body>
</html>

