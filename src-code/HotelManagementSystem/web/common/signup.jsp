<%-- 
    Document   : signup
    Created on : Oct 9, 2025, 3:17:01 PM
    Author     : Admin
--%>

<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Trang Đăng Ký Thành Viên</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js" integrity="sha384-G/EV+4j2dNv+tEPo3++6LCgdCROaejBqfUeNjuKAiuXbjrxilcCdDz6ZAVfHWe1Y" crossorigin="anonymous"></script>
        <style>
            .red {
                color: red;
            }
        </style>
    </head>
    <body>
        <%
            String errorMsg = (String) request.getAttribute("ERROR");
            if (errorMsg == null) {
                errorMsg = "";
            }

            String errUsername = (String) request.getAttribute("ERROR_USERNAME");
            if (errUsername == null) {
                errUsername = "";
            }

            String errPassword = (String) request.getAttribute("ERROR_PASSWORD");
            if (errPassword == null) {
                errPassword = "";
            }

            String errFullname = (String) request.getAttribute("ERROR_FULLNAME");
            if (errFullname == null) {
                errFullname = "";
            }

            String errPhone = (String) request.getAttribute("ERROR_PHONE");
            if (errPhone == null) {
                errPhone = "";
            }

            String errEmail = (String) request.getAttribute("ERROR_EMAIL");
            if (errEmail == null) {
                errEmail = "";
            }

            String errIdNumber = (String) request.getAttribute("ERROR_IDNUMBER");
            if (errIdNumber == null) {
                errIdNumber = "";
            }

            String username = (String) request.getAttribute("username");
            if (username == null) {
                username = "";
            }

            String fullname = (String) request.getAttribute("fullname");
            if (fullname == null) {
                fullname = "";
            }

            String phone = (String) request.getAttribute("phone");
            if (phone == null) {
                phone = "";
            }

            String email = (String) request.getAttribute("email");
            if (email == null) {
                email = "";
            }

            String address = (String) request.getAttribute("address");
            if (address == null) {
                address = "";
            }

            String dateOfBirth = (String) request.getAttribute("dateOfBirth");
            if (dateOfBirth == null) {
                dateOfBirth = "";
            }

            String idNumber = (String) request.getAttribute("idNumber");
            if (idNumber == null) {
                idNumber = "";
            }
        %>

        <h1 style="text-align: center;">Đăng Ký Thành Viên</h1>

        <div class="container">
            <form action="MainController" method="post">
                <h3>Tài Khoản</h3>
                <div class="mb-3">
                    <label for="guest_username" class="form-label">Tên đăng nhập <span class="red">*</span>
                        <span class="red"><%= errUsername%></span>
                    </label>
                    <input type="text" class="form-control" name="guest_username" required="" value="<%=username%>">
                </div>
                <div class="mb-3">
                    <label for="guest_password" class="form-label">Mật khẩu <span class="red">*</span>
                        <span class="red"><%= errPassword%></span>
                    </label>
                    <input type="password" class="form-control" name="guest_password" id="guest_password" required="" onkeyup="kiemTraMatKhau()">
                </div>
                <div class="mb-3">
                    <label for="guest_password_again" class="form-label">Nhập lại mật khẩu <span class="red">*</span><span class="red" id="msg"></span></label>
                    <input type="password" class="form-control" name="guest_password_again" id="guest_password_again" required="" onkeyup="kiemTraMatKhau()">
                </div>
                <h3>Thông Tin Khách Hàng</h3>
                <div class="mb-3">
                    <label for="guest_fullname" class="form-label">Họ và tên <span class="red">*</span>
                        <span class="red"><%= errFullname%></span>
                    </label>
                    <input type="text" class="form-control" name="guest_fullname" required="" value="<%=fullname%>">
                </div>
                <div class="mb-3">
                    <label for="guest_phone" class="form-label">Số điện thoại <span class="red">*</span>
                        <span class="red"><%= errPhone%></span>
                    </label>
                    <input type="tel" class="form-control" name="guest_phone" required="" value="<%=phone%>">
                </div>
                <div class="mb-3">
                    <label for="guest_email" class="form-label">Email <span class="red">*</span>
                        <span class="red"><%= errEmail%></span>
                    </label>
                    <input type="email" class="form-control" name="guest_email" required="" value="<%=email%>">
                </div>
                <div class="mb-3">
                    <label for="guest_dateofbirth" class="form-label">Ngày sinh <span class="red">*</span></label>
                    <input type="date" class="form-control" name="guest_dateofbirth" required="" value="<%=dateOfBirth%>">
                </div>
                <div class="mb-3">
                    <label for="guest_idnumber" class="form-label">CCCD/CMND <span class="red">*</span>
                        <span class="red"><%= errIdNumber%></span>
                    </label>
                    <input type="number" class="form-control" name="guest_idnumber" required="" value="<%=idNumber%>">
                </div>
                <div class="mb-3">
                    <label for="guest_address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" name="guest_address" value="<%=address%>">
                </div>
                <div class="mb-3">
                    <label for="condition" class="form-label">Đồng ý với các điều khoản của Hotel <span class="red">*</span></label>
                    <input type="checkbox" class="form-check-input" name="condition" id="condition" required="" onchange="kiemTraDongYCondition()">
                </div>

                <input class="btn btn-primary form-control" type="submit" value="Signup" name="action" id="submit" style="visibility: hidden">
            </form>
            <p><%= errorMsg%></p>

            <%
                String succMsg = (String) request.getAttribute("SUCCESS");
                StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
                if (succMsg != null) {
            %>
            <span><%= succMsg%></span>
            <%}%>
            
            <%
                if (staff != null) {
            %>
            <a href="MainController?action=TurnBackReceptionPage">Quay lại trang của Lễ tân</a>
            <%} else {%>
            <a href="MainController?action=Login Member">Quay về trang đăng nhập</a>
            <%}%>
        </div>
    </body>

    <script>
        //Dùng để kiểm tra 2 mật khẩu có khớp với nhau không
        function kiemTraMatKhau() {
            password = document.getElementById("guest_password").value;
            password_again = document.getElementById("guest_password_again").value;
            if (password !== password_again) {
                document.getElementById("msg").innerHTML = "Mật khẩu không khớp!";
                return false;
            } else {
                document.getElementById("msg").innerHTML = "";
                return true;
            }
        }

        function kiemTraDongYCondition() {
            dongYCondition = document.getElementById("condition");
            if (dongYCondition.checked === true) {
                document.getElementById("submit").style.visibility = "visible";
            } else {
                document.getElementById("submit").style.visibility = "hidden";
            }
        }
    </script>
</html>
