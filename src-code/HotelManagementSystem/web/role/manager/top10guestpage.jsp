<%-- 
    Document   : top10guestpage
    Created on : Oct 27, 2025, 1:22:25 PM
    Author     : Admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DTO.TopFrequentGuestDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            ArrayList<TopFrequentGuestDTO> list = (ArrayList) request.getAttribute("ALL_GUEST_LIST");
            String errMsg = (String) request.getAttribute("ERROR");
            if(errMsg == null) errMsg = "";

            if (list != null && !list.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Guest ID</th>
                    <th>Guest Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Booking Count</th>
                </tr>
            </thead>
            <tbody>
                <% for (TopFrequentGuestDTO guest : list) {%>
                <tr>
                    <td><%= guest.getGuestID()%></td>
                    <td><%= guest.getFullName() %></td>
                    <td><%= guest.getPhone() %></td>
                    <td><%= guest.getEmail() %></td>
                    <td><%= guest.getBookingCount() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <h3><%= errMsg %></h3>
        <%
            }
        %>
    </body>
</html>
