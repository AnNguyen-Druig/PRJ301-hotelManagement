<%-- 
    Document   : reportmainpage
    Created on : Oct 22, 2025, 11:50:29 PM
    Author     : Nguyễn Đại
--%>

<%@page import="java.util.List"%>
<%@page import="DTO.ReportDTO"%>
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
        <div class="container">
            <jsp:useBean id="USER" scope="session" class="DTO.StaffDTO" />
            <div class="header">
                <h1>Hello, ${USER.fullName} - Report Dashboard</h1>
                <p>Chọn báo cáo để xem chi tiết</p>
            </div>
            
            <div class="button-container">
                <button class="report-btn" onclick="loadReport1()">Report 1 - Service History</button>
                <button class="report-btn" onclick="loadReport2()">Report 2 - Services requested</button>
                <button class="report-btn" onclick="loadReport3()">Report 3 - Completed Services</button>
                <button class="report-btn" onclick="loadAllReports()">Load All Reports</button>
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
                // Determine which report to show
                String showReport = (String) request.getAttribute("SHOW_REPORT");
                boolean hasReport1 = request.getAttribute("REPORT_1_LIST") != null;
                boolean hasReport2 = request.getAttribute("REPORT_2_LIST") != null;
                boolean hasReport3 = request.getAttribute("REPORT_3_LIST") != null;
                boolean showReport1 = false;
                boolean showReport2 = false;
                boolean showReport3 = false;
                
                if (showReport != null) {
                    if ("report1".equals(showReport)) showReport1 = true;
                    else if ("report2".equals(showReport)) showReport2 = true;
                    else if ("report3".equals(showReport)) showReport3 = true;
                    else if ("all".equals(showReport)) {
                        showReport1 = hasReport1;
                        showReport2 = hasReport2;
                        showReport3 = hasReport3;
                    }
                } else {
                    // Default behavior: show the first available report
                    if (hasReport1) showReport1 = true;
                    else if (hasReport2) showReport2 = true;
                    else if (hasReport3) showReport3 = true;
                }
            %>
            
            <!-- Report 1 Content -->
            <div id="report1" class="report-content <% if (showReport1) { %>active<% } %>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
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
            <div id="report2" class="report-content <% if (showReport2) { %>active<% } %>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
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
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="6" class="no-data">No completed services found</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
                    
            <!-- Report 3 Content -->
            <div id="report3" class="report-content <% if (showReport3) { %>active<% } %>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
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
            
            <div style="text-align: center; margin-top: 30px;">
                <button class="back-btn" onclick="window.location.href='MainController?action=<%=IConstants.AC_VIEW_REPORT_PAGE%>'">Reset Reports</button>
                <button class="back-btn" onclick="window.location.href='MainController?action=gobackmanager'">Go Back</button>
            </div>
        </div>
        
        <script>
            function loadReport1() {
                // Redirect to load Report 1 data
                window.location.href = 'GetReportController';
            }
            
            function loadReport2() {
                // Redirect to load Report 2 data
                window.location.href = 'GetReport2Controller';
            }
            
            function loadReport3() {
                // Redirect to load Report 2 data
                window.location.href = 'GetReport3Controller';
            }
            
            function loadAllReports() {
                // Redirect to load all reports
                window.location.href = 'GetAllReportsController';
            }
        </script>
    </body>
</html>
