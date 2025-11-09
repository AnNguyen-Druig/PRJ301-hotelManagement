<%-- 
    Document   : checkoutpage
    Created on : Oct 20, 2025, 3:31:34 PM
    Author     : ASUS
--%>

<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="DTO.Basic_DTO.GuestDTO"%>
<%@page import="DTO.Guest_DTO.BookingRoomDetailDTO"%>
<%@page import="DTO.Basic_DTO.BookingDTO"%>
<%@page import="DAO.Basic_DAO.RoomDAO"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="DTO.Basic_DTO.BookingServiceDTO"%>
<%@page import="DAO.Basic_DAO.ServiceDAO"%>
<%@page import="DTO.Basic_DTO.ServiceDTO"%>
<%@page import="DAO.Basic_DAO.TaxDAO"%>
<%@page import="mylib.IConstants"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styles.css">
    </head>
    <style>
        

        h2 {
            color: #004a99;
            border-bottom: 3px solid #004a99;
            padding-bottom: 12px;
            margin-bottom: 20px;
            font-size: 24px;
        }

        h3 {
            color: #004a99;
            margin: 25px 0 15px;
            font-size: 20px;
        }

        h4 {
            color: #d9534f;
            font-weight: bold;
            margin: 15px 0;
            font-size: 18px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 15px;
            background: #fff;
        }

        th {
            background-color: #004a99;
            color: white;
            padding: 14px 12px;
            text-align: left;
            font-weight: bold;
            font-size: 15px;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
            vertical-align: middle;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #e6f3ff;
            transition: background 0.3s;
        }

        .price {
            font-weight: bold;
            color: #004a99;
        }

        .total {
            font-size: 18px;
            font-weight: bold;
            color: #d9534f;
            text-align: right;
            margin: 15px 0;
        }

        .error {
            background: #f2dede;
            color: #a94442;
            padding: 12px;
            border-radius: 6px;
            margin: 15px 0;
            font-weight: bold;
        }

        .payment-options {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin: 20px 0;
        }

        .payment-options label {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 16px;
            cursor: pointer;
            padding: 8px;
            border-radius: 6px;
            transition: background 0.2s;
        }

        .payment-options label:hover {
            background-color: #f0f8ff;
        }

        .payment-options input[type="radio"] {
            margin: 0;
        }

        button {
            background-color: #004a99;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin: 10px 5px 10px 0;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #003366;
        }

        .btn-secondary {
            background-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .footer-actions {
            margin-top: 30px;
            text-align: center;
        }

        .highlight {
            background-color: #fff3cd;
            padding: 15px;
            border-radius: 8px;
            border-left: 5px solid #ffc107;
            margin: 20px 0;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
                margin: 15px;
            }
            table, th, td {
                font-size: 14px;
            }
            .payment-options label {
                font-size: 15px;
            }
        }
    </style>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <% GuestDTO guest = (GuestDTO) session.getAttribute("USER");
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (guest == null && staff == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
        %>  
        <h2>Bạn cần thanh toán trước khi checkout: </h2>
        <h3>Tiền phòng</h3>
        <%
            BookingRoomDetailDTO bookingRoomDetail = (BookingRoomDetailDTO) request.getAttribute("BOOKING_ROOM");
            double roomPrice = bookingRoomDetail.getPricePerNight();
            //Tính số ngày
            // 1. Chuyển đổi sang LocalDate
            LocalDate checkInLocalDate = bookingRoomDetail.getCheckInDate().toLocalDate();
            LocalDate checkOutLocalDate = bookingRoomDetail.getCheckOutDate().toLocalDate();

            // 2. Tính số ngày (số đêm)
            long numberOfNights = ChronoUnit.DAYS.between(checkInLocalDate, checkOutLocalDate);
        %>
        <!-- khi thanh toán thất bại sẽ thông báo lỗi ở đây --> 
        ${requestScope.ERROR}
        <table>
            <tr>
                <th>Số phòng</th>
                <th>Loại phòng</th>
                <th>Họ và tên người đặt phòng</th>
                <th>Ngày check-in</th>
                <th>Ngày check-out</th>
                <th>Ngày đặt phòng</th>
                <th>Số ngày ở</th>
                <th>Giá tiền/1 đêm</th>
            </tr>
            <tr>
                <td><%= bookingRoomDetail.getRoomNumber()%></td>
                <td><%= bookingRoomDetail.getRoomType()%></td>
                <td><%= bookingRoomDetail.getGuestName()%></td>
                <td><%= bookingRoomDetail.getCheckInDate()%></td>
                <td><%= bookingRoomDetail.getCheckOutDate()%></td>
                <td><%= bookingRoomDetail.getBookingDate()%></td>
                <td><%= numberOfNights%></td>
                <td><%= String.format("%,.0f VND", roomPrice).replace(',', '.')%></td>
            </tr>
        </table>
        <%
            double totalRoom = roomPrice * numberOfNights;
        %>
        <h4>Tổng tiền phòng là: <%= String.format("%,.0f VND", totalRoom).replace(',', '.')%></h4>


        <!-- ==================Phần BOOKING_SERVICE========================-->


        <h3>Tiền dịch vụ</h3>
        <%
            ArrayList<BookingServiceDTO> listBookingService = (ArrayList<BookingServiceDTO>) request.getAttribute("LIST_BOOKING_SERVICE");
            double totalService = 0;
            if (listBookingService == null || listBookingService.isEmpty()) {
        %>
        <h4>Không sử dụng dịch vụ</h4>
        <%
        } else {
        %>
        <table>
            <tr>
                <th>Tên dịch vụ</th>
                <th>Loại dịch vụ</th>
                <th>Ngày đặt dịch vụ</th>
                <th>Số lượng</th>
                <th>Giá tiền/1 phần</th>
                <th>Tiền cần thanh toán</th>
            </tr>
            <%   for (BookingServiceDTO bs : listBookingService) {
                    ServiceDAO serviceDAO = new ServiceDAO();
                    ServiceDTO service = serviceDAO.getService(bs.getServiceID());
                    double servicePrice = service.getPrice();
                    double pricePerService = servicePrice * bs.getQuantity();
                    totalService += pricePerService;
            %>
            <tr>
                <td><%= service.getServiceName()%></td>
                <td><%= service.getServiceType()%></td>
                <td><%= bs.getServiceDate()%></td>
                <td><%= bs.getQuantity()%></td>
                <td><%= String.format("%,.0f VND", servicePrice).replace(',', '.')%></td>
                <td><%= String.format("%,.0f VND", pricePerService).replace(',', '.')%></td>
            </tr>
            <%}%>
        </table>
        <%
            }
        %>
        <h4>Tổng tiền dịch vụ là: <%= String.format("%,.0f VND", totalService).replace(',', '.')%></h4>

        <%
            double total = totalRoom + totalService;

            //lấy VAT
            TaxDAO taxDAO = new TaxDAO();
            double VAT = taxDAO.getTaxValueByTaxName("VAT");
            double totalAfterVAT = (total * VAT) + total;
        %>
        <h3>TỔNG TIỀN CẦN THANH TOÁN (CHƯA TÍNH VAT): <%= String.format("%,.0f VND", total).replace(',', '.')%></h3>
        <h3>VAT: <%=  String.format("%,.0f VND", total * VAT).replace(',', '.')%> </h3>
        <h3>TỔNG TIỀN CẦN THANH TOÁN (ĐÃ TÍNH VAT): <%= String.format("%,.0f VND", totalAfterVAT).replace(',', '.')%></h3>
        <h3>Chọn phương thức thanh toán:</h3>

        <form action="MainController" method="post">
            <div>
                <input type="radio" id="cash" name="paymentMethod" value="Cash" checked>
                <label for="cash">Tiền mặt (Cash)</label>
            </div>

            <div>
                <input type="radio" id="credit" name="paymentMethod" value="Credit Card">
                <label for="credit">Thẻ tín dụng (Credit Card)</label>
            </div>

            <div>
                <input type="radio" id="debit" name="paymentMethod" value="Debit Card">
                <label for="debit">Thẻ ghi nợ (Debit Card)</label>
            </div>

            <div>
                <input type="radio" id="online" name="paymentMethod" value="Online">
                <label for="online">Thanh toán trực tuyến (Online)</label>
            </div>

            <br>
            <input type="hidden" name="bookingID" value="<%= bookingRoomDetail.getBookingID()%>">
            <input type="hidden" name="total" value="<%= totalAfterVAT%>">
            <button type="submit" name="action" value="<%= IConstants.AC_SAVE_PAYMENT_AND_INVOICE%>">Xác nhận thanh toán</button>
        </form> </br>
        <% if (staff != null) {
        %>
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="<%= IConstants.AC_TURNBACK_RECEPTION%>">Quay về trang Receptionist</button>
        </form>
        <%
        } else {
        %>
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="<%= IConstants.AC_GO_BACK_GUEST_PAGE%>">Quay về trang Guest</button>
        </form>
        <%
                }
            }%>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
