<%--
    Document : roomoccupancypage
    Created on : Oct 27, 2025, 1:22:25 PM
    Author : Admin
--%>
<%@page import="mylib.IConstants"%>
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
            .report-container {
                max-width: 1100px;
                margin: 20px auto;
                background-color: #ffffff;
                padding: 35px;
                border-radius: 14px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            }

            .report-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 25px;
                margin-top: 20px;
            }

            .report-section {
                background-color: #f8fdff;
                padding: 22px;
                border-radius: 12px;
                border-left: 6px solid #004a99;
                box-shadow: 0 3px 10px rgba(0, 74, 153, 0.1);
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }

            .report-section:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 16px rgba(0, 74, 153, 0.15);
            }

            .report-section.full-width {
                grid-column: 1 / -1;
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

            .filter-form select,
            .filter-form input[type="number"] {
                padding: 10px 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 1em;
                min-width: 120px;
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
                min-width: 180px;
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

            /* Hạng 1, 2, 3 nổi bật */
            .rank-1 {
                background-color: #fff3cd !important;
                font-weight: bold;
            }
            .rank-2 {
                background-color: #d4edda !important;
            }
            .rank-3 {
                background-color: #d1ecf1 !important;
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
            @media (max-width: 992px) {
                .report-grid {
                    grid-template-columns: 1fr;
                }
                .report-section.full-width {
                    grid-column: auto;
                }
            }

            @media (max-width: 768px) {
                .report-container {
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
                .filter-form select,
                .filter-form input {
                    width: 100%;
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

                .statistic {
                    flex-direction: column;
                    text-align: center;
                }

                .statistic-label {
                    min-width: auto;
                    margin-bottom: 5px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />

        <%
            Integer totalRooms = (Integer) request.getAttribute("TOTAL_ROOMS");
            Map<String, Integer> roomCountByType = (Map<String, Integer>) request.getAttribute("ROOM_COUNT_BY_TYPE");
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
            Integer selectedMonth = (Integer) request.getAttribute("SELECTED_MONTH");
            Integer selectedYear = (Integer) request.getAttribute("SELECTED_YEAR");

            if (selectedMonth == null) {
                selectedMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
            }
            if (selectedYear == null) {
                selectedYear = currentYear;
            }

            Map<String, Object> occupancyStats = (Map<String, Object>) request.getAttribute("OCCUPANCY_STATS");
            List<RoomOccupancyDTO> top10RoomList = (List<RoomOccupancyDTO>) request.getAttribute("ROOM_OCCUPANCY_LIST");
            String errMsg = (String) request.getAttribute("ERROR");
            if (errMsg == null)
                errMsg = "";
        %>

        <h1>Báo cáo - Tỷ lệ Lấp đầy & Hoạt động Phòng</h1>

        <div class="report-container">
            <div class="report-grid">

                <!-- 1. Tổng số phòng -->
                <div class="report-section">
                    <h3>1. Tổng số phòng Khách sạn hiện có</h3>
                    <div class="statistic">
                        <span class="statistic-label">Tổng số phòng:</span>
                        <span class="statistic-value"><%= (totalRooms != null) ? totalRooms : "N/A"%></span>
                    </div>
                </div>

                <!-- 2. Số lượng phòng theo loại -->
                <div class="report-section">
                    <h3>2. Số lượng phòng theo loại</h3>
                    <% if (roomCountByType != null && !roomCountByType.isEmpty()) { %>
                    <table>
                        <thead>
                            <tr>
                                <th>Loại phòng</th>
                                <th>Số lượng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Map.Entry<String, Integer> entry : roomCountByType.entrySet()) {%>
                            <tr>
                                <td><%= entry.getKey()%></td>
                                <td><strong><%= entry.getValue()%></strong></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <% } else { %>
                    <p class="info-message">Không có dữ liệu về loại phòng.</p>
                    <% } %>
                </div>

                <!-- Bộ lọc -->
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

                <!-- 3. Top 10 phòng -->
                <div class="report-section">
                    <h3>3. Top 10 phòng được đặt nhiều nhất</h3>
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
                            <%
                                int rank = 1;
                                for (RoomOccupancyDTO room : top10RoomList) {
                                    String rowClass = "";
                                    if (rank == 1)
                                        rowClass = "rank-1";
                                    else if (rank == 2)
                                        rowClass = "rank-2";
                                    else if (rank == 3)
                                        rowClass = "rank-3";
                            %>
                            <tr class="<%= rowClass%>">
                                <td><%= rank++%></td>
                                <td><strong><%= room.getRoomNumber()%></strong></td>
                                <td><%= room.getTypeName()%></td>
                                <td><span class="statistic-value"><%= room.getRoomCount()%></span></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <% } else {%>
                    <p class="info-message"><%= errMsg.isEmpty() ? "Không có dữ liệu đặt phòng." : errMsg%></p>
                    <% } %>
                </div>

                <!-- 4. Tỷ lệ lấp đầy -->
                <div class="report-section">
                    <h3>4. Tỷ lệ phòng được đặt</h3>
                    <% if (occupancyStats != null && !occupancyStats.isEmpty()) {
                            Integer uniqueRoomsBooked = (Integer) occupancyStats.get("Số phòng đang được đặt");
                            Integer totalRoomsForCalc = (Integer) occupancyStats.get("Tổng số phòng");
                            Double occupancyPercentage = (Double) occupancyStats.get("Tỷ lệ phòng được đặt");
                            int availableRooms = totalRoomsForCalc - uniqueRoomsBooked;
                    %>
                    <div class="statistic">
                        <span class="statistic-label">Số phòng được đặt:</span>
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
                        <span class="statistic-label">Tỷ lệ lấp đầy:</span>
                        <span class="statistic-value"><%= String.format("%.2f", occupancyPercentage)%>%</span>
                    </div>
                    <% } else {%>
                    <p class="info-message"><%= errMsg.isEmpty() ? "Không có dữ liệu thống kê." : errMsg%></p>
                    <% }%>
                </div>

            </div>

            <!-- NÚT QUAY LẠI -->
            <div class="back-link">
                <a href="MainController?action=gobackmanager">Quay lại Dashboard</a>
            </div>
        </div>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>