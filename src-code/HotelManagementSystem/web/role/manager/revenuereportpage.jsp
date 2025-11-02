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
        <%
            Double totalRevenueBySelectDate = (Double) request.getAttribute("REVENUE_BY_SELECT_DATE");
            String selectDate = (String) request.getAttribute("SELECTED_DATE");

            Double totalRevenueByMonth = (Double) request.getAttribute("REVENUE_BY_MONTH");
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);
            Integer selectMonth = (Integer) request.getAttribute("SELECT_MONTH");
            Integer selectYear = (Integer) request.getAttribute("SELECT_YEAR");
            
            Double totalRevenueByYear = (Double) request.getAttribute("REVENUE_BY_SELECT_YEAR");
            Integer selectYearOnly = (Integer) request.getAttribute("SELECTED_YEAR_ONLY");
            
            if (selectDate == null) {
                selectDate = "";
            }
        %>
        <h2>Báo cáo Doanh Thu theo Ngày (Daily Report)</h2>
        <div>
            <form action="MainController">
                <label for="selectDate">Chọn ngày:</label>
                <input type="hidden" name="month" value="<%= selectMonth%>">
                <input type="hidden" name="year" value="<%= selectYear%>">
                <input type="date" id="selectDate" name="selectDate" value="<%= selectDate%>">
                <input type="submit" name="action" value="ViewRevenueReport">
            </form>
        </div>
        <% if (totalRevenueBySelectDate != null) {%>
        <div>
            <span>Tổng doanh thu của ngày  <%= selectDate%>:</span>
            <span><%= String.format("%,.0f VND", totalRevenueBySelectDate).replace(',', '.')%></span>
        </div>
        <% } else { %>
        <p>Chọn khoảng thời gian để xem thống kê.</p>
        <% }%>
        <hr/>
        <h2>Báo cáo Doanh Thu theo Tháng (Monthly Report)</h2>    
        <div>
            <form action="MainController">
                <input type="hidden" name="action" value="ViewRevenueReport">
                <input type="hidden" name="selectDate" value="<%= selectDate%>">
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

                <input type="submit" value="Xem Báo cáo">
            </form>
        </div>
        <% if (totalRevenueByMonth != null) {%>
        <div>
            <span>Tổng doanh thu của tháng <%= selectMonth%> năm <%=  selectYear%>:</span>
            <span><%= String.format("%,.0f VND", totalRevenueByMonth).replace(',', '.')%></span>
        </div>
        <% }%>
        <hr/>
        <h2>Báo cáo Doanh Thu theo Năm (Yearly Report)</h2>    
        <div>
            <form action="MainController" method="GET">
                <input type="hidden" name="action" value="ViewRevenueReport">

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

                <input type="submit" value="Xem Báo cáo Năm">
            </form>
        </div>

        <% if (totalRevenueByYear != null) {%>
        <div>
            <span>Tổng doanh thu của năm <%= selectYearOnly%>:</span>
            <span class="statistic-value"><%= String.format("%,.0f VND", totalRevenueByYear).replace(',', '.')%></span>
        </div>
        <% } %>

        <hr/>
        <a href="MainController?action=gobackmanager">Quay lại Dashboard</a>
    </body>
</html>
