<%-- 
    Document   : Report1Page
    Created on : Oct 23, 2025, 12:46:45 PM
    Author     : Nguyễn Đại
--%>

<%@page import="java.util.List"%>
<%@page import="DTO.ReportDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report 1 Page</title>
        <style>
        body { font-family: Arial, sans-serif; margin: 16px; }
        .wrap { display: flex; gap: 24px; align-items: flex-start; }
        .col { flex: 1; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background: #f5f5f5; }
        .total { text-align: right; font-weight: bold; }
        .msg { margin: 8px 0; color: #c00; }
        .header { margin-bottom: 12px; }
        input[type=number] { width: 64px; }
        .back { margin-top: 16px; display: inline-block; }
      </style>
    </head>
    <body>
        <jsp:useBean id="USER" scope="session" class="DTO.StaffDTO" />
        <h1>Hello, ${USER.fullName} welcome to report 1</h1>
        
        <%
            String error = (String) request.getAttribute("Error");
            if (error != null) {
        %>
            <div class="msg"><%= error %></div>
        <%
            }
        %>
        <div class="col">
    <h3>Report</h3>
    <table>
      <thead>
        <tr>
            <th>ServiceDate </th><th>GuestName</th><th>RoomNumber</th><th>ServiceName</th><th>Quantity</th><th>Status</th>
        </tr>
      </thead>
      <tbody>
      <%
        List<ReportDTO> list = (List<ReportDTO>) request.getAttribute("REPORT_1_LIST");
        if (list != null && !list.isEmpty()) {
            for (ReportDTO s : list) {
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
        <tr><td colspan="6" style="text-align:center">No data report</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>
    </body>
</html>
