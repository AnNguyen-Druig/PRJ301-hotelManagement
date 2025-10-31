<%--
    Document   : receptionist
    Created on : Oct 2, 2025, 3:19:09 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.StaffDTO"%>
<%@page import="DTO.BookingDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Receptionist Dashboard</title>
         <style> /* Thêm chút style cho dễ nhìn */
            table, th, td { border: 1px solid black; border-collapse: collapse; padding: 5px; }
            th { background-color: #f2f2f2; }
            .filter-form { margin-bottom: 20px; }
        </style>
    </head>
    <body>
        <%
            // Lấy thông tin Staff và các message
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if(staff == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
            String makeBookingErr = (String) request.getAttribute("ERROR"); // Lỗi chung
            if(makeBookingErr == null) {
                makeBookingErr = "";
            }

            // Lấy trạng thái đã chọn từ Controller (nếu có)
            String selectedStatus = (String) request.getAttribute("SELECTED_STATUS");
            if (selectedStatus == null) {
                selectedStatus = "All"; // Mặc định hiển thị tất cả
            }
        %>

        <h1>Welcome <%= (staff != null) ? staff.getFullName() : "Receptionist" %>!</h1>
        <p><a href="MainController?action=logout">Logout</a></p>

        <h3>Tạo Booking</h3>
        <form action="MainController">
            <input type="text" name="guest_idnumber" placeholder="Nhập số CCCD">
            <input type="submit" name="action" value="Make new Booking">
            <span style="color:red;"><%= makeBookingErr %></span>
        </form>

        <h3><a href="MainController?action=Signup">Đăng ký thành viên cho người dùng</a></h3>

        <hr/>

        <%-- ==================== Phần Filter theo Status ==================== --%>
        <h3>Lọc danh sách Booking</h3>
        <div class="filter-form">
            <%-- Form này sẽ submit về MainController để tải lại danh sách --%>
            <form action="MainController">
                 <%-- Luôn gửi kèm action để MainController biết cần làm gì --%>
                <input type="hidden" name="action" value="TurnBackReceptionPage"> 
                <label for="statusSelect">Chọn trạng thái:</label>
                <select name="selectedStatus" id="statusSelect" onchange="this.form.submit();">
                    <%-- Option mặc định là "All" --%>
                    <option value="All" <%= "All".equals(selectedStatus) ? "selected" : "" %>>Tất cả</option>
                    <%-- Các status khác --%>
                    <option value="Reserved" <%= "Reserved".equals(selectedStatus) ? "selected" : "" %>>Reserved</option>
                    <option value="CheckIn" <%= "CheckIn".equals(selectedStatus) ? "selected" : "" %>>CheckIn</option>
                    <option value="CheckOut" <%= "CheckOut".equals(selectedStatus) ? "selected" : "" %>>CheckOut</option>
                    <option value="Canceled" <%= "Canceled".equals(selectedStatus) ? "selected" : "" %>>Canceled</option>
                    <option value="Complete" <%= "Complete".equals(selectedStatus) ? "selected" : "" %>>Complete</option>
                </select>
                <%-- Không cần nút submit vì đã có onchange --%>
            </form>
        </div>
        <%-- =============================================================== --%>


        <%
            // Lấy danh sách booking (đã được lọc bởi Controller)
            ArrayList<BookingDTO> bookingList = (ArrayList) request.getAttribute("ALLBOOKING");
            String bookingListError = (String) request.getAttribute("BOOKING_LIST_ERROR"); // Lỗi riêng của danh sách booking
            if (bookingListError == null) bookingListError = "";
        %>

        <h3>Booking List <% if (!selectedStatus.equals("All")) { out.print("(Trạng thái: " + selectedStatus + ")"); } %></h3>

        <% if (bookingList != null && !bookingList.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Guest ID</th>
                        <th>Guest Name</th>
                        <th>Room ID</th>
                        <th>Room Number</th>
                        <th>Room Type</th>
                        <th>Check-in Date</th>
                        <th>Check-out Date</th>
                        <th>Booking Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (BookingDTO b : bookingList) { %>
                        <tr>
                            <td><%= b.getBookingID() %></td>
                            <td><%= b.getGuestID() %></td>
                            <td><%= b.getGuestName() %></td>
                            <td><%= b.getRoomID() %></td>
                            <td><%= b.getRoomNumber() %></td>
                            <td><%= b.getRoomType() %></td>
                            <td><%= b.getCheckInDate() %></td>
                            <td><%= b.getCheckOutDate() %></td>
                            <td><%= b.getBookingDate() %></td>
                            <td><%= b.getStatus() %></td>
                            <td>
                                <%-- Link Update vẫn trỏ đến MainController --%>
                                <a href="MainController?action=UpdateBooking&bookingID=<%= b.getBookingID() %>">Update</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
             <%-- Hiển thị lỗi nếu có, hoặc thông báo không có booking --%>
            <p style="color:red;"><%= !bookingListError.isEmpty() ? bookingListError : "Không có booking nào phù hợp với trạng thái đã chọn." %></p>
        <% } %>
        <% } %>
    </body>
</html>