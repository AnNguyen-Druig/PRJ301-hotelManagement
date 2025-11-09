<%--
    Document : revenuereportpage
    Created on : Nov 2, 2025, 11:39:27 AM
    Author : Admin
--%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Báo cáo Doanh Thu</title>

        <!-- CSS INTERNAL - ĐỒNG BỘ VỚI style.css -->
        <style>
            /* ===== THIẾT LẬP CƠ BẢN - KHÔNG ĐỘNG VÀO HEADER/FOOTER ===== */
            body {
                background-color: #f8f9fa;
                color: #333333;
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 0;
            }

            h2 {
                color: #004a99;
                font-size: 1.7em;
                text-align: center;
                margin: 35px 0 20px;
                padding-bottom: 10px;
                border-bottom: 3px solid #004a99;
                display: inline-block;
                min-width: 300px;
                position: relative;
                left: 50%;
                transform: translateX(-50%);
            }

            /* ===== NỘI DUNG CHÍNH ===== */
            .report-container {
                max-width: 900px;
                margin: 20px auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            }

            .report-section {
                margin-bottom: 40px;
                padding: 20px;
                background-color: #f8fdff;
                border-radius: 10px;
                border-left: 6px solid #004a99;
            }

            .report-section h3 {
                color: #004a99;
                font-size: 1.3em;
                margin: 0 0 18px 0;
                font-weight: bold;
            }

            /* ===== FORM LỌC ===== */
            .filter-form {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                align-items: center;
                justify-content: center;
                margin-bottom: 20px;
                padding: 15px;
                background-color: #e6f5ff;
                border-radius: 8px;
            }

            .filter-form label {
                font-weight: bold;
                color: #004a99;
                margin-right: 8px;
                white-space: nowrap;
            }

            .filter-form input[type="date"],
            .filter-form input[type="number"],
            .filter-form select {
                padding: 10px 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 1em;
                min-width: 150px;
                box-sizing: border-box;
            }

            .filter-form input:focus,
            .filter-form select:focus {
                outline: none;
                border-color: #004a99;
                box-shadow: 0 0 6px rgba(0, 74, 153, 0.3);
            }

            .filter-form button {
                background-color: #004a99;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
                font-size: 1em;
                transition: background-color 0.3s ease;
            }

            .filter-form button:hover {
                background-color: #003366;
            }

            /* ===== KẾT QUẢ DOANH THU ===== */
            .result-box {
                background-color: #d4edff;
                padding: 16px 20px;
                border-radius: 8px;
                font-size: 1.1em;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 15px;
                border: 1px solid #b8daff;
            }

            .result-box span:first-child {
                font-weight: bold;
                color: #004a99;
            }

            .result-box .statistic-value {
                font-weight: bold;
                font-size: 1.3em;
                color: #004a99;
                font-family: 'Courier New', monospace;
            }

            /* ===== LỖI ===== */
            .error-msg {
                color: #721c24;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                padding: 12px;
                border-radius: 6px;
                text-align: center;
                margin: 15px 0;
                font-weight: bold;
            }

            /* ===== NÚT QUAY LẠI ===== */
            .back-link {
                display: block;
                text-align: center;
                margin: 30px 0;
            }

            .back-link a {
                display: inline-block;
                background-color: #004a99;
                color: white;
                text-decoration: none;
                padding: 12px 24px;
                border-radius: 6px;
                font-weight: bold;
                font-size: 1em;
                transition: background-color 0.3s ease;
            }

            .back-link a:hover {
                background-color: #003366;
            }

            hr {
                border: none;
                border-top: 1px solid #e0e0e0;
                margin: 35px 0;
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 768px) {
                .report-container {
                    margin: 15px;
                    padding: 20px;
                }

                .filter-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-form label {
                    margin-bottom: 5px;
                }

                .filter-form input,
                .filter-form select,
                .filter-form button {
                    width: 100%;
                }

                .result-box {
                    flex-direction: column;
                    text-align: center;
                }

                .result-box .statistic-value {
                    font-size: 1.2em;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />

        <%
            Double totalRevenueBySelectDate = (Double) request.getAttribute("REVENUE_BY_SELECT_DATE");
            String selectDate = (String) request.getAttribute("SELECTED_DATE");
            Double totalRevenueByMonth = (Double) request.getAttribute("REVENUE_BY_MONTH");
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
            Integer selectMonth = (Integer) request.getAttribute("SELECT_MONTH");
            Integer selectYear = (Integer) request.getAttribute("SELECT_YEAR");
            Double totalRevenueByYear = (Double) request.getAttribute("REVENUE_BY_SELECT_YEAR");
            Integer selectYearOnly = (Integer) request.getAttribute("SELECTED_YEAR_ONLY");
            String errMsg = (String) request.getAttribute("ERROR");
            if (errMsg == null) {
                errMsg = "";
            }
            if (selectDate == null)
                selectDate = "";
        %>

        <div class="report-container">

            <!-- BÁO CÁO THEO NGÀY -->
            <h2>Báo cáo Doanh Thu theo Ngày</h2>
            <div class="report-section">
                <h3>Lọc theo ngày</h3>
                <form action="MainController" class="filter-form">
                    <input type="hidden" name="month" value="<%= selectMonth%>">
                    <input type="hidden" name="year" value="<%= selectYear%>">
                    <input type="hidden" name="selectYear" value="<%= selectYearOnly%>">
                    <label for="selectDate">Chọn ngày:</label>
                    <input type="date" id="selectDate" name="selectDate" value="<%= selectDate%>">
                    <button type="submit" name="action" value="ViewRevenueReport">Xem báo cáo Ngày</button>
                </form>

                <% if (totalRevenueBySelectDate != null) {%>
                <div class="result-box">
                    <span>Tổng doanh thu ngày <%= selectDate%>:</span>
                    <span class="statistic-value"><%= String.format("%,.0f VND", totalRevenueBySelectDate).replace(',', '.')%></span>
                </div>
                <% } else if (!errMsg.isEmpty()) {%>
                <p class="error-msg"><%= errMsg%></p>
                <% }%>
            </div>

            <hr/>

            <!-- BÁO CÁO THEO THÁNG -->
            <h2>Báo cáo Doanh Thu theo Tháng</h2>
            <div class="report-section">
                <h3>Lọc theo tháng/năm</h3>
                <form action="MainController" class="filter-form">
                    <input type="hidden" name="selectDate" value="<%= selectDate%>">
                    <input type="hidden" name="selectYear" value="<%= selectYearOnly%>">
                    <label for="monthSelect">Chọn Tháng:</label>
                    <select name="month" id="monthSelect" required>
                        <% for (int m = 1; m <= 12; m++) {
                                String selectedAttr = (selectMonth != null && m == selectMonth) ? "selected" : "";
                        %>
                        <option value="<%= m%>" <%= selectedAttr%>>Tháng <%= m%></option>
                        <% }%>
                    </select>
                    <label for="yearInput">Chọn Năm:</label>
                    <input type="number" name="year" id="yearInput" value="<%= selectYear%>" min="2000" max="<%= currentYear%>" required>
                    <button type="submit" name="action" value="ViewRevenueReport">Xem báo cáo Tháng</button>
                </form>

                <% if (totalRevenueByMonth != null) {%>
                <div class="result-box">
                    <span>Tổng doanh thu tháng <%= selectMonth%> năm <%= selectYear%>:</span>
                    <span class="statistic-value"><%= String.format("%,.0f VND", totalRevenueByMonth).replace(',', '.')%></span>
                </div>
                <% } else if (!errMsg.isEmpty()) {%>
                <p class="error-msg"><%= errMsg%></p>
                <% }%>
            </div>

            <hr/>

            <!-- BÁO CÁO THEO NĂM -->
            <h2>Báo cáo Doanh Thu theo Năm</h2>
            <div class="report-section">
                <h3>Lọc theo năm</h3>
                <form action="MainController" method="GET" class="filter-form">
                    <input type="hidden" name="selectDate" value="<%= selectDate%>">
                    <input type="hidden" name="month" value="<%= selectMonth%>">
                    <input type="hidden" name="year" value="<%= selectYear%>">
                    <label for="selectYear">Chọn Năm:</label>
                    <select name="selectYear" id="selectYear" required>
                        <% for (int y = currentYear; y >= 2000; y--) {
                                String selectedAttr = (selectYearOnly != null && y == selectYearOnly) ? "selected" : "";
                        %>
                        <option value="<%= y%>" <%= selectedAttr%>>Năm <%= y%></option>
                        <% } %>
                    </select>
                    <button type="submit" name="action" value="ViewRevenueReport">Xem báo cáo Năm</button>
                </form>

                <% if (totalRevenueByYear != null) {%>
                <div class="result-box">
                    <span>Tổng doanh thu năm <%= selectYearOnly%>:</span>
                    <span class="statistic-value"><%= String.format("%,.0f VND", totalRevenueByYear).replace(',', '.')%></span>
                </div>
                <% } else if (!errMsg.isEmpty()) {%>
                <p class="error-msg"><%= errMsg%></p>
                <% }%>
            </div>

            <hr/>

            <!-- NÚT QUAY LẠI -->
            <div class="back-link">
                <a href="MainController?action=gobackmanager">Quay lại Dashboard</a>
            </div>
        </div>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>