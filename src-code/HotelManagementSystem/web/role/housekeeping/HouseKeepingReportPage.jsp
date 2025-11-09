<%-- 
    Document   : HouseKeepingReportPage
    Created on : Oct 28, 2025, 9:33:38 AM
    Author     : Nguyễn Đại
--%>

<%@page import="DTO.Report_DTO.HouseKeepingReportDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report Page</title>
        <style>
            /* === ĐỒNG BỘ VỚI STYLE CHUNG === */
            body {
                background-color: #f8f9fa !important;
                color: #333333 !important;
                font-family: Arial, sans-serif !important;
                line-height: 1.6 !important;
                margin: 0;
                padding: 0;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            h1, h2, h3, h4, h5, h6 {
                color: #004a99 !important;
                margin: 1.2rem 0 0.8rem 0;
                font-weight: 600;
            }

            a {
                color: #004a99;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.2s ease;
            }

            a:hover {
                color: #003366;
                text-decoration: underline;
            }

            /* === CONTAINER CHÍNH === */
            .dashboard-container {
                flex: 1;
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 1.5rem;
                width: 100%;
            }

            /* === CARD SECTION === */
            .card {
                background: #ffffff;
                border-radius: 12px;
                padding: 1.5rem;
                margin-bottom: 1.8rem;
                border: 1px solid #e9ecef;
            }

            .card h3 {
                margin-top: 0;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #004a99;
                display: inline-block;
                font-size: 1.35rem;
            }

            /* === BUTTON CONTAINER === */
            .button-container {
                display: flex;
                gap: 1rem;
                justify-content: center;
                flex-wrap: wrap;
                margin-bottom: 1rem;
            }

            .report-btn {
                background: linear-gradient(135deg, #004a99, #003366);
                color: white;
                border: none;
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                cursor: pointer;
                font-size: 1rem;
                font-weight: 600;
                transition: all 0.3s ease;
                min-width: 120px;
            }

            .report-btn:hover {
                background: linear-gradient(135deg, #003366, #002244);
            }

            .report-btn.active {
                background: linear-gradient(135deg, #28a745, #218838);
            }

            .report-btn.active:hover {
                background: linear-gradient(135deg, #218838, #1e7e34);
            }

            /* === REPORT CONTENT === */
            .report-content {
                display: none;
                margin-top: 1.5rem;
            }

            .report-content.active {
                display: block;
            }

            /* === BẢNG === */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
                background-color: #ffffff;
                border: 1px solid #e9ecef;
            }

            th {
                background-color: #004a99;
                color: white;
                padding: 1rem 0.75rem;
                text-align: center;
                font-weight: 600;
                font-size: 0.95rem;
                border: 1px solid #003366;
            }

            td {
                padding: 0.9rem 0.75rem;
                text-align: center;
                border-bottom: 1px solid #e9ecef;
                font-size: 0.95rem;
            }

            tr:nth-child(even) {
                background-color: #f8fbff;
            }

            tr:hover {
                background-color: #f0f7ff;
                transition: background-color 0.2s ease;
            }

            /* === THÔNG BÁO === */
            .error-message {
                color: #e74c3c;
                font-weight: 500;
                padding: 0.75rem 1rem;
                background: #fdf2f2;
                border-left: 4px solid #e74c3c;
                border-radius: 5px;
                margin: 1rem 0;
            }

            .no-data {
                text-align: center;
                padding: 2rem;
                color: #6c757d;
                font-style: italic;
                background: #f8f9fa;
                border-radius: 10px;
                margin: 1rem 0;
            }

            /* === BACK BUTTON === */
            .back-btn {
                background: linear-gradient(135deg, #6c757d, #5a6268);
                color: white;
                border: none;
                padding: 0.65rem 1.3rem;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                margin-top: 1rem;
                transition: all 0.3s ease;
            }

            .back-btn:hover {
                background: linear-gradient(135deg, #5a6268, #484f54);
                text-decoration: none;
                color: white;
            }

            footer h2, footer h3, footer h4 {
                color: #fff !important;
                font-weight: 600;
            }

            /* === RESPONSIVE === */
            @media (max-width: 768px) {
                .button-container {
                    flex-direction: column;
                }

                .report-btn {
                    width: 100%;
                }

                table, thead, tbody, th, td, tr {
                    display: block;
                }

                thead tr {
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }

                tr {
                    border: 1px solid #ccc;
                    border-radius: 8px;
                    margin-bottom: 1rem;
                    padding: 0.5rem;
                    background: white;
                }

                td {
                    border: none;
                    position: relative;
                    padding-left: 50%;
                    text-align: right;
                }

                td:before {
                    content: attr(data-label);
                    position: absolute;
                    left: 1rem;
                    width: 45%;
                    font-weight: 600;
                    color: #004a99;
                    text-align: left;
                }
            }
        </style>        
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <%
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (staff == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
                return;
            }
        %>
        <div class="dashboard-container">
            <!-- Header -->
            <div class="card">
                <h1>Xin chào, <%= staff.getFullName() %> - Báo Cáo Dọn Dẹp</h1>
                <p>Chọn báo cáo để xem chi tiết</p>
            </div>

            <!-- Button Container -->
            <div class="card">
                <div class="button-container">
                    <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report1'">Report 1</button>
                    <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report2'">Report 2</button>
                    <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report3'">Report 3</button>
                    <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report4'">Report 4</button>
                    <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report5'">Report 5</button>
                </div>
            </div>

            <%
                String error = (String) request.getAttribute("Error");
                if (error != null) {
            %>
            <div class="card">
                <div class="error-message"><%= error%></div>
            </div>
            <%
                }
            %>

        <%
            // Determine which report to show (simplified)
            String showReport = (String) request.getAttribute("SHOW_REPORT");
            boolean hasReport1 = request.getAttribute("REPORT_1_LIST") != null;
            boolean hasReport2 = request.getAttribute("REPORT_2_LIST") != null;
            boolean hasReport3 = request.getAttribute("REPORT_3_LIST") != null;
            boolean hasReport4 = request.getAttribute("REPORT_4_LIST") != null;
            boolean hasReport5 = request.getAttribute("REPORT_5_LIST") != null;
            if (showReport == null) {
                if (hasReport1) {
                    showReport = "report1";
                } else if (hasReport2) {
                    showReport = "report2";
                } else if (hasReport3) {
                    showReport = "report3";
                } else if (hasReport4) {
                    showReport = "report4";
                } else if (hasReport5) {
                    showReport = "report5";
                }
            }
        %>

            <!-- Report 1 Content -->
            <div id="report1" class="report-content <%= ("report1".equals(showReport) || "all".equals(showReport)) ? "active" : ""%>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <%
                    if ("report1".equals(showReport) || "all".equals(showReport) || hasReport1) {
                %>
                <div class="card">
                    <h3>Báo Cáo Dọn Dẹp Phòng - Report 1</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Ngày</th>
                                <th>Số Phòng</th>
                                <th>Loại Dọn Dẹp</th>
                                <th>Tên Nhân Viên</th>
                                <th>Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<HouseKeepingReportDTO> report1List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_1_LIST");
                                if (report1List != null && !report1List.isEmpty()) {
                                    for (HouseKeepingReportDTO s : report1List) {
                            %>
                            <tr>
                                <td data-label="Ngày"><%= s.getDate()%></td>
                                <td data-label="Số Phòng"><%= s.getRoomNumber()%></td>
                                <td data-label="Loại Dọn Dẹp"><%= s.getCleaningType()%></td>
                                <td data-label="Tên Nhân Viên"><%= s.getStaffName()%></td>
                                <td data-label="Trạng Thái"><%= s.getStatus()%></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr><td colspan="5" class="no-data">Không có dữ liệu</td></tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>

            <!-- Report 2 Content -->
            <div id="report2" class="report-content <%= ("report2".equals(showReport) || "all".equals(showReport)) ? "active" : ""%>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <%
                    if ("report2".equals(showReport) || "all".equals(showReport) || hasReport2) {
                %>
                <div class="card">
                    <h3>Báo Cáo Trạng Thái Phòng - Report 2</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Số Phòng</th>
                                <th>Trạng Thái</th>
                                <th>Độ Ưu Tiên</th>
                                <th>Nhân Viên Phụ Trách</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<HouseKeepingReportDTO> report2List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_2_LIST");
                                if (report2List != null && !report2List.isEmpty()) {
                                    for (HouseKeepingReportDTO s : report2List) {
                            %>
                            <tr>
                                <td data-label="Số Phòng"><%= s.getRoomNumber()%></td>
                                <td data-label="Trạng Thái"><%= s.getStatus()%></td>
                                <td data-label="Độ Ưu Tiên"><%= s.getPriority()%></td>
                                <td data-label="Nhân Viên Phụ Trách">
                                    <%= s.getStaffName() != null ? s.getStaffName() : "Chưa phân công"%>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr><td colspan="4" class="no-data">Không có dữ liệu</td></tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>


            <!-- Report 3 Content -->
            <div id="report3" class="report-content <%= ("report3".equals(showReport) || "all".equals(showReport)) ? "active" : ""%>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <%
                    if ("report3".equals(showReport) || "all".equals(showReport) || hasReport3) {
                %>
                <div class="card">
                    <h3>Báo Cáo Lịch Sử Dọn Dẹp - Report 3</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Số Phòng</th>
                                <th>Loại Phòng</th>
                                <th>Trạng Thái</th>
                                <th>Ngày Dọn Dẹp Cuối</th>
                                <th>Check-in Tiếp Theo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<HouseKeepingReportDTO> report3List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_3_LIST");
                                if (report3List != null && !report3List.isEmpty()) {
                                    for (HouseKeepingReportDTO s : report3List) {
                            %>
                            <tr>
                                <td data-label="Số Phòng"><%= s.getRoomNumber()%></td>
                                <td data-label="Loại Phòng"><%= s.getRoomType()%></td>
                                <td data-label="Trạng Thái"><%= s.getStatus()%></td>
                                <td data-label="Ngày Dọn Dẹp Cuối"><%= s.getDate()%></td>
                                <td data-label="Check-in Tiếp Theo"><%= s.getCheckIn()%></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr><td colspan="5" class="no-data">Không có dữ liệu</td></tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>


            <!-- Report 4 Content -->
            <div id="report4" class="report-content <%= ("report4".equals(showReport) || "all".equals(showReport)) ? "active" : ""%>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <%
                    if ("report4".equals(showReport) || "all".equals(showReport) || hasReport4) {
                %>
                <div class="card">
                    <h3>Báo Cáo Sự Cố Phòng - Report 4</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Số Phòng</th>
                                <th>Mô Tả Sự Cố</th>
                                <th>Ngày Báo Cáo</th>
                                <th>Trạng Thái</th>
                                <th>Người Sửa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<HouseKeepingReportDTO> report4List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_4_LIST");
                                if (report4List != null && !report4List.isEmpty()) {
                                    for (HouseKeepingReportDTO s : report4List) {
                            %>
                            <tr>
                                <td data-label="Số Phòng"><%= s.getRoomNumber()%></td>
                                <td data-label="Mô Tả Sự Cố"><%= s.getIssueDescription()%></td>
                                <td data-label="Ngày Báo Cáo"><%= s.getReportDate()%></td>
                                <td data-label="Trạng Thái"><%= s.getStatus()%></td>
                                <td data-label="Người Sửa">
                                    <%= s.getStaffName() != null ? s.getStaffName() : "Chưa phân công"%>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr><td colspan="5" class="no-data">Không có dữ liệu</td></tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>


            <!-- Report 5 Content -->
            <div id="report5" class="report-content <%= ("report5".equals(showReport) || "all".equals(showReport)) ? "active" : ""%>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <%
                    if ("report5".equals(showReport) || "all".equals(showReport) || hasReport5) {
                %>
                <div class="card">
                    <h3>Báo Cáo Hiệu Suất Nhân Viên - Report 5</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Tên Nhân Viên</th>
                                <th>Số Phòng Đã Dọn</th>
                                <th>Số Lần Dọn Sâu</th>
                                <th>Ngày</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<HouseKeepingReportDTO> report5List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_5_LIST");
                                if (report5List != null && !report5List.isEmpty()) {
                                    for (HouseKeepingReportDTO s : report5List) {
                            %>
                            <tr>
                                <td data-label="Tên Nhân Viên"><%= s.getStaffName()%></td>
                                <td data-label="Số Phòng Đã Dọn"><%= s.getRoomCleaned()%></td>
                                <td data-label="Số Lần Dọn Sâu"><%= s.getDeepCleanings()%></td>
                                <td data-label="Ngày"><%= s.getDate()%></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr><td colspan="4" class="no-data">Không có dữ liệu</td></tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>

            <!-- Back Button -->
            <div class="card">
                <a class="back-btn" href="MainController?action=backtohousekeeping">⬅ Quay lại trang quản lý phòng</a>
            </div>
        </div>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
