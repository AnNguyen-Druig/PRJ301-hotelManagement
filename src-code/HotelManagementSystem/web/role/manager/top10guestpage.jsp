<%-- 
    Document   : top10guestpage
    Created on : Oct 27, 2025, 1:22:25 PM
    Author     : Admin
--%>

<%@page import="DTO.Manager_DTO.TopFrequentGuestDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <%
            ArrayList<TopFrequentGuestDTO> list = (ArrayList) request.getAttribute("ALL_GUEST_LIST");
            ArrayList<TopFrequentGuestDTO> highestMoneyList = (ArrayList) request.getAttribute("HIGHEST_MONEY_LIST");
            String errMsg = (String) request.getAttribute("ERROR");
            if (errMsg == null) {
                errMsg = "";
            }

            if (list != null && !list.isEmpty()) {
        %>
        <h2>Danh sách khách hàng Quen Thuộc</h2>
        <table>
            <thead>
                <tr>
                    <th>Hạng</th>
                    <th>Mã khách hàng</th>
                    <th>Tên khách hàng</th>
                    <th>Số điện thoại</th>
                    <th>Email</th>
                    <th>Số lần đặt phòng</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int rank = 1;
                    for (TopFrequentGuestDTO guest : list) {
                %>
                <tr>
                    <td><%= rank++%></td>
                    <td><%= guest.getGuestID()%></td>
                    <td><%= guest.getFullName()%></td>
                    <td><%= guest.getPhone()%></td>
                    <td><%= guest.getEmail()%></td>
                    <td><%= guest.getBookingCount()%></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <h3><%= errMsg%></h3>
        <%
            }
        %>
        <hr/>
        <h2>Danh sách khách hàng Tiêu dùng nhiều nhất</h2>
        <!-- Hiển thị danh sách Guest sử dụng tiền nhiều nhất -->
        <%if (highestMoneyList != null && !highestMoneyList.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Hạng</th>
                    <th>Mã khách hàng</th>
                    <th>Tên khách hàng</th>
                    <th>Tổng tiền sử dụng</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int rank = 1;
                    for (TopFrequentGuestDTO guest : highestMoneyList) {
                %>
                <tr>
                    <td><%= rank++%></td>
                    <td><%= guest.getGuestID()%></td>
                    <td><%= guest.getFullName()%></td>
                    <td><%= String.format("%,.0f", guest.getMoney()).replace(',', '.') %> VND</td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <h3><%= errMsg%></h3>
        <%
            }
        %>
        <hr/>
        <a href="MainController?action=gobackmanager">Quay lại Dashboard</a>
    </body>
</html>
