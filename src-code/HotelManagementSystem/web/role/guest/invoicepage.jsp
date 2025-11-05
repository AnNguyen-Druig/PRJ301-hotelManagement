<%-- 
    Document   : invoicepage
    Created on : Oct 20, 2025, 5:43:29 PM
    Author     : ASUS
--%>

<%@page import="DTO.Guest_DTO.ShowRoomDTO"%>
<%@page import="DTO.Basic_DTO.InvoiceDTO"%>
<%@page import="DTO.Basic_DTO.PaymentDTO"%>
<%@page import="DTO.Basic_DTO.GuestDTO"%>
<%@page import="DTO.Basic_DTO.RoomDTO"%>
<%@page import="DAO.Basic_DAO.TaxDAO"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
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
            GuestDTO guest = (GuestDTO) request.getAttribute("GUEST_DETAIL");
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (guest == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
                InvoiceDTO invoice = (InvoiceDTO) request.getAttribute("INVOICE");
                PaymentDTO payment = (PaymentDTO) request.getAttribute("PAYMENT");
                ShowRoomDTO room = (ShowRoomDTO) request.getAttribute("ROOM");
                
                //Lấy VAT 
                TaxDAO taxDAO = new TaxDAO();
                double vat = taxDAO.getTaxValueByTaxName("VAT");
                
                //tiền chưa thuế (vì trong invoice và payment lưu là tiền sau thuế
                double priceBeforeVAT = invoice.getTotalAmount()/(1+vat);

                if (invoice != null && payment != null) {
        %>
        <div style="width:750px;margin:40px auto;background:#fff;padding:35px;border-radius:12px;
             box-shadow:0 2px 10px rgba(0,0,0,0.2);font-family:Arial,sans-serif;">
            <h2 style="text-align:center;color:#222;margin-bottom:25px;">HÓA ĐƠN THANH TOÁN</h2>

            <!-- THÔNG TIN KHÁCH HÀNG -->
            <h3 style="color:#333;border-bottom:2px solid #eee;padding-bottom:5px;">Thông tin khách hàng</h3>
            <table style="width:100%;font-size:15px;border-collapse:collapse;">
                <tr><td style="color:#555;width:35%;">Họ và tên:</td><td><%= guest.getFullName()%></td></tr>
                <tr><td style="color:#555;">Số điện thoại:</td><td><%= guest.getPhone()%></td></tr>
                <tr><td style="color:#555;">Email:</td><td><%= guest.getEmail()%></td></tr>
                <tr><td style="color:#555;">CMND/CCCD:</td><td><%= guest.getIDNumber()  %></td></tr>
            </table>

            <br>

            <!-- THÔNG TIN PHÒNG -->
            <h3 style="color:#333;border-bottom:2px solid #eee;padding-bottom:5px;">Thông tin phòng</h3>
            <table style="width:100%;font-size:15px;border-collapse:collapse;">
                <tr><td style="color:#555;width:35%;">Số phòng:</td><td><%= room.getRoomNumber()%></td></tr>
                <tr><td style="color:#555;">Loại phòng:</td><td><%= room.getTypeName() %></td></tr>
                <tr><td style="color:#555;">Sức chứa:</td><td><%= room.getCapacity() %></td></tr>
            </table>

            <br>

            <!-- THÔNG TIN HÓA ĐƠN -->
            <h3 style="color:#333;border-bottom:2px solid #eee;padding-bottom:5px;">Chi tiết hóa đơn</h3>
            <table style="width:100%;font-size:15px;border-collapse:collapse;">
                <tr><td style="color:#555;width:35%;">Mã hóa đơn:</td><td><%= invoice.getInvoiceID()%></td></tr>
                <tr><td style="color:#555;">Mã đặt phòng:</td><td><%= invoice.getBookingID()%></td></tr>
                <tr><td style="color:#555;">Ngày xuất hóa đơn:</td><td><%= invoice.getIssueDate()%></td></tr>

                <tr><td style="color:#555;">Tổng tiền (chưa thuế):</td>
                    <td><%= String.format("%,.0f VND", priceBeforeVAT).replace(',', '.')%></td></tr>

                <tr><td style="color:#555;">VAT (10%):</td>
                    <td><%= String.format("%,.0f VND", priceBeforeVAT * vat).replace(',', '.')%></td></tr>

                <tr style="border-top:2px solid #333;font-weight:bold;">
                    <td style="color:#000;">TỔNG CỘNG:</td>
                    <td style="color:#000;"><%= String.format("%,.0f VND", invoice.getTotalAmount()).replace(',', '.')%></td>
                </tr>
            </table>

            <br>

            <!-- THÔNG TIN THANH TOÁN -->
            <h3 style="color:#333;border-bottom:2px solid #eee;padding-bottom:5px;">Thông tin thanh toán</h3>
            <table style="width:100%;font-size:15px;border-collapse:collapse;">
                <tr><td style="color:#555;width:35%;">Phương thức thanh toán:</td>
                    <td><%= payment.getPaymentMethod()%></td></tr>

                <tr><td style="color:#555;">Ngày thanh toán:</td>
                    <td><%= payment.getPaymentDate()%></td></tr>

                <tr><td style="color:#555;">Trạng thái thanh toán:</td>
                    <td><%= payment.getStatus()%></td></tr>
            </table>

            <p style="text-align:center;margin-top:40px;color:#555;font-size:14px;">
                Cảm ơn quý khách <b><%= guest.getFullName()%></b> đã sử dụng dịch vụ của chúng tôi 
            </p>

            <div style="text-align:center;margin-top:20px;">
                <button onclick="window.print()" 
                        style="background:#007bff;color:white;border:none;padding:10px 20px;
                        border-radius:6px;cursor:pointer;font-size:15px;">
                    🖨️ In hóa đơn
                </button>
            </div>
            <%
                if(staff != null) {
            %>    
            <a href="MainController?action=TurnBackReceptionPage">Quay lại Reception Page</a>
            <%    
                } else {
            %>
            <a href="MainController?action=gobackGuestPage">Quay lại Guest Page</a>
            <%    
            }
            %>
        </div>
        <%
                } else {
                    request.setAttribute("ERROR", IConstants.ERR_SAVE_PAYMENT_AND_INVOICE);
                    request.getRequestDispatcher(IConstants.CHECKOUT_PAGE).forward(request, response);
                }
            }
        %>   
    </body>




</html>
