<%-- 
    Document   : manager
    Created on : Oct 2, 2025, 3:19:16 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page import="DTO.StaffDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Page</title>
    </head>
    <body>
        <%
            // Lấy thông tin Manager từ session
            StaffDTO manager = (StaffDTO) session.getAttribute("USER");
            if(manager == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
        %>
        <h1>Welcome back, Manager <%= manager.getFullName() %></h1>
        <p><a href="MainController?action=logout">Logout</a></p>
        <h2>Manager Dashboard - Báo cáo & Thống kê</h2>

        <div class="report-list">
            <h3>Truy cập Báo cáo</h3>
            <ul>
                <li>
                    <a href="MainController?action=reportpage">Báo cáo thống kê chi tiết</a>
                </li>
                <li>
                    <%--Trong trang này sẽ lọc theo ngày/tháng/năm, tùy chọn--%>
                    <a href="MainController?action=ViewRevenueReport">📊 Báo cáo Doanh thu (Theo Ngày/Tháng/Năm)</a>
                </li>
                <li>
                    <a href="MainController?action=ViewTopGuestsReport">👥 Top 10 Khách hàng thường xuyên đặt phòng</a>
                </li>
                <li>
                    <a href="MainController?action=ViewMostUsedServicesReport">🛎️ Dịch vụ Được sử dụng Nhiều nhất</a>
                </li>
                <li>
                    <%-- Trang này sẽ có bộ lọc chọn Tháng/Năm --%>
                    <a href="MainController?action=ViewRoomOccupancyRateReport">🏨 Tỷ lệ Lấp đầy Phòng (Theo Tháng)</a>   
                </li>
                <li>
                    <a href="MainController?action=ViewCancellationStatsReport">❌ Thống kê Hủy phòng</a>
                </li>
            </ul>
        </div>

        <p><a href="LogoutController?action=logout">Logout</a></p>
        <%}%>
    </body>
</html>
