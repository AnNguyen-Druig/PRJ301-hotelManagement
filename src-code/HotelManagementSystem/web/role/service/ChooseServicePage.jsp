<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="DTO.Basic_DTO.GuestDTO"%>
<%@page import="DTO.Basic_DTO.ServiceDTO"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Choose Services</title>
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
                background: linear-gradient(135deg, #28a745, #218838);
            }

            .btn-secondary:hover {
                background: linear-gradient(135deg, #218838, #1e7e34);
            }

            .btn-danger {
                background: linear-gradient(135deg, #dc3545, #c82333);
            }

            .btn-danger:hover {
                background: linear-gradient(135deg, #c82333, #bd2130);
            }

            .btn-info {
                background: linear-gradient(135deg, #17a2b8, #138496);
            }

            .btn-info:hover {
                background: linear-gradient(135deg, #138496, #117a8b);
            }

            /* === INPUT === */
            input[type=number] {
                padding: 0.5rem;
                border: 1.5px solid #ccc;
                border-radius: 8px;
                font-size: 0.9rem;
                width: 80px;
                text-align: center;
                transition: border 0.3s ease;
            }

            input[type=number]:focus {
                outline: none;
                border-color: #004a99;
                box-shadow: 0 0 0 3px rgba(0, 74, 153, 0.15);
            }

            /* === TOTAL === */
            .total {
                text-align: right;
                font-weight: bold;
                color: #004a99;
                font-size: 1.1rem;
            }

            tfoot td {
                background-color: #f8fbff;
                font-weight: 600;
            }

            /* === THÔNG BÁO === */
            .message {
                color: #28a745;
                font-weight: 500;
                padding: 0.75rem 1rem;
                background: #d4edda;
                border-left: 4px solid #28a745;
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

            /* === ACTION BUTTONS === */
            .action-buttons {
                display: flex;
                gap: 0.5rem;
                justify-content: center;
                flex-wrap: wrap;
            }

            .action-buttons .btn {
                min-width: 120px;
            }

            /* === RESPONSIVE === */
            @media (max-width: 1024px) {
                .wrap {
                    flex-direction: column;
                }
            }

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
            GuestDTO guest = (GuestDTO) session.getAttribute("USER");
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (guest == null && staff == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
                String bookingID = request.getParameter("bookingId");
        %>

        <div class="dashboard-container">
            <!-- Header -->
            <div class="card">
                <h1>Chọn Dịch Vụ</h1>
                <p>Booking ID: <strong><%= bookingID%></strong></p>
            </div>

            <div class="wrap">
                <!-- Cột trái: tất cả dịch vụ -->
                <div class="col">
                    <div class="card">
                        <h3>Tất Cả Dịch Vụ</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên Dịch Vụ</th>
                                    <th>Loại</th>
                                    <th>Giá</th>
                                    <th>Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<ServiceDTO> list = (List<ServiceDTO>) request.getAttribute("ALLSERVICE");
                                    if (list != null && !list.isEmpty()) {
                                        for (ServiceDTO s : list) {
                                %>
                                <tr>
                                    <td data-label="ID"><%= s.getServiceId()%></td>
                                    <td data-label="Tên Dịch Vụ"><%= s.getServiceName()%></td>
                                    <td data-label="Loại"><%= s.getServiceType()%></td>
                                    <td data-label="Giá"><%= String.format("%,.0f VND", s.getPrice()).replace(',', '.')%></td>
                                    <td data-label="Thao Tác">
                                        <form action="MainController" style="display:inline">
                                            <input type="hidden" name="bookingId" value="<%= bookingID%>">
                                            <input type="hidden" name="ServiceID" value="<%=s.getServiceId()%>">
                                            <button type="submit" name="action" value="<%= IConstants.AC_ADD_SERVICE%>" class="btn btn-secondary">Thêm</button>
                                        </form>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr><td colspan="5" class="no-data">Chưa có dữ liệu dịch vụ</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Cột phải: dịch vụ đã thêm -->
                <div class="col">
                    <div class="card">
                        <h3>Dịch Vụ Đã Thêm</h3>
                        <%
                            String message = (String) request.getAttribute("SAVE_BOOKING_SERVICE");
                            if (message != null && !message.isEmpty()) {
                        %>
                        <div class="message"><%= message%></div>
                        <%
                            }
                        %>
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên Dịch Vụ</th>
                                    <th>Loại</th>
                                    <th>Số Lượng</th>
                                    <th>Giá</th>
                                    <th>Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    double GrandTotal = 0;
                                    String bookingId = (String) session.getAttribute("BOOKING_ID");
                                    String cartKey = "CART_" + bookingId;
                                    HashMap<ServiceDTO, Integer> cart = (HashMap) session.getAttribute(cartKey);
                                    if (cart == null || cart.isEmpty()) {
                                %>
                                <tr><td colspan="6" class="no-data">Chưa có dịch vụ nào</td></tr>
                                <%
                                    } else {
                                        double total = 0;
                                        for (ServiceDTO s : cart.keySet()) {
                                            total += cart.get(s) * s.getPrice();
                                %>
                                <tr>
                                    <form action="MainController" style="display:contents">
                                        <td data-label="ID"><%= s.getServiceId()%></td>
                                        <td data-label="Tên Dịch Vụ"><%= s.getServiceName()%></td>
                                        <td data-label="Loại"><%= s.getServiceType()%></td>
                                        <td data-label="Số Lượng">
                                            <input type="number" name="txtquantity" min="1" value="<%= cart.get(s)%>">
                                        </td>
                                        <td data-label="Giá"><%= String.format("%,.0f VND", s.getPrice()).replace(',', '.') %></td>
                                        <td data-label="Thao Tác">
                                            <div class="action-buttons">
                                                <input type="hidden" name="serviceid" value="<%= s.getServiceId()%>">
                                                <input type="hidden" name="bookingId" value="<%= bookingID%>">
                                                <button type="submit" name="action" value="<%= IConstants.AC_SAVE_BOOKING_SERVICE%>" class="btn btn-secondary">Đặt ngay</button>
                                                <button type="submit" name="action" value="<%= IConstants.AC_UPDATE_BOOKING_SERVICE%>" class="btn btn-info">Cập nhật</button>
                                                <button type="submit" name="action" value="<%= IConstants.AC_DELETE_BOOKING_SERVICE%>" class="btn btn-danger">Xóa</button>
                                            </div>
                                        </td>
                                    </form>
                                </tr>
                                <%
                                        }
                                        GrandTotal = total;
                                    }
                                %>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td class="total" colspan="5">Tổng cộng:</td>
                                    <td style="text-align:center; font-weight: bold; color: #004a99;">
                                        <%= String.format("%,.0f VND", GrandTotal).replace(',', '.')%>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Back Button -->
            <div class="card">
                <% if (staff != null) {
                %>
                <a class="back-btn" href="MainController?action=getroomservice">⬅ Quay lại danh sách phòng</a>
                <%
                } else {
                %>
                <form action="MainController" method="POST" style="display:inline">
                    <button type="submit" name="action" value="<%= IConstants.AC_GO_BACK_GUEST_PAGE%>" class="back-btn">⬅ Quay về trang Guest</button>
                </form>
                <%
                    }
                %>
            </div>
        </div>

        <%
            }
        %>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
