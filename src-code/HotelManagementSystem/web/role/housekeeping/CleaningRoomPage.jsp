<%-- 
    Document   : CleaningRoomPage
    Created on : Oct 27, 2025, 12:52:27 AM
    Author     : Nguyễn Đại
--%>

<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="DTO.Basic_DTO.HouseKeepingTaskDTO"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="DTO.Basic_DTO.ServiceDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cleaning Page</title>
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
                max-width: 1400px;
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

            /* === LAYOUT 2 CỘT === */
            .wrap {
                display: flex;
                gap: 2rem;
                align-items: flex-start;
            }

            .col {
                flex: 1;
                min-width: 0;
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
            .status-inprogress {
                background-color: #d1ecf1;
                color: #0c5460;
            }
            .status-completed {
                background-color: #d4edda;
                color: #155724;
            }

            /* === FORM === */
            .task-form {
                display: flex;
                gap: 0.5rem;
                align-items: center;
                justify-content: center;
                flex-wrap: wrap;
            }

            .task-form select {
                padding: 0.5rem 0.75rem;
                border: 1.5px solid #ccc;
                border-radius: 8px;
                font-size: 0.9rem;
                background-color: white;
                min-width: 140px;
                cursor: pointer;
                transition: border 0.3s ease;
            }

            .task-form select:focus {
                outline: none;
                border-color: #004a99;
                box-shadow: 0 0 0 3px rgba(0, 74, 153, 0.15);
            }

            /* === NÚT === */
            .btn {
                background: linear-gradient(135deg, #004a99, #003366);
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-size: 0.9rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 100px;
            }

            .btn:hover {
                background: linear-gradient(135deg, #003366, #002244);
            }

            .btn-success {
                background: linear-gradient(135deg, #28a745, #218838);
            }

            .btn-success:hover {
                background: linear-gradient(135deg, #218838, #1e7e34);
            }

            .btn-danger {
                background: linear-gradient(135deg, #dc3545, #c82333);
            }

            .btn-danger:hover {
                background: linear-gradient(135deg, #c82333, #bd2130);
            }

            /* === THÔNG BÁO === */
            .success-message {
                color: #28a745;
                font-weight: 500;
                padding: 0.75rem 1rem;
                background: #d4edda;
                border-left: 4px solid #28a745;
                border-radius: 5px;
                margin: 1rem 0;
            }

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
            @media (max-width: 1024px) {
                .wrap {
                    flex-direction: column;
                }
            }

            @media (max-width: 768px) {
                .task-form {
                    flex-direction: column;
                }

                .task-form select,
                .task-form .btn {
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
                <h1>Xin chào, <%= staff.getFullName() %> - Trang Dọn Dẹp</h1>
            </div>

            <!-- Display success/error messages -->
            <% if (request.getAttribute("SUCCESS") != null) { %>
            <div class="card">
                <div class="success-message">
                    <%= request.getAttribute("SUCCESS") %>
                </div>
            </div>
            <% } %>
            <% if (request.getAttribute("ERROR") != null) { %>
            <div class="card">
                <div class="error-message">
                    <%= request.getAttribute("ERROR") %>
                </div>
            </div>
            <% } %>

            <div class="wrap">
                <!-- Cột trái: Pending Tasks -->
                <div class="col">
                    <div class="card">
                        <h3>Danh Sách Công Việc Chờ</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Task ID</th>
                                    <th>Room ID</th>
                                    <th>Nhân Viên</th>
                                    <th>Ngày</th>
                                    <th>Trạng Thái</th>
                                    <th>Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<HouseKeepingTaskDTO> list = (List<HouseKeepingTaskDTO>) request.getAttribute("PENDING");
                                    if (list != null && !list.isEmpty()) {
                                        for (HouseKeepingTaskDTO s : list) {
                                            String statusClass = "status status-" + s.getStatus().toLowerCase().replace(" ", "");
                                %>
                                <tr>
                                    <td data-label="Task ID"><%= s.getTaskID() %></td>
                                    <td data-label="Room ID"><%= s.getRoomID() %></td>
                                    <td data-label="Nhân Viên">Chưa phân công</td>
                                    <td data-label="Ngày"><%= s.getTaskDate() %></td>
                                    <td data-label="Trạng Thái">
                                        <span class="<%= statusClass %>"><%= s.getStatus() %></span>
                                    </td>
                                    <td data-label="Thao Tác">
                                        <form action="MainController" method="POST" class="task-form">
                                            <input type="hidden" name="action" value="update_task_status">
                                            <input type="hidden" name="TaskID" value="<%= s.getTaskID() %>">
                                            <input type="hidden" name="StaffID" value="<%= staff.getStaffID() %>">
                                            <select name="newCleanType">
                                                <option value="Regular" <%= (s.getCleaningType() != null && s.getCleaningType().equals("Regular")) ? "selected" : "" %>>Thường</option>
                                                <option value="DeepCleaning" <%= (s.getCleaningType() != null && s.getCleaningType().equals("DeepCleaning")) ? "selected" : "" %>>Dọn sâu</option>
                                                <option value="PostCheckOut" <%= (s.getCleaningType() != null && s.getCleaningType().equals("PostCheckOut")) ? "selected" : "" %>>Sau Check-out</option>
                                            </select>
                                            <button type="submit" name="newStatus" value="InProgress" class="btn btn-success">Nhận việc</button>
                                        </form>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr><td colspan="6" class="no-data">Không có công việc nào</td></tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Cột phải: In Progress Tasks -->
                <div class="col">
                    <div class="card">
                        <h3>Danh Sách Công Việc Đang Làm</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Task ID</th>
                                    <th>Room ID</th>
                                    <th>Nhân Viên</th>
                                    <th>Ngày</th>
                                    <th>Loại Dọn Dẹp</th>
                                    <th>Trạng Thái</th>
                                    <th>Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<HouseKeepingTaskDTO> list2 = (List<HouseKeepingTaskDTO>) request.getAttribute("PROGRESS");
                                    if (list2 != null && !list2.isEmpty()) {
                                        for (HouseKeepingTaskDTO s2 : list2) {
                                            String statusClass2 = "status status-" + s2.getStatus().toLowerCase().replace(" ", "");
                                %>
                                <tr>
                                    <td data-label="Task ID"><%= s2.getTaskID() %></td>
                                    <td data-label="Room ID"><%= s2.getRoomID() %></td>
                                    <td data-label="Nhân Viên"><%= s2.getAssignedStaff() %></td>
                                    <td data-label="Ngày"><%= s2.getTaskDate() %></td>
                                    <td data-label="Loại Dọn Dẹp"><%= s2.getCleaningType() %></td>
                                    <td data-label="Trạng Thái">
                                        <span class="<%= statusClass2 %>"><%= s2.getStatus() %></span>
                                    </td>
                                    <td data-label="Thao Tác">
                                        <form action="MainController" method="POST" class="task-form">
                                            <input type="hidden" name="action" value="update_task_status">
                                            <input type="hidden" name="TaskID" value="<%= s2.getTaskID() %>">
                                            <input type="hidden" name="RoomID" value="<%= s2.getRoomID() %>">
                                            <input type="hidden" name="StaffID" value="<%= staff.getStaffID() %>">
                                            <input type="hidden" name="newCleanType" value="<%= s2.getCleaningType() %>">
                                            <button type="submit" name="newStatus" value="Completed" class="btn btn-success">Hoàn thành</button>
                                            <button type="submit" name="newStatus" value="Pending" class="btn btn-danger">Hủy</button>
                                        </form>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr><td colspan="7" class="no-data">Không có công việc nào</td></tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Back Button -->
            <div class="card">
                <a class="back-btn" href="MainController?action=backtohousekeeping">⬅ Quay lại trang quản lý phòng</a>
            </div>
        </div>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
