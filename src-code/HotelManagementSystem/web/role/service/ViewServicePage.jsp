<%-- 
    Document   : ViewServicePage
    Created on : Oct 26, 2025, 4:44:20 PM
    Author     : Nguyễn Đại
--%>

<%@page import="mylib.IConstants"%>
<%@page import="DTO.Basic_DTO.BookingServiceDTO"%>
<%@page import="DTO.Basic_DTO.ServiceDTO"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Service</title>
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
            .status-canceled {
                background-color: #f8d7da;
                color: #721c24;
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

            /* === ACTION BUTTONS === */
            .action-buttons {
                display: flex;
                gap: 0.5rem;
                justify-content: center;
                flex-wrap: wrap;
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

            /* === FORM STYLING === */
            form {
                margin: 0;
            }

            /* === RESPONSIVE === */
            @media (max-width: 768px) {
                .action-buttons {
                    flex-direction: column;
                }

                .action-buttons .btn {
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
                <h1>Xin chào, <%= staff.getFullName() %></h1>
                <h2>Dịch Vụ Booking ${BOOKING_ID}</h2>
            </div>

            <%
                List<BookingServiceDTO> list = (List<BookingServiceDTO>) request.getAttribute("BOOKING_SERVICES");
                Map<Integer, ServiceDTO> serviceMap = (Map<Integer, ServiceDTO>) request.getAttribute("SERVICE_MAP");
                String err = (String) request.getAttribute("ERROR");
                if (err != null) {
            %>
            <div class="card">
                <div class="error-message"><%= err%></div>
            </div>
            <%
                }
            %>

            <!-- Service List -->
            <div class="card">
                <h3>Danh Sách Dịch Vụ</h3>
                <%
                    if (list != null && !list.isEmpty()) {
                %>
                <table>
                    <thead>
                        <tr>
                            <th>BookingService ID</th>
                            <th>Service ID</th>
                            <th>Tên Dịch Vụ</th>
                            <th>Ngày Dịch Vụ</th>
                            <th>Trạng Thái</th>
                            <th>Nhân Viên Phụ Trách</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (BookingServiceDTO bs : list) {
                                ServiceDTO s = (serviceMap != null) ? serviceMap.get(bs.getServiceID()) : null;
                                String sName = (s != null) ? s.getServiceName() : ("ServiceID " + bs.getServiceID());
                                String statusClass = "status status-" + bs.getStatus().toLowerCase().replace(" ", "");
                        %>
                        <tr>
                            <td data-label="BookingService ID"><%= bs.getBookingServiceID()%></td>
                            <td data-label="Service ID"><%= bs.getServiceID()%></td>
                            <td data-label="Tên Dịch Vụ"><%= sName%></td>
                            <td data-label="Ngày Dịch Vụ"><%= bs.getServiceDate()%></td>
                            <td data-label="Trạng Thái">
                                <span class="<%= statusClass %>"><%= bs.getStatus()%></span>
                            </td>
                            
                            <td data-label="Nhân Viên Phụ Trách"><%= bs.getAssignedStaff() %></td>
                            <td data-label="Thao Tác">
                                <form action="MainController" method="POST" class="action-buttons">
                                    <input type="hidden" name="action" value="update_service_status">
                                    <input type="hidden" name="bookingServiceId" value="<%= bs.getBookingServiceID()%>" />
                                    <input type="hidden" name="bookingId" value="<%= bs.getBookingID()%>" />
                                    <button type="submit" name="newStatus" value="Completed" class="btn btn-success">Hoàn thành</button>
                                    <button type="submit" name="newStatus" value="Canceled" class="btn btn-danger">Hủy</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <%
                    } else {
                %>
                <p class="no-data">Chưa có dịch vụ nào cho booking này.</p>
                <%
                    }
                %>
            </div>

            <!-- Back Button -->
            <div class="card">
                <a class="back-btn" href="MainController?action=getroomservice">⬅ Quay lại danh sách phòng</a>
            </div>
        </div>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
