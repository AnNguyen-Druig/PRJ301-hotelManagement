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
            body {
                font-family: Arial, sans-serif;
                margin: 16px;
            }
            .wrap {
                display: flex;
                gap: 24px;
                align-items: flex-start;
            }
            .col {
                flex: 1;
            }
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
            }
            th {
                background: #f5f5f5;
            }
            .total {
                text-align: right;
                font-weight: bold;
            }
            .msg {
                margin: 8px 0;
                color: #c00;
            }
            .header {
                margin-bottom: 12px;
            }
            input[type=number] {
                width: 64px;
            }
            .back {
                margin-top: 16px;
                display: inline-block;
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

        <h2>Đây là bookingID lấy từ request <%= bookingID%></h2>
        <div class="wrap">
            <!-- Cột trái: tất cả dịch vụ -->
            <div class="col">
                <h3>Tất cả dịch vụ</h3>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th><th>Name</th><th>Type</th><th>Price</th><th>Add</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<ServiceDTO> list = (List<ServiceDTO>) request.getAttribute("ALLSERVICE");
                            if (list != null && !list.isEmpty()) {
                                for (ServiceDTO s : list) {
                        %>


                        <tr>
                            <td><%= s.getServiceId()%></td>
                            <td><%= s.getServiceName()%></td>
                            <td><%= s.getServiceType()%></td>
                            <td><%= String.format("%,.0f VND", s.getPrice()).replace(',', '.')%></td>
                            <td>
                                <form action="MainController">
                                    <input type="hidden" name="bookingId" value="<%= bookingID%>">
                                    <input type="hidden" name="ServiceID" value="<%=s.getServiceId()%>">
                                    <button type="submit" name="action" value="<%= IConstants.AC_ADD_SERVICE%>">add</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr><td colspan="5" style="text-align:center">Chưa có dữ liệu dịch vụ</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Cột phải: dịch vụ đã thêm -->
            <div class="col">

                <h3>Dịch vụ đã thêm</h3>
                <%
                    String message = (String) request.getAttribute("SAVE_BOOKING_SERVICE");
                    if (message != null && !message.isEmpty()) {
                        out.print(message);
                    }
                %>
                <table>
                    <thead>
                        <tr><th>ID</th><th>Name</th><th>Type</th><th>Quantity</th><th>Price</th><th>Chỉnh sửa</th></tr>
                    </thead>
                    <tbody>

                        <%
                            double GrandTotal = 0;
                            String bookingId = (String) session.getAttribute("BOOKING_ID");
                            String cartKey = "CART_" + bookingId;
                            HashMap<ServiceDTO, Integer> cart = (HashMap) session.getAttribute(cartKey);
                            if (cart == null) {
                        %>
                        <tr><td colspan="6" style="text-align:center">None</td></tr>
                        <%
                        } else {
                            double total = 0;
                            for (ServiceDTO s : cart.keySet()) {
                                total += cart.get(s) * s.getPrice();
                        %>
                        <tr><form action="MainController"> 
                        <td><%= s.getServiceId()%></td>
                        <td><%= s.getServiceName()%></td>
                        <td><%= s.getServiceType()%></td>
                        <td><input type="number" name="txtquantity" min="1" value="<%= cart.get(s)%>"></td>
                        <td><%= String.format("%,.0f VND", s.getPrice()).replace(',', '.') %></td>

                        <td style="text-align:center">
                            <input type="hidden" name="serviceid" value="<%= s.getServiceId()%>">
                            <input type="hidden" name="bookingId" value="<%= bookingID%>">
                            <button type="submit" name="action" value="<%= IConstants.AC_SAVE_BOOKING_SERVICE%>">Đặt ngay</button>
                            <button type="submit" name="action" value="<%= IConstants.AC_UPDATE_BOOKING_SERVICE%>">Cập nhật số lượng</button>
                            <button type="submit" name="action" value="<%= IConstants.AC_DELETE_BOOKING_SERVICE%>">Xoá</button>
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
                            <td class="total" colspan="5">Tổng: </td>
                            <td style="text-align:center"><%= String.format("%,.0f VND", GrandTotal).replace(',', '.')%></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        
        <% if (staff != null) {
        %>
        <a class="back" href="MainController?action=getroomservice">⬅ Back to room</a>
        <%
        } else {
        %>
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="<%= IConstants.AC_GO_BACK_GUEST_PAGE%>">Quay về trang Guest</button>
        </form>
        <%
                }
            }%>
    </body>
</html>
