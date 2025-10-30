<%--
    File   : bookingdetail.jsp (Scriptlet Version with Action Buttons)
--%>
<%@page import="DTO.RoomDTO"%>
<%@page import="java.util.List"%>
<%@page import="DTO.BookingDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail</title>
        <style>.note {
                color: #888;
                font-size: 0.9em;
            }</style>
    </head>
    <body>
        <%
            // Lấy dữ liệu từ request scope
            BookingDTO booking = (BookingDTO) request.getAttribute("BOOKING_DETAIL");
            List<RoomDTO> roomTypes = (List<RoomDTO>) request.getAttribute("ROOM_TYPES_LIST");
            List<RoomDTO> availableRooms = (List<RoomDTO>) request.getAttribute("AVAILABLE_ROOMS_LIST");
            Integer selectedRoomTypeId = (Integer) request.getAttribute("SELECTED_ROOM_TYPE_ID");

            if (booking != null) {
                boolean isChangeable = "Reserved".equals(booking.getStatus());
                String currentStatus = booking.getStatus(); // Lấy trạng thái hiện tại
%>

        <h1>Thông Tin Đặt Phòng - ID: <%= booking.getBookingID()%></h1>

        <%-- Form này vẫn submit về UpdateBookingInReceptionController khi chọn loại phòng --%>
        <form action="UpdateBookingInReceptionController" method="POST" id="bookingDetailForm">
            <input type="hidden" name="bookingID" value="<%= booking.getBookingID()%>" />
            <input type="hidden" name="roomID" value="<%= booking.getRoomID() %>" <%= isChangeable ? "disabled" : "" %> />

            <p>Mã khách hàng: <%= booking.getGuestID()%></p>
            <p>Tên khách hàng: <%= booking.getGuestName()%></p>
            <hr/>

            <%-- Phần chọn Loại phòng và Số phòng (giữ nguyên) --%>
            <label for="roomTypeSelect">Loại phòng:</label>
            <select name="roomTypeID" id="roomTypeSelect" onchange="document.getElementById('bookingDetailForm').submit();" <%= !isChangeable ? "disabled" : ""%>>
                <option value="">Chọn loại phòng</option>
                <% if (roomTypes != null) {
                        for (RoomDTO type : roomTypes) {
                            String selectedAttr = "";
                            if (selectedRoomTypeId != null) {
                                if (type.getRoomTypeID() == selectedRoomTypeId) {
                                    selectedAttr = "selected";
                                }
                            } else {
                                if (type.getRoomTypeID() == booking.getRoomTypeID()) {
                                    selectedAttr = "selected";
                                }
                            }%>
                <option value="<%= type.getRoomTypeID()%>" <%= selectedAttr%>><%= type.getTypeName()%></option>
                <%      }
                    }%>
            </select>
            <br/><br/>

            <label for="roomNumberSelect">Số phòng trống:</label>
            <select name="roomID" id="roomNumberSelect" <%= !isChangeable ? "disabled" : ""%> required>
                <% if (availableRooms != null && !availableRooms.isEmpty()) {
                        for (RoomDTO room : availableRooms) {
                            String selectedAttr = "";
                            String roomNumberDefault = room.getRoomNumber();
                            if (room.getRoomID() == booking.getRoomID()) {
                                selectedAttr = "selected";
                                roomNumberDefault += "(Phòng hiện tại)";
                            }%>
                <option value="<%= room.getRoomID()%>" <%= selectedAttr%>> <%= roomNumberDefault%></option>
                <% }
                } %>
            </select>
            <% if (!isChangeable) { %>
            <p class="note">Chỉ các booking có trạng thái "Reserved" mới có thể đổi phòng.</p>
            <% }%>
            <hr/>

            <%-- Phần ngày Check-in/Check-out (giữ nguyên) --%>
            <label for="checkInDate">Check-in Date:</label>
            <input type="date" id="checkInDate" name="checkInDate" value="<%= booking.getCheckInDate()%>" <%= !isChangeable ? "readonly" : ""%>>
            <br/><br/>
            <label for="checkOutDate">Check-out Date:</label>
            <input type="date" id="checkOutDate" name="checkOutDate" value="<%= booking.getCheckOutDate()%>" <%= !isChangeable ? "readonly" : ""%>>
            <br/><br/>
            <p>Booking Date: <%= booking.getBookingDate()%></p>

            <hr/>
            <p><b>Trạng thái hiện tại:</b> <%= currentStatus%></p>
            <input type="hidden" name="status" value="<%= currentStatus %>" />

            <%-- Chỉ hiển thị nút hành động phù hợp --%>
            <% if ("Reserved".equals(currentStatus)) { %>
            <input type="submit" name="action" value="Check In" formaction="MainController"/>
            <input type="submit" name="action" value="Cancel Booking" formaction="MainController">
            <% } else if ("CheckIn".equals(currentStatus)) { %>
            <input type="submit" name="action" value="Check Out" formaction="MainController"/>
            <% } else if ("CheckOut".equals(currentStatus)) { %>
            <input type="submit" name="action" value="Approve Checkout" formaction="MainController"/>
            <% } %>
            <%-- Các trạng thái khác (Canceled, Complete) không có nút hành động --%>

            <hr/>
            <%
                String sucMsg = (String) request.getAttribute("SUCCESS");
                String errMsg = (String) request.getAttribute("ERROR");
            %>
            <% if (sucMsg != null) {%>
            <h3 style="color: green;"><%= sucMsg%></h3> <%-- Dùng h3 hoặc p --%>
            <% } %>
            <% if (errMsg != null) {%>
            <h3 style="color: red;">Lỗi: <%= errMsg%></h3> <%-- Dùng h3 hoặc p --%>
            <% } %>
            <%-- Nút Lưu thay đổi (cho phòng, ngày) chỉ hiển thị khi status là Reserved --%>
            <% if (isChangeable) { %>
            <input type="submit" name="action" value="Save Changes" formaction="MainController"/>
            <% }%>

            <a href="MainController?action=TurnBackReceptionPage">Quay lại</a>
        </form>
        <% } else { %>
        <h1>Không có danh sách Booking!</h1>
        <% }%>

    </body>
</html>