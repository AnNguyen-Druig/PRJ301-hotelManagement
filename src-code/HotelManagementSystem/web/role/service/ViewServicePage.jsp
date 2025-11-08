<%-- 
    Document   : ViewServicePage
    Created on : Oct 26, 2025, 4:44:20 PM
    Author     : Nguyễn Đại
--%>

<%@page import="mylib.IConstants"%>
<%@page import="DTO.Basic_DTO.BookingServiceDTO"%>
<%@page import="DTO.Basic_DTO.ServiceDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Service</title>
        <style>
            table{
                border-collapse:collapse;
                width:100%
            }
            th,td{
                border:1px solid #ddd;
                padding:8px
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="STAFF" scope="session" class="DTO.Basic_DTO.StaffDTO" />
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <h1>Hello ${STAFF.fullName}</h1>

        <h2>Booking Services for Booking ${BOOKING_ID}</h2>
        <%
            List<BookingServiceDTO> list = (List<BookingServiceDTO>) request.getAttribute("BOOKING_SERVICES");
            Map<Integer, ServiceDTO> serviceMap = (Map<Integer, ServiceDTO>) request.getAttribute("SERVICE_MAP");
            String err = (String) request.getAttribute("ERROR");
            if (err != null) {
        %>
        <p style="color:red"><%= err%></p>

        <%
            }
        %>

        <table>
            <thead>
                <tr>
                    <th>BookingServiceID</th>
                    <th>ServiceID</th>
                    <th>ServiceName</th>
                    <th>ServiceDate</th>
                    <th>Status</th>
                    <th>AssignedStaff</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (list != null && !list.isEmpty()) {
                        for (BookingServiceDTO bs : list) {
                            ServiceDTO s = (serviceMap != null) ? serviceMap.get(bs.getServiceID()) : null;
                            String sName = (s != null) ? s.getServiceName() : ("ServiceID " + bs.getServiceID());
                %>
                <tr>
                    <td><%= bs.getBookingServiceID()%></td>
                    <td><%= bs.getServiceID()%></td>
                    <td><%= sName%></td>
                    <td><%= bs.getServiceDate()%></td>
                    <td><%= bs.getStatus()%></td>
                    <td><%= bs.getAssignedStaff()%></td>
                    <td><form action="MainController" method="POST" style="justify-content: center; display: flex; gap: 8px; align-items: center;">
                            <input type="hidden" name="action" value="update_service_status">
                            <input type="hidden" name="bookingServiceId" value="<%= bs.getBookingServiceID()%>" />
                            <input type="hidden" name="bookingId" value="<%= bs.getBookingID()%>" />
                            <button type="submit" name="newStatus" value="Completed">Completed</button>
                            <button type="submit" name="newStatus" value="Canceled">Canceled</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="7" style="text-align:center">Chưa có dịch vụ nào cho booking này.</td></tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <p><a href="MainController?action=getroomservice">⬅ Quay lại danh sách phòng</a></p>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
