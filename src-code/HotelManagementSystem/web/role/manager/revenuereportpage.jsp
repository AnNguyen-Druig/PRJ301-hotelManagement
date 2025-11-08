<%-- 
    Document   : revenuereportpage
    Created on : Nov 2, 2025, 11:39:27 AM
    Author     : Admin
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <%
            //Lấy ra các dữ liệu của chức năng 1) Tổng Doanh thu lọc theo ngày
            Double totalRevenueBySelectDate = (Double) request.getAttribute("REVENUE_BY_SELECT_DATE");
            String selectDate = (String) request.getAttribute("SELECTED_DATE");

            //Lấy ra các dữ liệu của chức năng 2) Tổng Doanh thu lọc theo tháng/năm
            Double totalRevenueByMonth = (Double) request.getAttribute("REVENUE_BY_MONTH");
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
            Integer selectMonth = (Integer) request.getAttribute("SELECT_MONTH");
            Integer selectYear = (Integer) request.getAttribute("SELECT_YEAR");

            //Lấy ra các dữ liệu của chức năng 3) Tổng Doanh thu lọc theo năm
            Double totalRevenueByYear = (Double) request.getAttribute("REVENUE_BY_SELECT_YEAR");
            Integer selectYearOnly = (Integer) request.getAttribute("SELECTED_YEAR_ONLY");

            //Lấy ra dữ liệu hiển thị Lỗi
            String errMsg = (String) request.getAttribute("ERROR");
            if (errMsg == null) {
                errMsg = "";
            }
            if (selectDate == null) {
                selectDate = "";
            }
        %>
        <h2>Báo cáo Doanh Thu theo Ngày (Daily Report)</h2>
        <div>
            <form action="MainController">
                <input type="hidden" name="month" value="<%= selectMonth%>">
                <input type="hidden" name="year" value="<%= selectYear%>">
                <input type="hidden" name="selectYear" value="<%= selectYearOnly%>">
                <label for="selectDate">Chọn ngày:</label>
                <input type="date" id="selectDate" name="selectDate" value="<%= selectDate%>">
                <button type="submit" name="action" value="ViewRevenueReport">Xem báo cáo Ngày</button>
            </form>
        </div>
        <% if (totalRevenueBySelectDate != null) {%>
        <div>
            <span>Tổng doanh thu của ngày  <%= selectDate%>:</span>
            <span><%= String.format("%,.0f VND", totalRevenueBySelectDate).replace(',', '.')%></span>
        </div>
        <% } else {%>
        <p><%= errMsg%></p>
        <% }%>
        <hr/>
        <h2>Báo cáo Doanh Thu theo Tháng (Monthly Report)</h2>    
        <div>
            <form action="MainController">    
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
        </div>
        <% if (totalRevenueByMonth != null) {%>
        <div>
            <span>Tổng doanh thu của tháng <%= selectMonth%> năm <%=  selectYear%>:</span>
            <span><%= String.format("%,.0f VND", totalRevenueByMonth).replace(',', '.')%></span>
        </div>
        <% } else {%>
        <p><%= errMsg%></p>
        <% }%>
        <hr/>
        <h2>Báo cáo Doanh Thu theo Năm (Yearly Report)</h2>    
        <div>
            <form action="MainController" method="GET">
                <%-- Gửi kèm trạng thái của 2 form kia --%>
                <input type="hidden" name="selectDate" value="<%= selectDate%>">
                <input type="hidden" name="month" value="<%= selectMonth%>">
                <input type="hidden" name="year" value="<%= selectYear%>"> 

                <label for="selectYear">Chọn Năm:</label>
                <select name="selectYear" id="selectYear" required>
                    <% for (int y = currentYear; y >= 2000; y--) { // Lặp từ năm hiện tại về 2000
                            String selectedAttr = (y == selectYearOnly) ? "selected" : "";
                    %>
                    <option value="<%= y%>" <%= selectedAttr%>>Năm <%= y%></option>
                    <% } %>
                </select>

                <button type="submit" name="action" value="ViewRevenueReport">Xem báo cáo Năm</button>
            </form>
        </div>

        <% if (totalRevenueByYear != null) {%>
        <div>
            <span>Tổng doanh thu của năm <%= selectYearOnly%>:</span>
            <span class="statistic-value"><%= String.format("%,.0f VND", totalRevenueByYear).replace(',', '.')%></span>
        </div>
        <% } else {%>
        <p><%= errMsg%></p>
        <% }%>

        <hr/>
        <a href="MainController?action=gobackmanager">Quay lại Dashboard</a>
    </body>
</html>
