<%-- 
    Document   : reportmainpage
    Created on : Oct 22, 2025, 11:50:29 PM
    Author     : Nguyễn Đại
--%>

<%@page import="java.util.List"%>
<%@page import="DTO.Report_DTO.ReportDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report View Page</title>
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

            /* === TRẠNG THÁI MÀU SẮC === */
            .status {
                padding: 0.35rem 0.75rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .status-pending {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-completed {
                background-color: #d4edda;
                color: #155724;
            }
            .status-inprogress {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            /* === FORM === */
            .filter-form {
                display: flex;
                align-items: center;
                gap: 1rem;
                flex-wrap: wrap;
                padding: 1rem;
                background: #f8f9fa;
                border-radius: 8px;
                margin: 1rem 0;
            }

            .filter-form label {
                font-weight: 600;
                color: #333;
            }

            .filter-form input[type="date"] {
                padding: 0.65rem 1rem;
                border: 1.5px solid #ccc;
                border-radius: 8px;
                font-size: 1rem;
                background-color: white;
                cursor: pointer;
                transition: border 0.3s ease;
            }

            .filter-form input[type="date"]:focus {
                outline: none;
                border-color: #004a99;
                box-shadow: 0 0 0 3px rgba(0, 74, 153, 0.15);
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
                margin: 0.5rem;
                transition: all 0.3s ease;
            }

            .back-btn:hover {
                background: linear-gradient(135deg, #5a6268, #484f54);
                text-decoration: none;
                color: white;
            }

            .action-buttons {
                display: flex;
                gap: 1rem;
                justify-content: center;
                flex-wrap: wrap;
                margin-top: 1rem;
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

                .filter-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-form input[type="date"],
                .filter-form .report-btn {
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
                <h1>Xin chào, <%= staff.getFullName() %> - Báo Cáo Dịch Vụ</h1>
                <p>Chọn báo cáo để xem chi tiết</p>
            </div>
            
            <!-- Button Container -->
            <div class="card">
                <div class="button-container">
                    <button class="report-btn" type="button" onclick="window.location.href='ReportMainController?action=report1'">Report 1</button>
                    <button class="report-btn" type="button" onclick="window.location.href='ReportMainController?action=report2'">Report 2</button>
                    <button class="report-btn" type="button" onclick="window.location.href='ReportMainController?action=report3'">Report 3</button>
                    <button class="report-btn" type="button" onclick="loadReport4()">Report 4</button>
                </div>
            </div>
            
            <%
                String error = (String) request.getAttribute("Error");
                if (error != null) {
            %>
            <div class="card">
                <div class="error-message"><%= error %></div>
            </div>
            <%
                }
            %>
            
            <%
                // Determine which report to show
                String showReport = (String) request.getAttribute("SHOW_REPORT");
                boolean hasReport1 = request.getAttribute("REPORT_1_LIST") != null;
                boolean hasReport2 = request.getAttribute("REPORT_2_LIST") != null;
                boolean hasReport3 = request.getAttribute("REPORT_3_LIST") != null;
                boolean hasReport4 = request.getAttribute("REPORT_4_LIST") != null;
                if (showReport == null) {
                    if (hasReport1) showReport = "report1";
                    else if (hasReport2) showReport = "report2";
                    else if (hasReport3) showReport = "report3";
                    else if (hasReport4) showReport = "report4";
                }
            %>
            
            <!-- Report 1 Content -->
            <div id="report1" class="report-content <%= ("report1".equals(showReport) || "all".equals(showReport)) ? "active" : "" %>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <%
                    if ("report1".equals(showReport) || "all".equals(showReport) || hasReport1) {
                %>
                <div class="card">
                    <h3>Báo Cáo Lịch Sử Dịch Vụ - Report 1</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Ngày Dịch Vụ</th>
                                <th>Tên Khách</th>
                                <th>Số Phòng</th>
                                <th>Tên Dịch Vụ</th>
                                <th>Số Lượng</th>
                                <th>Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<ReportDTO> report1List = (List<ReportDTO>) request.getAttribute("REPORT_1_LIST");
                                if (report1List != null && !report1List.isEmpty()) {
                                    for (ReportDTO s : report1List) {
                                        String statusClass = "status status-" + (s.getStatus() != null ? s.getStatus().toLowerCase().replace(" ", "") : "pending");
                            %>
                            <tr>
                                <td data-label="Ngày Dịch Vụ"><%= s.getServiceDate() %></td>
                                <td data-label="Tên Khách"><%= s.getGuestName() %></td>
                                <td data-label="Số Phòng"><%= s.getRoomNumber() %></td>
                                <td data-label="Tên Dịch Vụ"><%= s.getServiceName() %></td>
                                <td data-label="Số Lượng"><%= s.getQuantity() %></td>
                                <td data-label="Trạng Thái">
                                    <span class="<%= statusClass %>"><%= s.getStatus() != null ? s.getStatus() : "Pending" %></span>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr><td colspan="6" class="no-data">Không có dữ liệu</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>
            
            <!-- Report 2 Content -->
            <div id="report2" class="report-content <%= ("report2".equals(showReport) || "all".equals(showReport)) ? "active" : "" %>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <%
                    if ("report2".equals(showReport) || "all".equals(showReport) || hasReport2) {
                %>
                <div class="card">
                    <h3>Báo Cáo Dịch Vụ Được Yêu Cầu - Report 2</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Tên Khách</th>
                                <th>Số Phòng</th>
                                <th>Tên Dịch Vụ</th>
                                <th>Số Lượng</th>
                                <th>Nhân Viên Phụ Trách</th>
                                <th>Thời Gian Yêu Cầu</th>
                                <th>Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<ReportDTO> report2List = (List<ReportDTO>) request.getAttribute("REPORT_2_LIST");
                                if (report2List != null && !report2List.isEmpty()) {
                                    for (ReportDTO s : report2List) {
                            %>
                            <tr>
                                <td data-label="Tên Khách"><%= s.getGuestName() %></td>
                                <td data-label="Số Phòng"><%= s.getRoomNumber() %></td>
                                <td data-label="Tên Dịch Vụ"><%= s.getServiceName() %></td>
                                <td data-label="Số Lượng"><%= s.getQuantity() %></td>
                                <td data-label="Nhân Viên Phụ Trách">
                                    <%= s.getAssignedStaff() != null ? s.getAssignedStaff() : "Chưa phân công" %>
                                </td>
                                <td data-label="Thời Gian Yêu Cầu"><%= s.getRequestTime() %> phút</td>
                                <td data-label="Trạng Thái">
                                    <span class="status status-pending">Pending</span>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr><td colspan="7" class="no-data">Không có dữ liệu</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>
                    
            <!-- Report 3 Content -->
            <div id="report3" class="report-content <%= ("report3".equals(showReport) || "all".equals(showReport)) ? "active" : "" %>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <%
                    if ("report3".equals(showReport) || "all".equals(showReport) || hasReport3) {
                %>
                <div class="card">
                    <h3>Báo Cáo Dịch Vụ Hoàn Thành - Report 3</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Tên Nhân Viên</th>
                                <th>Tên Dịch Vụ</th>
                                <th>Tổng Hoàn Thành</th>
                                <th>Ngày</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<ReportDTO> report3List = (List<ReportDTO>) request.getAttribute("REPORT_3_LIST");
                                if (report3List != null && !report3List.isEmpty()) {
                                    for (ReportDTO s : report3List) {
                            %>
                            <tr>
                                <td data-label="Tên Nhân Viên"><%= s.getStaffName() %></td>
                                <td data-label="Tên Dịch Vụ"><%= s.getServiceName() %></td>
                                <td data-label="Tổng Hoàn Thành"><%= s.getTotalComplete() %></td>
                                <td data-label="Ngày"><%= s.getServiceDate() %></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr><td colspan="4" class="no-data">Không có dữ liệu</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>
            
            <!-- Report 4 Filter/Form -->
            <div id="report4-form" class="report-content <%= ("report4".equals(showReport) || hasReport4) ? "active" : "" %>">
                <%
                    if (!hasReport4 || "report4".equals(showReport)) {
                %>
                <div class="card">
                    <h3>Báo Cáo Doanh Thu Theo Ngày - Report 4</h3>
                    <form id="report4FilterForm" action="ReportMainController" method="POST" class="filter-form">
                        <input type="hidden" name="action" value="report4" />
                        <label for="serviceDate">Chọn ngày:</label>
                        <input type="date" id="serviceDate" name="serviceDate"
                               value="<%= request.getAttribute("REPORT_4_DATE") != null ? request.getAttribute("REPORT_4_DATE") : "" %>"
                               required />
                        <button class="report-btn" type="submit">Tải Báo Cáo</button>
                    </form>
                </div>
                <%
                    }
                %>
            </div>

            <!-- Report 4 Content -->
            <div id="report4" class="report-content <%= ("report4".equals(showReport)) ? "active" : "" %>">
                <%
                    if ("report4".equals(showReport) && hasReport4) {
                %>
                <div class="card">
                    <h3>Báo Cáo Doanh Thu Theo Ngày - Report 4</h3>
                    <%
                        if (request.getAttribute("REPORT_4_DATE") != null) {
                    %>
                    <p><strong>Ngày được chọn:</strong> <%= request.getAttribute("REPORT_4_DATE") %></p>
                    <%
                        }
                    %>
                    <table>
                        <thead>
                            <tr>
                                <th>Tên Dịch Vụ</th>
                                <th>Số Lượng</th>
                                <th>Tổng Doanh Thu</th>
                                <th>Ngày</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<ReportDTO> report4List = (List<ReportDTO>) request.getAttribute("REPORT_4_LIST");
                                if (report4List != null && !report4List.isEmpty()) {
                                    double totalRevenue = 0;
                                    for (ReportDTO s : report4List) {
                                        totalRevenue += s.getTotalRevenue();
                            %>
                            <tr>
                                <td data-label="Tên Dịch Vụ"><%= s.getServiceName() %></td>
                                <td data-label="Số Lượng"><%= s.getQuantity() %></td>
                                <td data-label="Tổng Doanh Thu"><%= String.format("%,.0f VND", s.getTotalRevenue()).replace(',', '.') %></td>
                                <td data-label="Ngày"><%= s.getPeriod() != null ? s.getPeriod() : s.getServiceDate() %></td>
                            </tr>
                            <%
                                    }
                            %>
                            <tr style="background-color: #e9ecef; font-weight: bold;">
                                <td colspan="2" style="text-align: right;">Tổng doanh thu:</td>
                                <td style="color: #004a99; font-size: 1.1rem;"><%= String.format("%,.0f VND", totalRevenue).replace(',', '.') %></td>
                                <td></td>
                            </tr>
                            <%
                                } else {
                            %>
                            <tr><td colspan="4" class="no-data">Không có dữ liệu</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>
            
            <!-- Action Buttons -->
            <div class="card">
                <div class="action-buttons">
                    <button class="back-btn" onclick="window.location.href='MainController?action=<%=IConstants.AC_VIEW_REPORT_PAGE%>'">Đặt lại Báo Cáo</button>
                    <button class="back-btn" onclick="window.location.href='MainController?action=getroomservice'">Quay lại</button>
                </div>
            </div>
        </div>
        
        <script>
            const SECTION_IDS = ['report1','report2','report3','report4','report4-form'];
    
            function showOnly(id) {
                SECTION_IDS.forEach(sec => {
                    const el = document.getElementById(sec);
                    if (el) el.classList.remove('active');
                });
                const target = document.getElementById(id);
                if (target) target.classList.add('active');
            }
            
            function loadReport4() {
                showOnly('report4-form');
                const input = document.getElementById('serviceDate');
                if (input) input.focus();
            }
            
            function showAllReports() {
                window.location.href = 'ReportMainController?action=manaReport';
            }
        </script>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
