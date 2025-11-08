<%-- 
    Document   : showtaxandservice
    Created on : Nov 8, 2025, 8:11:12 AM
    Author     : ASUS
--%>

<%@page import="DTO.Basic_DTO.ServiceDTO"%>
<%@page import="DTO.Basic_DTO.TaxDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="mylib.IConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (staff == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
                ArrayList<TaxDTO> listTax = (ArrayList<TaxDTO>) request.getAttribute("LIST_TAX");
                if (listTax != null && !listTax.isEmpty()) {

        %>
        <table>
            <tr>
                <th>Mã thuế</th>
                <th>Tên thuế</th>
                <th>Giá thuế</th>
                <th>Mô tả</th>
                <th>Lần cuối cập nhật</th>
                    <%                        for (TaxDTO t : listTax) {
                    %>
            <tr> 
                <td><%= t.getTaxID()%></td>
                <td><%= t.getTaxName()%></td>
                <td><%= t.getTaxValue()%></td>
                <td><%= t.getDescription()%></td>
                <td><%= t.getLastUpdated()%></td>
                <td>
                    <form action="MainController" method="POST">
                        <button type="submit" name="action" value="<%= IConstants.AC_CANCEL_BOOKING_ROOM%>">Huỷ đặt phòng</button> 
                    </form>
                </td>
            </tr> 
            <%
                }
            %>
        </table>
        <%
        } else {
        %>${requestScope.ERROR_LISTTAX}<%
            }

            ArrayList<ServiceDTO> listService = (ArrayList<ServiceDTO>) request.getAttribute("LIST_SERVICE");
            if (listService != null && !listService.isEmpty()) {

        %>
        <table>
            <tr>
                <th>Mã dịch vụ</th>
                <th>Tên dịch vụ</th>
                <th>Loại dịch vụ</th>
                <th>Giá tiền</th>
                    <%  
                      for (ServiceDTO s : listService) {
                    %>
            <tr>               
                <td><%= s.getServiceId() %></td>
                <td><%= s.getServiceName() %></td>
                <td><%= s.getServiceType() %></td>
                <td><%= s.getPrice() %></td>
                <td>
                    <form action="MainController" method="POST">
                        <button type="submit" name="action" value="<%= IConstants.AC_CANCEL_BOOKING_ROOM%>">Huỷ đặt phòng</button> 
                    </form>
                </td>
            </tr> 
            <%
                }
            %>
        </table>
        <%
        } else {
        %>${requestScope.ERROR_LISTSERVICE}<%
                }

            }
        %>
    </body>
</html>
