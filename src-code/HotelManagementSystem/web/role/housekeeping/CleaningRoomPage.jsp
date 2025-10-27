<%-- 
    Document   : CleaningRoomPage
    Created on : Oct 27, 2025, 12:52:27 AM
    Author     : Nguyễn Đại
--%>

<%@page import="java.util.HashMap"%>
<%@page import="DTO.ServiceDTO"%>
<%@page import="DTO.HouseKeepingTaskDTO"%>
<%@page import="DTO.StaffDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.List"%>
<%@page import="DTO.RoomDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cleaning Page</title>
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
        <!-- Display success/error messages -->
        <% if (request.getAttribute("SUCCESS") != null) { %>
            <div style="color: green; margin: 10px 0; padding: 10px; background-color: #d4edda; border: 1px solid #c3e6cb; border-radius: 4px;">
                <%= request.getAttribute("SUCCESS") %>
            </div>
        <% } %>
        <% if (request.getAttribute("ERROR") != null) { %>
            <div style="color: red; margin: 10px 0; padding: 10px; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 4px;">
                <%= request.getAttribute("ERROR") %>
            </div>
        <% } %>
        
        <div class="wrap">
  <!-- Cột trái: tất cả phòng pending -->
  <div class="col">
        <table>
            <h3>Pending Table</h3>
          <thead>
            <tr>
                <th>TaskID</th><th>RoomID</th><th>AssignedStaff</th><th>TaskDate</th><th>cleaningType</th><th>status</th><th>Action</th>
            </tr>
          </thead>
          <tbody>
          <%
            StaffDTO staff = (StaffDTO) session.getAttribute("USER");
            if (staff != null) {
                List<HouseKeepingTaskDTO> list = (List<HouseKeepingTaskDTO>) request.getAttribute("PENDING");
                if (list != null && !list.isEmpty()) {
                    for (HouseKeepingTaskDTO s : list) {
          %>
          

            <tr>
              <td><%= s.getTaskID() %></td>
              <td><%= s.getRoomID() %></td>
              <td><%= s.getAssignedStaff() %></td>
              <td><%= s.getTaskDate() %></td>
              <td><%= s.getCleaningType() %></td>
              <td><%= s.getStatus() %></td>
              <td>
                  <form action="MainController" method="POST" style="justify-content: center; display: flex; gap: 8px; align-items: center;">
                        <input type="hidden" name="action" value="update_task_status">
                        <input type="hidden" name="TaskID" value="<%= s.getTaskID() %>">
                        <button type="submit" name="newStatus" value="InProgress">Accept</button>
                  </form>
              </td>
            </tr>
          <%
                    }
                } else {
          %>
            <tr><td colspan="7" style="text-align:center">No data</td></tr>
          <% 
                }
            } else {
          %>
            <tr><td colspan="7" style="text-align:center">Please login to view tasks</td></tr>
          <% } %>
          </tbody>
        </table>
      </div>

      <!-- Cột phải: Room Inprocess -->
      <div class="col">

        <h3>Progress Table</h3>
        <table>
          <thead>
            <th>TaskID</th><th>RoomID</th><th>AssignedStaff</th><th>TaskDate</th><th>cleaningType</th><th>status</th><th>Action</th>
          </thead>
          <tbody>

            <%
            if (staff != null) {
                List<HouseKeepingTaskDTO> list2 = (List<HouseKeepingTaskDTO>) request.getAttribute("PROGRESS");
                if (list2 != null && !list2.isEmpty()) {
                    for (HouseKeepingTaskDTO s2 : list2) {
            %>
            <tr>
              <td><%= s2.getTaskID() %></td>
              <td><%= s2.getRoomID() %></td>
              <td><%= s2.getAssignedStaff() %></td>
              <td><%= s2.getTaskDate() %></td>
              <td><%= s2.getCleaningType() %></td>
              <td><%= s2.getStatus() %></td>
              <td>
                  <form action="MainController" method="POST" style="justify-content: center; display: flex; gap: 8px; align-items: center;">
                        <input type="hidden" name="action" value="update_task_status">
                        <input type="hidden" name="TaskID" value="<%= s2.getTaskID() %>">
                        <input type="hidden" name="RoomID" value="<%= s2.getRoomID() %>">
                        <button type="submit" name="newStatus" value="Completed">Completed</button>
                        <button type="submit" name="newStatus" value="Canceled">Canceled</button>
                  </form>
              </td>
            </tr>
                <%
                  }
              }else{
              %>
            <tr><td colspan="7" style="text-align:center">None</td></tr>
            <%
            }
        }
            %>
          </tbody>  
        </table>
      </div>
    </div>

        <a class="back" href="MainController?action=backtohousekeeping">⬅ Back to room</a>
    </body>
</html>
