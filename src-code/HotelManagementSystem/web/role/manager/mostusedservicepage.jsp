<%-- 
    Document   : mostusedservicepage
    Created on : Nov 1, 2025, 2:13:28 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page import="DTO.Manager_DTO.MostUsedServiceDTO"%>
<%@page import="DTO.Basic_DTO.ServiceDTO"%>
<%@page import="java.util.ArrayList"%>
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
            ArrayList<MostUsedServiceDTO> mostList = (ArrayList) request.getAttribute("MOST_SERVICE");
            String errMsg = (String) request.getAttribute("ERROR");
            if (errMsg == null) {
                errMsg = "";
            }

            if (mostList != null && !mostList.isEmpty()) {
        %>
        <h2>Top các dịch vụ được sử dụng Nhiều Nhất</h2>
        <table>
            <thead>
                <tr>
                    <th>Hạng</th>
                    <th>Service ID</th>
                    <th>Loại Dịch Vụ</th>
                    <th>Tên Dịch Vụ</th>
                    <th>Số Lượng Sử Dụng</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int rank = 1;
                    for (MostUsedServiceDTO s : mostList) {
                %>
                <tr>
                    <td><%= rank++%></td>
                    <td><%= s.getServiceId()%></td>
                    <td><%= s.getServiceType()%></td>
                    <td><%= s.getServiceName()%></td>
                    <td><%= s.getCountNumService()%></td>
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
        
        <%
            MostUsedServiceDTO highestService = (MostUsedServiceDTO) request.getAttribute("HIGHEST_INCOME_SERVICE");
            if(highestService != null) {
        %>
        <h2>Service có doanh thu Cao Nhất: <%= highestService.getServiceName() %> : <%= String.format("%,.0f", highestService.getIncomeService()).replace(',', '.')%> VND</h2>
        <%
            } else {
        %>
            <h3><%= errMsg%></h3>
        <%
            }
        %>
        
        <%
            MostUsedServiceDTO lowestService = (MostUsedServiceDTO) request.getAttribute("LOWEST_INCOME_SERVICE");
            if(lowestService != null) {
        %>
        <h2>Service có doanh thu Thấp Nhất: <%= lowestService.getServiceName() %> : <%= String.format("%,.0f", lowestService.getIncomeService()).replace(',', '.')%> VND</h2>
        <%
            } else {
        %>
            <h3><%= errMsg%></h3>
        <%
            }
        %>

        <%
            ArrayList<MostUsedServiceDTO> highestList = (ArrayList) request.getAttribute("HIGHEST_LIST");
            if (highestList != null && !highestList.isEmpty()) {
        %>
        <h2>Top các dịch vụ được có doanh thu Cao Nhất</h2>
        <table>
            <thead>
                <tr>
                    <th>Hạng</th>
                    <th>Service ID</th>
                    <th>Loại Dịch Vụ</th>
                    <th>Tên Dịch Vụ</th>
                    <th>Doanh Thu</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int rank = 1;
                    for (MostUsedServiceDTO s : highestList) {
                %>
                <tr>
                    <td><%= rank++%></td>
                    <td><%= s.getServiceId()%></td>
                    <td><%= s.getServiceType()%></td>
                    <td><%= s.getServiceName()%></td>
                    <td><%= String.format("%,.0f", s.getIncomeService()).replace(',', '.')%> VND</td>
                </tr>
                <% }%>
            </tbody>
        </table>
        <%
        } else {
        %>
        <h3><%= errMsg%></h3>
        <%
            }
        %>
        <a href="MainController?action=gobackmanager">Quay lại Dashboard</a>
    </body>
</html>
