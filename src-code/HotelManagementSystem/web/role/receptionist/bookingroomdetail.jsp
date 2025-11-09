<%--
    File : bookingroomdetail.jsp (Scriptlet Version with Action Buttons + Internal CSS)
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

        <!-- CSS Internal - Đồng bộ với style.css -->
        <style>
            /* ===== THIẾT LẬP CƠ BẢN - Đồng bộ với style.css ===== */
            body {
                background-color: #f8f9fa;
                color: #333333;
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 0;
                padding: 20px;
            }

            h1, h2, h3, h4, h5, h6 {
                color: #004a99;
                margin-top: 20px;
                margin-bottom: 10px;
            }

            /* ===== FORM CHÍNH ===== */
            form {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
                max-width: 800px;
                margin: 20px auto;
                font-size: 1em;
            }

            label {
                display: inline-block;
                width: 180px;
                font-weight: bold;
                color: #004a99;
                margin-bottom: 8px;
                vertical-align: top;
            }

            select, input[type="date"] {
                padding: 10px 14px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 1em;
                width: 280px;
                box-sizing: border-box;
            }

            select:focus, input[type="date"]:focus {
                outline: none;
                border-color: #004a99;
                box-shadow: 0 0 6px rgba(0, 74, 153, 0.3);
            }

            /* ===== NÚT HÀNH ĐỘNG ===== */
            button, input[type="submit"] {
                background-color: #004a99;
                color: white;
                border: none;
                padding: 11px 20px;
                margin: 10px 8px 10px 0;
                border-radius: 6px;
                cursor: pointer;
                font-size: 1em;
                font-weight: bold;
                transition: background-color 0.3s ease, transform 0.1s ease;
            }

            button:hover, input[type="submit"]:hover {
                background-color: #003366;
                transform: translateY(-1px);
            }

            button:active, input[type="submit"]:active {
                transform: translateY(0);
            }

            /* ===== NÚT QUAY LẠI ===== */
            a {
                display: inline-block;
                margin-top: 20px;
                color: #004a99;
                text-decoration: none;
                font-weight: bold;
                font-size: 1em;
            }

            a:hover {
                text-decoration: underline;
            }

            /* ===== THÔNG BÁO ===== */
            h3[style*="green"] {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
                padding: 12px;
                border-radius: 6px;
                text-align: center;
                margin: 15px 0;
            }

            h3[style*="red"] {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
                padding: 12px;
                border-radius: 6px;
                text-align: center;
                margin: 15px 0;
            }

            /* ===== GHI CHÚ ===== */
            .note {
                color: #888;
                font-size: 0.9em;
                font-style: italic;
                margin-top: 5px;
                display: block;
            }

            /* ===== ĐƯỜNG KẺ ===== */
            hr {
                border: none;
                border-top: 1px solid #e0e0e0;
                margin: 25px 0;
            }

            p {
                margin: 10px 0;
                line-height: 1.5;
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 600px) {
                label, select, input[type="date"] {
                    width: 100%;
                }
                form {
                    padding: 20px;
                }
                button, input[type="submit"] {
                    width: 100%;
                    margin: 8px 0;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />

        <%
            ShowBookingDTO booking = (ShowBookingDTO) request.getAttribute("BOOKING_DETAIL");
            List<RoomTypeDTO> roomTypes = (List<RoomTypeDTO>) request.getAttribute("ROOM_TYPES_LIST");
            List<RoomDTO> availableRooms = (List<RoomDTO>) request.getAttribute("AVAILABLE_ROOMS_LIST");
            Integer selectedRoomTypeId = (Integer) request.getAttribute("SELECTED_ROOM_TYPE_ID");
            String errCheckinDate = (String) request.getAttribute("ERRORCHECKINDATE");
            String errCheckoutDate = (String) request.getAttribute("ERRORCHECKOUTDATE");

            if (errCheckinDate == null) {
                errCheckinDate = "";
            }
            if (errCheckoutDate == null) {
                errCheckoutDate = "";
            }

            if (booking != null) {
                boolean isChangeable = booking.getStatus().equals("Reserved");
                String currentStatus = booking.getStatus();
        %>
        <h1>Thông Tin Đặt Phòng - ID: <%= booking.getBookingID()%></h1>

        <form action="UpdateBookingInReceptionController" method="POST" id="bookingDetailForm">
            <input type="hidden" name="bookingID" value="<%= booking.getBookingID()%>" />
            <input type="hidden" name="roomID" value="<%= booking.getRoomID()%>" <%= isChangeable ? "disabled" : ""%> />

            <p><strong>Mã khách hàng:</strong> <%= booking.getGuestID()%></p>
            <p><strong>Tên khách hàng:</strong> <%= booking.getGuestName()%></p>
            <hr/>

            <!-- Loại phòng -->
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
                            } else {
                                if (type.getRoomTypeID() == booking.getRoomTypeID()) {
                                    selectedAttr = "selected";
                            }
                        }%>
                <option value="<%= type.getRoomTypeID()%>" <%= selectedAttr%>><%= type.getTypeName()%></option>
                <% }
                }%>
            </select>
            <br/><br/>

            <!-- Số phòng trống -->
            <label for="roomNumberSelect">Số phòng trống:</label>
            <select name="roomID" id="roomNumberSelect" <%= !isChangeable ? "disabled" : ""%> required>
                <% if (availableRooms != null && !availableRooms.isEmpty()) {
                        for (RoomDTO room : availableRooms) {
                            String selectedAttr = "";
                            String roomNumberDefault = room.getRoomNumber();
                            if (room.getRoomID() == booking.getRoomID()) {
                                selectedAttr = "selected";
                                roomNumberDefault += " (Phòng hiện tại)";
                        }%>
                <option value="<%= room.getRoomID()%>" <%= selectedAttr%>><%= roomNumberDefault%></option>
                <% }
                } %>
            </select>
            <% if (!isChangeable) { %>
            <p class="note">Chỉ các booking có trạng thái "Reserved" mới có thể đổi phòng.</p>
            <% }%>
            <hr/>

            <!-- Ngày Check-in / Check-out -->
            <label for="checkInDate">Ngày Check-in:</label>
            <input type="date" id="checkInDate" name="checkInDate" value="<%= booking.getCheckInDate()%>" <%= !isChangeable ? "readonly" : ""%>>
            <span style="color: red; margin-left: 10px;"><%= errCheckinDate%></span>
            <br/><br/>

            <label for="checkOutDate">Ngày Check-out:</label>
            <input type="date" id="checkOutDate" name="checkOutDate" value="<%= booking.getCheckOutDate()%>" <%= !isChangeable ? "readonly" : ""%>>
            <span style="color: red; margin-left: 10px;"><%= errCheckoutDate%></span>
            <br/><br/>

            <p><strong>Booking Date:</strong> <%= booking.getBookingDate()%></p>
            <hr/>

            <p><strong>Trạng thái hiện tại:</strong> <span style="color: #004a99; font-weight: bold;"><%= currentStatus%></span></p>
            <input type="hidden" name="status" value="<%= currentStatus%>" />

            <!-- NÚT HÀNH ĐỘNG THEO TRẠNG THÁI -->
            <% if (currentStatus.equals("Reserved")) { %>
            <button type="submit" name="action" value="Check In" formaction="MainController">Check In</button>
            <button type="submit" name="action" value="Cancel Booking" formaction="MainController">Huỷ đặt phòng</button>
            <% } else if (currentStatus.equals("CheckIn")) {%>
            <input type="hidden" name="bookingId" value="<%= booking.getBookingID()%>">
            <button type="submit" name="action" value="checkoutbookingroom" formaction="MainController">CheckOut và tạo hóa đơn</button>
            <% } else if (currentStatus.equals("CheckOut")) { %>
            <button type="submit" name="action" value="Approve Checkout" formaction="MainController">Chấp nhận Checkout</button>
            <% } %>

            <hr/>

            <!-- THÔNG BÁO -->
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

            <!-- NÚT LƯU THAY ĐỔI -->
            <% if (isChangeable) { %>
            <input type="submit" name="action" value="Save Changes" formaction="MainController"/>
            <% } %>

            <br/>
            <a href="MainController?action=TurnBackReceptionPage">Quay lại</a>
        </form>

        <% } else { %>
        <h1 style="text-align: center; color: #721c24;">Không có thông tin Booking!</h1>
        <% }%>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>