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
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styles.css">
    </head>
    <style>
        /* Bổ sung style nội tuyến để mở rộng style.css */
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #004a99;
            border-bottom: 2px solid #004a99;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            font-size: 15px;
        }

        th {
            background-color: #004a99;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            vertical-align: middle;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e6f3ff;
        }

        input[type="text"] {
            padding: 8px;
            width: 120px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        button {
            background-color: #004a99;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 5px;
        }

        button:hover {
            background-color: #003366;
        }

        .msg {
            color: #d9534f;
            font-weight: bold;
            font-size: 14px;
        }

        .success {
            color: #5cb85c;
        }

        .price {
            font-weight: bold;
            color: #004a99;
        }

        .form-inline {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .form-inline input {
            flex: 1;
            min-width: 100px;
        }

        .form-inline button {
            white-space: nowrap;
        }
    </style>
    <body>
        <%
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (staff == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
                ArrayList<TaxDTO> listTax = (ArrayList<TaxDTO>) request.getAttribute("LIST_TAX");
                if (listTax != null && !listTax.isEmpty()) {

        %>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <h2>BẢNG THUẾ</h2>
        <table>
            <tr>
                <th>Mã thuế</th>
                <th>Tên thuế</th>
                <th>Mô tả</th>
                <th>Lần cuối cập nhật</th>
                <th>Giá thuế</th>
                <th>Thông báo khi thay đổi</th>
                    <%                        for (TaxDTO t : listTax) {
                    %>
            <tr> 
                <td><%= t.getTaxID()%></td>
                <td><%= t.getTaxName()%></td>   
                <td><%= t.getDescription()%></td>
                <td><%= t.getLastUpdated()%></td>
                <td>
                    <form action="MainController" method="POST">
                        <input type="text" name="taxvalue" value="<%= t.getTaxValue()%>">
                        <input type="hidden" name="taxid" value="<%= t.getTaxID()%>">
                        <button type="submit" name="action" value="<%= IConstants.AC_EDIT_TAX_VALUE%>">Thay doi gia thue</button> 
                    </form>
                </td>
                <td><%
                    String taxID = request.getParameter("taxid");
                    if (taxID != null) {
                        if (Integer.parseInt(taxID) == t.getTaxID()) {
                    %>${requestScope.MSG_TAX}<%
                            }
                        }
                    %></td>
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
        <h2>BẢNG DỊCH VỤ</h2>
        <table>
            <tr>
                <th>Mã dịch vụ</th>
                <th>Tên dịch vụ</th>
                <th>Loại dịch vụ</th>
                <th>Giá tiền</th>
                <th>Thông báo khi thay đổi</th>
                    <%                        for (ServiceDTO s : listService) {
                    %>
            <tr>               
                <td><%= s.getServiceId()%></td>
                <td><%= s.getServiceName()%></td>
                <td><%= s.getServiceType()%></td>     
                <td>
                    <form action="MainController" method="POST">
                        <input type="text" name="serviceprice" value="<%= String.format("%,.0f", s.getPrice()).replace(',', '.')%>">VND 
                        <input type="hidden" name="serviceid" value="<%= s.getServiceId()%>">
                        <button type="submit" name="action" value="<%= IConstants.AC_EDIT_SERVICE_PRICE%>">Thay đổi giá dịch vụ</button> </br>
                    </form>
                </td>
                <td><%  //hiện thông báo theo từng dòng bằng cách so sánh id
                    String serviceid = request.getParameter("serviceid");
                    if (serviceid != null) {
                        if (Integer.parseInt(serviceid) == s.getServiceId()) {
                    %><span>${requestScope.MSG_SERVICE}</span><%
                            }
                        }
                    %></td>
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
