<%-- 
    File   : bookingdetail.jsp
--%>
<%@page import="DTO.BookingDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Detail</title>
    </head>
    <body>
        <c:set var="booking" value="${requestScope.BOOKING_DETAIL}"/>

        <c:if test="${not empty booking}">
            <!-- Dùng để kiểm tra nếu Status thì nút chọn loại phòng mới cho chọn <> disable-->
            <c:set var="change" value="${booking.status eq 'Reserved'}"/>

            <h1>Thông Tin Đặt Phòng - ID: ${booking.bookingID}</h1>

            <form action="UpdateBookingInReceptionController" method="POST" id="bookingDetailForm">
                <input type="hidden" name="bookingID" value="${booking.bookingID}" />

                <p>Mã khách hàng: ${booking.guestID}</p>
                <p>Tên khách hàng: ${booking.guestName}</p>

                <label for="roomTypeSelect">Loại phòng:</label>
                <select name="roomTypeID" id="roomTypeSelect" onchange="document.getElementById('bookingDetailForm').submit();" ${!change ? 'disabled':''}>
                    <option value="">Chọn loại phòng</option>
                    <c:forEach var="type" items="${requestScope.ROOM_TYPES_LIST}">
                        <%-- Giữ lại giá trị đã chọn sau khi trang tải lại --%>
                        <option value="${type.roomTypeID}" 
                                ${type.roomTypeID == requestScope.SELECTED_ROOM_TYPE_ID || (empty requestScope.SELECTED_ROOM_TYPE_ID && type.roomTypeID == booking.roomTypeID) ? 'selected' : ''}>
                            ${type.typeName}
                        </option>
                    </c:forEach>
                </select>

                <label for="roomNumberSelect">Số phòng trống:</label>
                <select name="roomid" id="roomNumberSelect" ${!change ? 'disabled' : ''} required>
                    <%-- Nếu chưa chọn loại phòng nào (trang vừa tải), hoặc không có phòng trống --%>
                    <c:if test="${empty requestScope.AVAILABLE_ROOMS_LIST}">
                        <option value="${booking.roomID}">${booking.roomNumber}</option>
                    </c:if>

                    <%-- Nếu có danh sách phòng trống được gửi về, thì hiển thị ra --%>
                    <c:forEach var="room" items="${requestScope.AVAILABLE_ROOMS_LIST}">
                        <option value="${room.roomID}">${room.roomNumber}</option>
                    </c:forEach>
                </select>
                <c:if test="${!change}">
                    <p class="note">Chỉ các booking có trạng thái "Reserved" mới có thể đổi phòng.</p>
                </c:if>

                <br/>
                <label for="checkInDate">Check-in Date:</label>
                <input type="date" id="checkInDate" name="checkInDate" value="${booking.checkInDate}" ${!change ? 'readonly':''}> 
                <br/>
                <label for="checkOutDate">Check-out Date:</label>
                <input type="date" id="checkOutDate" name="checkOutDate" value="${booking.checkOutDate}" ${!change ? 'readonly':''}"> 
                <p>Booking Date: ${booking.bookingDate}</p>

                <label for="statusSelect">Status:</label>
                <select id="statusSelect" name="status">
                    <option value="Reserved" ${"Reserved" eq booking.status ? "selected" : ""}>Reserved</option>
                    <option value="CheckIn" ${"CheckIn" eq booking.status ? "selected" : ""}>CheckIn</option>
                    <option value="CheckOut" ${"CheckOut" eq booking.status ? "selected" : ""}>CheckOut</option>
                    <option value="Canceled" ${"Canceled" eq booking.status ? "selected" : ""}>Canceled</option>
                    <option value="Complete" ${"Complete" eq booking.status ? "selected" : ""}>Complete</option>
                </select>


                <input type="submit" name="action" value="Save Changes" formaction="MainController"/>
                <a href="MainController?action=TurnBackReceptionPage">Cancel</a>
            </form>

        </c:if>
        <c:if test="${empty booking}">
            <h1>Không có danh sách Booking!</h1>
        </c:if>
    </body>
</html>