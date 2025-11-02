<%-- 
    Document   : guest
    Created on : Oct 9, 2025, 2:56:32 PM
    Author     : Admin
--%>

<%@page import="DTO.Basic_DTO.GuestDTO"%>
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
            GuestDTO guest = (GuestDTO) session.getAttribute("USER");
            String succSaveBooking = (String) request.getAttribute("SUCCESS");
            if(succSaveBooking!=null && !succSaveBooking.trim().isEmpty()){
                out.print(succSaveBooking);
            }
        %>
        <h1>Welcome <%= guest.getFullName() %> Guest!</h1>
        <a href="MainController?action=booking">Booking</a>
        <form action="MainController" method="POST">
            <button type="submit" value="<%=  IConstants.AC_VIEW_BOOKING %>" name="action">View My Booking</button>
        </form>
    </body>
</html>
