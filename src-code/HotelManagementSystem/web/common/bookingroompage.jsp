<%-- 
    Document   : bookingroompage
    Created on : Oct 12, 2025, 2:48:06 PM
    Author     : ASUS
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DTO.RoomDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="DTO.GuestDTO"%>
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
            if (guest == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
                String typeName = "";
                if (request.getParameter("roomtype") != null) {
                    typeName = request.getParameter("roomtype");
                }
        %>
        <form action="MainController">
            <label for="roomtype">Loai Phong</label>
            <select id="roomtype" name="roomtype">
                <option value="<%= typeName %>">---Chon---</option>
                <option value="Single">Single</option>
                <option value="Double">Double</option> 
                <option value="Suite">Suite</option>
                <option value="Deluxe">Deluxe</option>
                <option value="Family">Family</option>
                <option value="Executive">Executive</option>
            </select>
            <input type="submit" value="filterroom" name="action">
        </form>
        <%
            ArrayList<RoomDTO> roomList = (ArrayList<RoomDTO>) request.getAttribute("ALLROOM");
            if (roomList != null && !roomList.isEmpty()) {
                for (RoomDTO r : roomList) {
        %>
        <p>RoomID: <%= r.getRoomID()%></p>
        <p>TypeName: <%= r.getTypeName()%></p>
        <p>Capacity: <%= r.getCapacity()%></p>
        <p>PricePerNight: <%= r.getPricePerNight()%></p>
<!--                        <a href="MainController?roomID=<%= r.getRoomID()%>&guestID=<%= guest.getGuestID()%>&action=bookingroom">  Dat Phong  </a> -->
        <form action="MainController" method="POST">
            <input type="hidden" name="roomID" value="<%= r.getRoomID()%>">
            <input type="hidden" name="guestID" value="<%= guest.getGuestID()%>">
            <button type="submit" value="bookingroom" name="action">Dat Phong</button>
        </form>

        <%
                    }
                } else {
                    String error = (String) request.getAttribute("ERROR");
                    if (error != null && !error.trim().isEmpty()) {
                        out.print(error);
                    }
                }
            }
        %>
    </body>
</html>
