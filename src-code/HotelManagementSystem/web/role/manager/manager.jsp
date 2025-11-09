<%--
    Document : manager
    Created on : Oct 2, 2025, 3:19:16 PM
    Author : Admin
--%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="mylib.IConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Page</title>

        <style>
            /* ===== MAIN CONTENT AREA ===== */
            main {
                background-color: #f8f9fa;
                color: #333;
                font-family: Arial, sans-serif;
                padding: 50px 20px;
                max-width: 900px;
                margin: 0 auto;
                line-height: 1.6;
            }

            main h1 {
                color: #004a99;
                text-align: center;
                margin-bottom: 10px;
            }

            main h2 {
                color: #004a99;
                text-align: center;
                margin-bottom: 25px;
                border-bottom: 2px solid #004a99;
                display: inline-block;
                padding-bottom: 5px;
            }

            main p {
                text-align: center;
                font-size: 1rem;
                margin-top: 5px;
            }

            main p a {
                background-color: #004a99;
                color: #fff;
                padding: 8px 14px;
                border-radius: 5px;
                text-decoration: none;
                transition: background-color 0.2s ease;
            }

            main p a:hover {
                background-color: #0066cc;
            }

            .report-list {
                background-color: #fff;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 0 10px rgba(0,0,0,0.08);
            }

            .report-list h3 {
                color: #004a99;
                margin-bottom: 15px;
                border-left: 4px solid #004a99;
                padding-left: 10px;
            }

            .report-list ul {
                list-style-type: none;
                padding: 0;
                margin: 0;
            }

            .report-list li {
                margin: 12px 0;
            }

            .report-list a {
                display: inline-block;
                color: #004a99;
                font-weight: 500;
                text-decoration: none;
                background-color: #e9f1ff;
                padding: 10px 15px;
                border-radius: 6px;
                width: 100%;
                transition: all 0.2s ease;
            }

            .report-list a:hover {
                background-color: #004a99;
                color: #fff;
                transform: translateX(5px);
            }

            /* Giữ nguyên màu chữ trắng trong footer */
            footer h4 {
                color: #fff !important;
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />

        <main>
            <%
                // Lấy thông tin Manager từ session
                StaffDTO manager = (StaffDTO) session.getAttribute("STAFF");
                if (manager == null) {
                    request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
                } else {
            %>

            <h1>Welcome back, Manager <%= manager.getFullName()%></h1>
            <p><a href="MainController?action=logout">Đăng xuất</a></p>

            <h2>Manager Dashboard - Báo cáo & Thống kê</h2>

            <div class="report-list">
                <h3>Truy cập Báo cáo</h3>
                <ul>
                    <li><a href="MainController?action=ViewRevenueReport">📊 Báo cáo Doanh thu (Theo Ngày/Tháng/Năm)</a></li>
                    <li><a href="MainController?action=ViewTopGuestsReport">👥 Top 10 Khách hàng thường xuyên đặt phòng</a></li>
                    <li><a href="MainController?action=ViewMostUsedServicesReport">🛎️ Dịch vụ Được sử dụng Nhiều nhất</a></li>
                    <li><a href="MainController?action=ViewRoomOccupancyRateReport">🏨 Tỷ lệ Lấp đầy Phòng (Theo Tháng)</a></li>
                    <li><a href="MainController?action=ViewCancellationStatsReport">❌ Thống kê Hủy phòng</a></li>
                </ul>
            </div>

            <% }%>
        </main>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
