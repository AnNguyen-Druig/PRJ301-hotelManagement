<%--
    File   : bookingdetail.jsp (Scriptlet Version with Action Buttons)
--%>
<%@page import="DTO.Basic_DTO.RoomTypeDTO"%>
<%@page import="DTO.Receptionist_DTO.ShowBookingDTO"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.List"%>
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
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <%
            // Lấy dữ liệu từ request scope
            ShowBookingDTO booking = (ShowBookingDTO) request.getAttribute("BOOKING_DETAIL");
            List<RoomTypeDTO> roomTypes = (List<RoomTypeDTO>) request.getAttribute("ROOM_TYPES_LIST");
            List<RoomDTO> availableRooms = (List<RoomDTO>) request.getAttribute("AVAILABLE_ROOMS_LIST");
            Integer selectedRoomTypeId = (Integer) request.getAttribute("SELECTED_ROOM_TYPE_ID");
            String errCheckinDate = (String) request.getAttribute("ERRORCHECKINDATE");
            String errCheckoutDate = (String) request.getAttribute("ERRORCHECKOUTDATE");
            
            if(errCheckinDate == null) errCheckinDate = "";
            if(errCheckoutDate == null) errCheckoutDate = "";

            if (booking != null) {
                boolean isChangeable = booking.getStatus().equals("Reserved");
                String currentStatus = booking.getStatus(); // Lấy trạng thái hiện tại
        %>

        <h1>Thông Tin Đặt Phòng - ID: <%= booking.getBookingID()%></h1>

        <%-- Form này submit về UpdateBookingInReceptionController khi chọn loại phòng --%>
        <form action="UpdateBookingInReceptionController" method="POST" id="bookingDetailForm">
            <input type="hidden" name="bookingID" value="<%= booking.getBookingID()%>" />
            <input type="hidden" name="roomID" value="<%= booking.getRoomID()%>" <%= isChangeable ? "disabled" : ""%> />

            <p>Mã khách hàng: <%= booking.getGuestID()%></p>
            <p>Tên khách hàng: <%= booking.getGuestName()%></p>
            <hr/>

            <%-- Phần chọn Loại phòng và Số phòng (giữ nguyên) --%>
            <label for="roomTypeSelect">Loại phòng:</label>
            <select name="roomTypeID" id="roomTypeSelect" onchange="document.getElementById('bookingDetailForm').submit();" <%= !isChangeable ? "disabled" : ""%>>
                <option value="">Chọn loại phòng</option>
                <% if (roomTypes != null) {
                        for (RoomTypeDTO type : roomTypes) {
                            String selectedAttr = "";
                            if (selectedRoomTypeId != null) {
                                if (type.getRoomTypeID() == selectedRoomTypeId) {
                                    selectedAttr = "selected";
                                }
                            } else {    //dùng để hiển thị ra Loại phòng hiện tại khi mới vào trang lần đầu
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

            <%-- Phần ngày Check-in/Check-out --%>
            <label for="checkInDate">Ngày Check-in:</label>
            <input type="date" id="checkInDate" name="checkInDate" value="<%= booking.getCheckInDate()%>" <%= !isChangeable ? "readonly" : ""%>>
            <span><%= errCheckinDate %></span>
            <br/><br/>
            <label for="checkOutDate">Ngày Check-out:</label>
            <input type="date" id="checkOutDate" name="checkOutDate" value="<%= booking.getCheckOutDate()%>" <%= !isChangeable ? "readonly" : ""%>>
            <span><%= errCheckoutDate %></span>
            <br/><br/>
            <p>Booking Date: <%= booking.getBookingDate()%></p>

            <hr/>
            <p><b>Trạng thái hiện tại:</b> <%= currentStatus%></p>
            <input type="hidden" name="status" value="<%= currentStatus%>" />

            <%-- Chỉ hiển thị nút hành động phù hợp --%>
            <% if (currentStatus.equals("Reserved")) { %>
            <button type="submit" name="action" value="Check In" formaction="MainController">Check In</button>
            <button type="submit" name="action" value="Cancel Booking" formaction="MainController">Huỷ đặt phòng</button>
            <% } else if (currentStatus.equals("CheckIn")) {%>
<!--        Khi bấm nút 'CheckOut và tạo hóa đơn' thì thuộc tính bookingId đc gửi ngầm theo và gửi đến MainController chứ ko phải UpdateBookingInReceptionController-->
            <input type="hidden" name="bookingId" value="<%= booking.getBookingID() %>">    
            <button type="submit" name="action" value="checkoutbookingroom" formaction="MainController">CheckOut và tạo hóa đơn</button>
            <% } else if (currentStatus.equals("CheckOut")) { %>
            <button type="submit" name="action" value="Approve Checkout" formaction="MainController">Chấp nhận Checkout</button>
            <% } %>
            <%-- Các trạng thái khác (Canceled, Complete) không có nút hành động --%>

            <hr/>
            <%
                String sucMsg = (String) request.getAttribute("SUCCESS");
                String errMsg = (String) request.getAttribute("ERROR");
            %>
            <% if (sucMsg != null) {%>
            <h3 style="color: green;"><%= sucMsg%></h3>
            <% } %>
            <% if (errMsg != null) {%>
            <h3 style="color: red;">Lỗi: <%= errMsg%></h3> 
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
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>