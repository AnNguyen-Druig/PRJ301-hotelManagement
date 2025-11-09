<%-- 
    Document   : housekeeping
    Created on : Oct 2, 2025, 3:19:26 PM
    Author     : Admin
--%>

<%@page import="DTO.HouseKeeping_DTO.GetRoomForHouseKeepingDTO"%>
<%@page import="DAO.HouseKeepingDAO.GetRoomForHouseKeepingDAO"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Housekeeping Dashboard</title>
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

            /* === BẢNG PHÒNG === */
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

            .status-available {
                background-color: #d4edda;
                color: #155724;
            }
            .status-dirty {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-maintenance {
                background-color: #f8d7da;
                color: #721c24;
            }
            .status-occupied {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            /* === FORM CẬP NHẬT TRẠNG THÁI === */
            .status-update-form {
                display: flex;
                gap: 0.5rem;
                align-items: center;
                justify-content: center;
            }

            .status-update-form select {
                padding: 0.5rem 0.75rem;
                border: 1.5px solid #ccc;
                border-radius: 8px;
                font-size: 0.9rem;
                background-color: white;
                min-width: 140px;
                cursor: pointer;
                transition: border 0.3s ease;
            }

            .status-update-form select:focus {
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
                min-width: 80px;
            }

            .btn:hover {
                background: linear-gradient(135deg, #003366, #002244);
            }

            .btn-secondary {
                background: linear-gradient(135deg, #6c757d, #5a6268);
            }

            .btn-secondary:hover {
                background: linear-gradient(135deg, #5a6268, #484f54);
            }

            /* === THÔNG BÁO LỖI === */
            .error-message {
                color: #e74c3c;
                font-weight: 500;
                padding: 0.75rem 1rem;
                background: #fdf2f2;
                border-left: 4px solid #e74c3c;
                border-radius: 5px;
                margin: 1rem 0;
            }

            /* === THÔNG BÁO KHÔNG CÓ DỮ LIỆU === */
            .no-data {
                text-align: center;
                padding: 2rem;
                color: #6c757d;
                font-style: italic;
                background: #f8f9fa;
                border-radius: 10px;
                margin: 1rem 0;
            }

            /* === ACTION BUTTONS === */
            .action-buttons {
                display: flex;
                gap: 1rem;
                justify-content: center;
                margin-top: 0;
                flex-wrap: wrap;
            }

            .action-buttons .btn {
                min-width: 180px;
                padding: 0.75rem 1.5rem;
            }

            footer h2, footer h3, footer h4 {
                color: #fff !important;
                font-weight: 600;
            }

            /* === RESPONSIVE === */
            @media (max-width: 768px) {
                .status-update-form {
                    flex-direction: column;
                }

                .status-update-form select,
                .status-update-form .btn {
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
                if (staff != null) {
            %>
        <div class="dashboard-container">
            <!-- Chào mừng -->
            <div class="card">
                <h1>Xin chào, <%= staff.getFullName() %> (Nhân viên buồng phòng)</h1>
                <p><a href="MainController?action=logout">Đăng xuất</a></p>
            </div>

            <!-- Action Buttons -->
            <div class="card">
                <div class="action-buttons">
                    <button class="btn btn-secondary" onclick="window.location.href='MainController?action=pendingpage'">
                        Đến trang dọn dẹp
                    </button>
                    <button class="btn btn-secondary" onclick="window.location.href='MainController?action=housereport'">
                        Đến trang báo cáo
                    </button>
                </div>
            </div>

            <!-- Quản lý phòng -->
            <div class="card">
                <h3>Quản Lý Phòng</h3>

            <%-- Hiển thị thông báo lỗi nếu có --%>
            <%
                String error = (String) request.getAttribute("ERROR");
                if (error != null) {
            %>
                <div class="error-message"><%= error %></div>
            <%
                }
            %>

                <%
                    List<GetRoomForHouseKeepingDTO> list = (List<GetRoomForHouseKeepingDTO>) request.getAttribute("ROOM_LIST");
                    if (list != null && !list.isEmpty()) {
                %>
                <table>
                <thead>
                    <tr>
                        <th>Số Phòng</th>
                        <th>Loại Phòng</th>
                        <th>Trạng Thái</th>
                        <th>Cập Nhật Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                            for (GetRoomForHouseKeepingDTO room : list) {
                                String statusClass = "status status-" + room.getStatus().toLowerCase();
                    %>
                    <tr>
                            <td data-label="Số Phòng"><%= room.getRoomNumber() %></td>
                            <td data-label="Loại Phòng"><%= room.getTypeName() %></td>
                            <td data-label="Trạng Thái">
                                <span class="<%= statusClass %>"><%= room.getStatus() %></span>
                            </td>
                            <td data-label="Cập Nhật Trạng Thái">
                                <form action="MainController" method="POST" class="status-update-form">
                                <input type="hidden" name="roomId" value="<%= room.getRoomID() %>" />
                                <select name="newStatus">
                                    <option value="Available" <% if ("Available".equals(room.getStatus())) out.print("selected"); %>>Available</option>
                                    <option value="Dirty" <% if ("Dirty".equals(room.getStatus())) out.print("selected"); %>>Dirty</option>
                                    <option value="Maintenance" <% if ("Maintenance".equals(room.getStatus())) out.print("selected"); %>>Maintenance</option>
                                    <option value="Occupied" <% if ("Occupied".equals(room.getStatus())) out.print("selected"); %>>Occupied</option>
                                </select>
                                    <button type="submit" name="action" value="perform_room_update" class="btn">Cập nhật</button>
                            </form>
                        </td>
                        </tr>
                    <%
                            } // end for
                        %>
                    </tbody>
                </table>
                <%
                        } else {
                %>
                <p class="no-data">Không có thông tin phòng.</p>
                <%
                        }
                    %>
                        </div>
                        </div>    

        <%
            } else {
                // Nếu chưa đăng nhập, chuyển về trang login
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            }
        %>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
