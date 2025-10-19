<%@page import="java.util.*"%>
<%@page import="DTO.BookingDTO"%>
<%@page import="DTO.ServiceDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Choose Services</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 16px; }
    .wrap { display: flex; gap: 24px; align-items: flex-start; }
    .col { flex: 1; }
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ddd; padding: 8px; }
    th { background: #f5f5f5; }
    .total { text-align: right; font-weight: bold; }
    .msg { margin: 8px 0; color: #c00; }
    .header { margin-bottom: 12px; }
    input[type=number] { width: 64px; }
    .back { margin-top: 16px; display: inline-block; }
  </style>
</head>
<body>
<div class="header">
    <h2>Chọn dịch vụ cho Booking ${sessionScope.BOOKING_ID}</h2>
</div>

<div class="wrap">
  <!-- Cột trái: tất cả dịch vụ -->
  <div class="col">
    <h3>Tất cả dịch vụ</h3>
    <table>
      <thead>
        <tr>
          <th>ID</th><th>Name</th><th>Type</th><th>Price</th><th>Add</th>
        </tr>
      </thead>
      <tbody>
      <%
        List<ServiceDTO> list = (List<ServiceDTO>) request.getAttribute("ALLSERVICE");
        if (list != null && !list.isEmpty()) {
            for (ServiceDTO s : list) {
      %>
      
      
        <tr>
          <td><%= s.getServiceId() %></td>
          <td><%= s.getServiceName() %></td>
          <td><%= s.getServiceType() %></td>
          <td><%= s.getPrice() %></td>
          <td>
            <form action="MainController" method="post" style="display:inline">
              <!-- Action controller để ghi DB -->
              <a href="AddServiceController?ServiceID=<%=s.getServiceId()%>">add</a>
            </form>
          </td>
        </tr>
      <%
          }
        } else {
      %>
        <tr><td colspan="5" style="text-align:center">Chưa có dữ liệu dịch vụ</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>

  <!-- Cột phải: dịch vụ đã thêm -->
  <div class="col">
    
    <h3>Dịch vụ đã thêm</h3>
    <table>
      <thead>
        <tr><th>ID</th><th>Name</th><th>Type</th><th>Quantity</th><th>Price</th><th>Chỉnh sửa</th></tr>
      </thead>
      <tbody>

        <%
        double GrandTotal = 0;
        String bookingId = (String) session.getAttribute("BOOKING_ID");
        String cartKey = "CART_" + bookingId;
        HashMap<ServiceDTO, Integer> cart = (HashMap) session.getAttribute(cartKey);
        if(cart == null){
            %>
            <tr><td colspan="6" style="text-align:center">None</td></tr>
          <%
        }else{
        double total = 0;
        for (ServiceDTO s : cart.keySet()) {
                total += cart.get(s) * s.getPrice();               
        %>
        <tr><form action="EditServiceController">
                <input type="hidden" name="txtid" value="<%=s.getServiceId() %>">
                <td><%= s.getServiceId() %></td>
                <td><%= s.getServiceName() %></td>
                <td><%= s.getServiceType() %></td>
                <td><input type="number" name="txtquantity" min="1" value="<%=cart.get(s)%>"></td>
                <td><%= s.getPrice() %></td>
            
                <td style="text-align:center"><input type="submit" value="update" name="action">
                    <input type="submit" value="remove" name="action"></td>
            </form>
        </tr>
            <%
              }
              GrandTotal += total;
          }  
        %>
      </tbody>  
      <tfoot>
          <tr>
                <td class="total" colspan="5">Tổng: </td>
                <td style="text-align:center"><%= GrandTotal%>$</td>
            </tr>
      </tfoot>
    </table>
  </div>
</div>

<a class="back" href="MainController?action=getroomservice">⬅ Back to room</a>
</body>
</html>
