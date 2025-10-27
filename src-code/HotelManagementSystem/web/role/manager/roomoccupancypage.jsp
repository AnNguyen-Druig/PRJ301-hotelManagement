<%--
    File   : roomOccupancyReport.jsp (Scriptlet Version)
    Author : [Tên của bạn]
--%>
<%@page import="DTO.RoomOccupancyDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Báo cáo - Tỷ lệ Đặt phòng Theo Tháng</title>
        <style>
            body {
                font-family: sans-serif;
                margin: 20px;
            }
            .filter-form {
                margin-bottom: 20px;
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                border: 1px solid #dee2e6;
            }
            .filter-form label {
                margin-right: 5px;
            }
            .filter-form select, .filter-form input[type=number] {
                padding: 5px;
                margin-right: 15px;
            }
            .filter-form input[type=submit] {
                padding: 5px 15px;
                cursor: pointer;
            }
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 8px;
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
            .report-title {
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <h1>Báo cáo - Tỷ lệ Đặt phòng Theo Tháng/Năm</h1>

        <%
            // Lấy tháng/năm hiện tại để giới hạn ô nhập năm
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);

            // Lấy tháng/năm đã chọn từ controller
            Integer selectedMonth = (Integer) request.getAttribute("SELECTED_MONTH");
            Integer selectedYear = (Integer) request.getAttribute("SELECTED_YEAR");

            // Đặt giá trị mặc định nếu null
            if (selectedMonth == null) {
                selectedMonth = Calendar.getInstance().get(Calendar.MONTH) + 1; // Tháng bắt đầu từ 0
            }
            if (selectedYear == null) {
                selectedYear = currentYear;
            }

            // Lấy dữ liệu báo cáo và thông báo
            List<RoomOccupancyDTO> roomList = (List<RoomOccupancyDTO>) request.getAttribute("ROOM_OCCUPANCY_LIST");
            String reportError = (String) request.getAttribute("REPORT_ERROR");
            String reportInfo = (String) request.getAttribute("REPORT_INFO");
        %>

        <%-- Form Filter --%>
        <div class="filter-form">
            <form action="MainController" method="GET">
                <input type="hidden" name="action" value="ViewOccupancyRateReport"> <%-- Giữ nguyên action --%>

                <label for="monthSelect">Chọn Tháng:</label>
                <select name="month" id="monthSelect" required>
                    <%-- Lặp qua 12 tháng --%>
                    <% for (int m = 1; m <= 12; m++) {
                            String selectedAttr = "";
                            // Kiểm tra và đặt thuộc tính selected
                            if (selectedMonth != null && m == selectedMonth) {
                                selectedAttr = "selected";
                            }
                    %>
                    <option value="<%= m%>" <%= selectedAttr%>>Tháng <%= m%></option>
                    <% }%>
                </select>

                <label for="yearInput">Chọn Năm:</label>
                <input type="number" name="year" id="yearInput" value="<%= selectedYear%>" min="2000" max="<%= currentYear%>" required>

                <input type="submit" value="Xem Báo cáo">
            </form>
        </div>

        <%-- Hiển thị lỗi hoặc thông tin (nếu có) --%>
        <% if (reportError != null) {%>
        <p class="error-message">Lỗi: <%= reportError%></p>
        <% } %>
        <% if (reportInfo != null) {%>
        <p class="info-message"><%= reportInfo%></p>
        <% } %>

        <%-- Hiển thị bảng kết quả nếu có dữ liệu --%>
        <% if (roomList != null && !roomList.isEmpty()) {%>
        <h3 class="report-title">Top 10 phòng được đặt nhiều nhất trong Tháng <%= selectedMonth%>/<%= selectedYear%></h3>
        <table>
            <thead>
                <tr>
                    <th>Hạng</th>
                    <th>Room ID</th>
                    <th>Số phòng</th>
                    <th>Loại phòng</th>
                    <th>Sức chứa</th>
                    <th>Giá/Đêm</th>
                    <th>Số lượt đặt</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int rank = 1; // Biến đếm thứ hạng
                    for (RoomOccupancyDTO room : roomList) {
                %>
                <tr>
                    <td><%= rank++%></td>
                    <td><%= room.getRoomID()%></td>
                    <td><%= room.getRoomNumber()%></td>
                    <td><%= room.getTypeName()%></td>
                    <td><%= room.getCapacity()%></td>
                    <td><%= room.getPricePerNight()%></td>
                    <td><%= room.getRoomCount() %></td>
                </tr>
                <% } // Kết thúc vòng lặp %>
            </tbody>
        </table>
        <% } else if (reportError == null && reportInfo == null) { // Chỉ hiển thị nếu không có lỗi/info và không có data %>
        <p>Vui lòng chọn tháng/năm để xem báo cáo.</p> <%-- Hoặc thông báo khác --%>
        <% } %>


        <%-- Nút quay lại trang Manager Dashboard --%>
        <a href="MainController?action=goBackToManagerDashboard" class="back-link">Quay lại Dashboard</a>

    </body>
</html>

