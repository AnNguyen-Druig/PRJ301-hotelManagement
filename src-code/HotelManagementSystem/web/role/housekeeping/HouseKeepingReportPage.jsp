<%-- 
    Document   : HouseKeepingReportPage
    Created on : Oct 28, 2025, 9:33:38 AM
    Author     : Nguyễn Đại
--%>

<%@page import="DTO.Report_DTO.HouseKeepingReportDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report Page</title>
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
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <jsp:useBean id="STAFF" scope="session" class="DTO.Basic_DTO.StaffDTO" />
        <div class="header">
            <h1>Hello, ${STAFF.fullName} - Report Dashboard</h1>
            <p>Chọn báo cáo để xem chi tiết</p>
        </div>

        <div class="button-container">
            <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report1'">Report 1</button>
            <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report2'">Report 2</button>
            <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report3'">Report 3</button>
            <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report4'">Report 4</button>
            <button class="report-btn" type="button" onclick="window.location.href = 'HouseKeepingReportController?action=report5'">Report 5</button>
        </div>

        <%
            String error = (String) request.getAttribute("Error");
            if (error != null) {
        %>
        <div class="msg"><%= error%></div>
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
            <h3>Room Cleaning Report</h3>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Room Number</th>
                        <th>Cleaning Type</th>
                        <th>Staff Name</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<HouseKeepingReportDTO> report1List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_1_LIST");
                        if (report1List != null && !report1List.isEmpty()) {
                            for (HouseKeepingReportDTO s : report1List) {
                    %>
                    <tr>
                        <td><%= s.getDate()%></td>
                        <td><%= s.getRoomNumber()%></td>
                        <td><%= s.getCleaningType()%></td>
                        <td><%= s.getStaffName()%></td>
                        <td><%= s.getStatus()%></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="5" class="no-data">No data available</td></tr>
                    <% }%>
                </tbody>
            </table>
        </div>

        <!-- Report 2 Content -->
        <div id="report2" class="report-content <%= ("report2".equals(showReport) || "all".equals(showReport)) ? "active" : ""%>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
            <h3>Room Cleaning Report</h3>
            <table>
                <thead>
                    <tr>
                        <th>Room Number</th>
                        <th>Status</th>
                        <th>Priority</th>
                        <th>Assigned Staff</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<HouseKeepingReportDTO> report2List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_2_LIST");
                        if (report2List != null && !report2List.isEmpty()) {
                            for (HouseKeepingReportDTO s : report2List) {
                    %>
                    <tr>
                        <td><%= s.getRoomNumber()%></td>
                        <td><%= s.getStatus()%></td>
                        <td><%= s.getPriority()%></td>

                        <% if (s.getStaffName() != null) {
                        %> <td><%= s.getStaffName()%> </td><%
                        } else {
                        %>
                        <td>Unassigned</td>
                        <%
                                }%>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="4" class="no-data">No data available</td></tr>
                    <% }%>
                </tbody>
            </table>
        </div>


        <!-- Report 3 Content -->
        <div id="report3" class="report-content <%= ("report3".equals(showReport) || "all".equals(showReport)) ? "active" : ""%>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
            <h3>Room Cleaning Report</h3>
            <table>
                <thead>
                    <tr>
                        <th>Room Number</th>
                        <th>Room Type</th>
                        <th>Status</th>
                        <th>Last Cleaned Date</th>
                        <th>Next Check In</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<HouseKeepingReportDTO> report3List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_3_LIST");
                        if (report3List != null && !report3List.isEmpty()) {
                            for (HouseKeepingReportDTO s : report3List) {
                    %>
                    <tr>
                        <td><%= s.getRoomNumber()%></td>
                        <td><%= s.getRoomType()%></td>
                        <td><%= s.getStatus()%></td>
                        <td><%= s.getDate()%></td>
                        <td><%= s.getCheckIn()%></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="5" class="no-data">No data available</td></tr>
                    <% }%>
                </tbody>
            </table>
        </div>


        <!-- Report 4 Content -->
        <div id="report4" class="report-content <%= ("report4".equals(showReport) || "all".equals(showReport)) ? "active" : ""%>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
            <h3>Room Cleaning Report</h3>
            <table>
                <thead>
                    <tr>
                        <th>Room Number</th>
                        <th>Issue Description</th>
                        <th>Report Date</th>
                        <th>Status</th>
                        <th>Fixed By</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<HouseKeepingReportDTO> report4List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_4_LIST");
                        if (report4List != null && !report4List.isEmpty()) {
                            for (HouseKeepingReportDTO s : report4List) {
                    %>
                    <tr>
                        <td><%= s.getRoomNumber()%></td>
                        <td><%= s.getIssueDescription()%></td>
                        <td><%= s.getReportDate()%></td>
                        <td><%= s.getStatus()%></td>
                        <% if (s.getStaffName() != null) {
                        %> <td><%= s.getStaffName()%> </td><%
                        } else {
                        %>
                        <td>Unassigned</td>
                        <%
                                }%>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="5" class="no-data">No data available</td></tr>
                    <% }%>
                </tbody>
            </table>
        </div>


        <!-- Report 5 Content -->
        <div id="report5" class="report-content <%= ("report5".equals(showReport) || "all".equals(showReport)) ? "active" : ""%>" <% if ("all".equals(showReport)) { %>style="display: block;"<% } %>>
            <h3>Room Cleaning Report</h3>
            <table>
                <thead>
                    <tr>
                        <th>Staff Name</th>
                        <th>Rooms Cleaned</th>
                        <th>Deep Cleanings</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<HouseKeepingReportDTO> report5List = (List<HouseKeepingReportDTO>) request.getAttribute("REPORT_5_LIST");
                        if (report5List != null && !report5List.isEmpty()) {
                            for (HouseKeepingReportDTO s : report5List) {
                    %>
                    <tr>
                        <td><%= s.getStaffName()%></td>
                        <td><%= s.getRoomCleaned()%></td>
                        <td><%= s.getDeepCleanings()%></td>
                        <td><%= s.getDate()%></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="4" class="no-data">No data available</td></tr>
                    <% }%>
                </tbody>
            </table>
        </div>

        <a class="back" href="MainController?action=backtohousekeeping">⬅ Back to room</a>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
