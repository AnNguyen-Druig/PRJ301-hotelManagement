<%-- 
    Document   : reportmainpage
    Created on : Oct 22, 2025, 11:50:29 PM
    Author     : Nguyễn Đại
--%>

<%@page import="java.util.List"%>
<%@page import="DTO.Report_DTO.ReportDTO"%>
<%@page import="mylib.IConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report View Page</title>
        <style>
            body { 
                font-family: Arial, sans-serif; 
                margin: 20px; 
                background-color: #f5f5f5;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .header {
                text-align: center;
                margin-bottom: 30px;
                color: #333;
            }
            .button-container {
                display: flex;
                gap: 15px;
                justify-content: center;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }
            .report-btn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            .report-btn:hover {
                background-color: #0056b3;
            }
            .report-btn.active {
                background-color: #28a745;
            }
            .report-content {
                display: none;
                margin-top: 20px;
            }
            .report-content.active {
                display: block;
            }
            table { 
                border-collapse: collapse; 
                width: 100%; 
                margin-top: 20px;
            }
            th, td { 
                border: 1px solid #ddd; 
                padding: 12px; 
                text-align: left;
            }
            th { 
                background: #f8f9fa; 
                font-weight: bold;
                color: #495057;
            }
            tr:nth-child(even) {
                background-color: #f8f9fa;
            }
            .msg { 
                margin: 10px 0; 
                color: #dc3545; 
                padding: 10px;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                border-radius: 4px;
            }
                .no-data {
                text-align: center;
                color: #6c757d;
                font-style: italic;
                padding: 20px;
            }
            .report-side-by-side {
                display: flex;
                gap: 20px;
                margin-top: 20px;
            }
            .report-side-by-side .report-content {
                flex: 1;
                display: block !important;
            }
            .back-btn {
                background-color: #6c757d;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                margin-top: 20px;
            }
            .back-btn:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="STAFF" scope="session" class="DTO.Basic_DTO.StaffDTO" />
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <div class="container">
            <div class="header">
                <h1>Hello, ${STAFF.fullName} - Report Dashboard</h1>
                <p>Chọn báo cáo để xem chi tiết</p>
            </div>
            
            <div class="button-container">
                <button class="report-btn" type="button" onclick="window.location.href='ReportMainController?action=report1'">Report 1</button>
                <button class="report-btn" type="button" onclick="window.location.href='ReportMainController?action=report2'">Report 2</button>
                <button class="report-btn" type="button" onclick="window.location.href='ReportMainController?action=report3'">Report 3</button>
                <button class="report-btn" type="button" onclick="loadReport4()">Report 4</button>
            </div>
            
            <%
                String error = (String) request.getAttribute("Error");
                if (error != null) {
            %>
                <div class="msg"><%= error %></div>
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
                if (showReport == null) {
                    if (hasReport1) showReport = "report1";
                    else if (hasReport2) showReport = "report2";
                    else if (hasReport3) showReport = "report3";
                    else if (hasReport4) showReport = "report4";
                }
            %>
            
            <!-- Report 1 Content -->
            <div id="report1" class="report-content <%= ("report1".equals(showReport) || "all".equals(showReport)) ? "active" : "" %>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <h3>Service History Report</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Service Date</th>
                            <th>Guest Name</th>
                            <th>Room Number</th>
                            <th>Service Name</th>
                            <th>Quantity</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<ReportDTO> report1List = (List<ReportDTO>) request.getAttribute("REPORT_1_LIST");
                        if (report1List != null && !report1List.isEmpty()) {
                            for (ReportDTO s : report1List) {
                    %>
                        <tr>
                            <td><%= s.getServiceDate() %></td>
                            <td><%= s.getGuestName() %></td>
                            <td><%= s.getRoomNumber() %></td>
                            <td><%= s.getServiceName() %></td>
                            <td><%= s.getQuantity() %></td>
                            <td><%= s.getStatus() %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="6" class="no-data">No data available</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            
            <!-- Report 2 Content -->
            <div id="report2" class="report-content <%= ("report2".equals(showReport) || "all".equals(showReport)) ? "active" : "" %>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <h3>Services Requested Report</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Guest Name</th>
                            <th>Room Number</th>
                            <th>Service Name</th>
                            <th>Quantity</th>
                            <th>Assigned Staff</th>
                            <th>Request Time</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<ReportDTO> report2List = (List<ReportDTO>) request.getAttribute("REPORT_2_LIST");
                        if (report2List != null && !report2List.isEmpty()) {
                            for (ReportDTO s : report2List) {
                    %>
                        <tr>
                            <td><%= s.getGuestName() %></td>
                            <td><%= s.getRoomNumber() %></td>
                            <td><%= s.getServiceName() %></td>
                            <td><%= s.getQuantity() %></td>
                            <td><%= s.getAssignedStaff() != null ? s.getAssignedStaff() : "Not Assigned" %></td>
                            <td><%= s.getRequestTime() %> minutes</td>
                            <td>Pending</td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="7" class="no-data">No completed services found</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
                    
            <!-- Report 3 Content -->
            <div id="report3" class="report-content <%= ("report3".equals(showReport) || "all".equals(showReport)) ? "active" : "" %>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
                <h3>Completed Services Report</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Staff Name</th>
                            <th>Service Name</th>
                            <th>Total Complete</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<ReportDTO> report3List = (List<ReportDTO>) request.getAttribute("REPORT_3_LIST");
                        if (report3List != null && !report3List.isEmpty()) {
                            for (ReportDTO s : report3List) {
                    %>
                        <tr>
                            <td><%= s.getStaffName() %></td>
                            <td><%= s.getServiceName() %></td>
                            <td><%= s.getTotalComplete() %></td>
                            <td><%= s.getServiceDate() %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="4" class="no-data">No completed services found</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            
            <!-- Report 4 Filter/Form -->
            <div id="report4-form" class="report-content <%= ("report4".equals(showReport) || hasReport4) ? "active" : "" %>">
                <h3>Revenue by Date</h3>
                <form id="report4FilterForm" action="ReportMainController" method="POST"
                      style="display:flex; align-items:center; gap:10px; flex-wrap:wrap;">
                    <input type="hidden" name="action" value="report4" />
                    <label for="serviceDate">Choose date:</label>
                    <input type="date" id="serviceDate" name="serviceDate"
                           value="<%= request.getAttribute("REPORT_4_DATE") != null ? request.getAttribute("REPORT_4_DATE") : "" %>"
                           required />
                    <button class="report-btn" type="submit">Load Report 4</button>
                </form>
            </div>

            <!-- Report 4 Content -->
            <div id="report4" class="report-content <%= ("report4".equals(showReport)) ? "active" : "" %>">
                <table>
                    <thead>
                        <tr>
                            <th>Service Name</th>
                            <th>Quantity</th>
                            <th>Total Revenue</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        List<ReportDTO> report4List = (List<ReportDTO>) request.getAttribute("REPORT_4_LIST");
                        if (report4List != null && !report4List.isEmpty()) {
                            for (ReportDTO s : report4List) {
                    %>
                        <tr>
                            <td><%= s.getServiceName() %></td>
                            <td><%= s.getQuantity() %></td>
                            <td><%= String.format("%,.0f VND", s.getTotalRevenue()).replace(',', '.') %></td>
                            <td><%= s.getPeriod() %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="4" class="no-data">No data available</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            
            <div style="text-align: center; margin-top: 30px;">
                <button class="back-btn" onclick="window.location.href='MainController?action=<%=IConstants.AC_VIEW_REPORT_PAGE%>'">Reset Reports</button>
                <button class="back-btn" onclick="window.location.href='MainController?action=getroomservice'">Go Back</button>
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
