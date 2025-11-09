<%--
    Document : signup
    Created on : Oct 9, 2025, 3:17:01 PM
    Author : Admin
--%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Đăng Ký Thành Viên</title>

        <!-- Bootstrap CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js"></script>

        <!-- CSS INTERNAL - ĐỒNG BỘ VỚI style.css -->
        <style>
            /* ===== CƠ BẢN ===== */
            body {
                background-color: #f8f9fa;
                color: #333333;
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 0;
            }

            h1 {
                color: #004a99;
                font-size: 2.2em;
                text-align: center;
                margin: 50px 0 40px;
                padding-bottom: 14px;
                border-bottom: 4px solid #004a99;
                display: inline-block;
                min-width: 400px;
                position: relative;
                left: 50%;
                transform: translateX(-50%);
                font-weight: bold;
            }

            /* ===== NỘI DUNG CHÍNH ===== */
            .signup-container {
                max-width: 800px;
                margin: 30px auto;
                background-color: #ffffff;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
            }

            .form-section {
                background-color: #f8fdff;
                padding: 25px;
                border-radius: 12px;
                border-left: 6px solid #004a99;
                margin-bottom: 30px;
                box-shadow: 0 3px 12px rgba(0, 74, 153, 0.1);
            }

            .form-section h3 {
                color: #004a99;
                font-size: 1.5em;
                margin: 0 0 20px 0;
                font-weight: bold;
                text-align: center;
            }

            .form-label {
                font-weight: bold;
                color: #004a99;
            }

            .red {
                color: #dc3545;
                font-weight: bold;
            }

            .form-control {
                border-radius: 8px;
                padding: 12px 16px;
                font-size: 1em;
                border: 1px solid #ccc;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #004a99;
                box-shadow: 0 0 0 0.2rem rgba(0, 74, 153, 0.25);
            }

            .form-check-input:checked {
                background-color: #004a99;
                border-color: #004a99;
            }

            /* ===== NÚT SUBMIT ===== */
            #submit {
                background-color: #004a99;
                color: white;
                font-weight: bold;
                font-size: 1.1em;
                padding: 14px 30px;
                border-radius: 10px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(0, 74, 153, 0.2);
            }

            #submit:hover {
                background-color: #003366;
                transform: translateY(-2px);
                box-shadow: 0 6px 14px rgba(0, 74, 153, 0.3);
            }

            /* ===== THÔNG BÁO ===== */
            .error-message {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
                padding: 14px;
                border-radius: 8px;
                text-align: center;
                margin: 20px 0;
                font-weight: bold;
            }

            .success-message {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
                padding: 14px;
                border-radius: 8px;
                text-align: center;
                margin: 20px 0;
                font-weight: bold;
            }

            /* ===== LIÊN KẾT ===== */
            .back-link {
                display: block;
                text-align: center;
                margin: 30px 0 20px;
            }

            .back-link a {
                display: inline-block;
                background-color: #004a99;
                color: white;
                text-decoration: none;
                padding: 12px 28px;
                border-radius: 8px;
                font-weight: bold;
                font-size: 1em;
                transition: all 0.3s ease;
                box-shadow: 0 3px 8px rgba(0, 74, 153, 0.2);
            }

            .back-link a:hover {
                background-color: #003366;
                transform: translateY(-2px);
                box-shadow: 0 5px 12px rgba(0, 74, 153, 0.3);
            }

            /* ===== MẬT KHẨU KHÔNG KHỚP ===== */
            #msg {
                color: #dc3545;
                font-weight: bold;
                font-size: 0.9em;
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 768px) {
                .signup-container {
                    margin: 20px;
                    padding: 25px;
                }

                h1 {
                    font-size: 1.8em;
                    min-width: 300px;
                }

                .form-section {
                    padding: 20px;
                }

                .form-section h3 {
                    font-size: 1.3em;
                }

                .form-control {
                    padding: 10px 14px;
                }

                #submit {
                    padding: 12px 24px;
                    font-size: 1em;
                }
            }

            @media (max-width: 576px) {
                h1 {
                    font-size: 1.6em;
                }

                .form-label {
                    font-size: 0.95em;
                }

                .back-link a {
                    padding: 10px 20px;
                    font-size: 0.95em;
                }
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
            if (idNumber == null)
                idNumber = "";
        %>

        <h1>Đăng Ký Thành Viên</h1>

        <div class="container">
            <div class="signup-container">

                <form action="MainController" method="post">

                    <!-- TÀI KHOẢN -->
                    <div class="form-section">
                        <h3>Tài Khoản</h3>

                        <div class="mb-3">
                            <label for="guest_username" class="form-label">
                                Tên đăng nhập <span class="red">*</span>
                                <span class="red"><%= errUsername%></span>
                            </label>
                            <input type="text" class="form-control" name="guest_username" required value="<%= username%>">
                        </div>

                        <div class="mb-3">
                            <label for="guest_password" class="form-label">
                                Mật khẩu <span class="red">*</span>
                                <span class="red"><%= errPassword%></span>
                            </label>
                            <input type="password" class="form-control" name="guest_password" id="guest_password" required onkeyup="kiemTraMatKhau()">
                        </div>

                        <div class="mb-3">
                            <label for="guest_password_again" class="form-label">
                                Nhập lại mật khẩu <span class="red">*</span>
                                <span class="red" id="msg"></span>
                            </label>
                            <input type="password" class="form-control" name="guest_password_again" id="guest_password_again" required onkeyup="kiemTraMatKhau()">
                        </div>
                    </div>

                    <!-- THÔNG TIN KHÁCH HÀNG -->
                    <div class="form-section">
                        <h3>Thông Tin Khách Hàng</h3>

                        <div class="mb-3">
                            <label for="guest_fullname" class="form-label">
                                Họ và tên <span class="red">*</span>
                                <span class="red"><%= errFullname%></span>
                            </label>
                            <input type="text" class="form-control" name="guest_fullname" required value="<%= fullname%>">
                        </div>

                        <div class="mb-3">
                            <label for="guest_phone" class="form-label">
                                Số điện thoại <span class="red">*</span>
                                <span class="red"><%= errPhone%></span>
                            </label>
                            <input type="tel" class="form-control" name="guest_phone" required value="<%= phone%>">
                        </div>

                        <div class="mb-3">
                            <label for="guest_email" class="form-label">
                                Email <span class="red">*</span>
                                <span class="red"><%= errEmail%></span>
                            </label>
                            <input type="email" class="form-control" name="guest_email" required value="<%= email%>">
                        </div>

                        <div class="mb-3">
                            <label for="guest_dateofbirth" class="form-label">Ngày sinh <span class="red">*</span></label>
                            <input type="date" class="form-control" name="guest_dateofbirth" required value="<%= dateOfBirth%>">
                        </div>

                        <div class="mb-3">
                            <label for="guest_idnumber" class="form-label">
                                CCCD/CMND <span class="red">*</span>
                                <span class="red"><%= errIdNumber%></span>
                            </label>
                            <input type="text" class="form-control" name="guest_idnumber" required value="<%= idNumber%>">
                        </div>

                        <div class="mb-3">
                            <label for="guest_address" class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" name="guest_address" value="<%= address%>">
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" name="condition" id="condition" required onchange="kiemTraDongYCondition()">
                            <label class="form-check-label" for="condition">
                                Đồng ý với các điều khoản của Hotel <span class="red">*</span>
                            </label>
                        </div>

                        <button type="submit" class="btn form-control" name="action" value="Signup" id="submit" style="visibility: hidden;">
                            Đăng Ký Ngay
                        </button>
                    </div>
                </form>

                <!-- THÔNG BÁO LỖI -->
                <% if (!errorMsg.isEmpty()) {%>
                <div class="error-message"><%= errorMsg%></div>
                <% } %>

                <!-- THÀNH CÔNG -->
                <%
                    String succMsg = (String) request.getAttribute("SUCCESS");
                    StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
                    if (succMsg != null) {
                %>
                <div class="success-message"><%= succMsg%></div>
                <% } %>

                <!-- LIÊN KẾT QUAY LẠI -->
                <div class="back-link">
                    <%
                        if (staff != null) {
                    %>
                    <a href="MainController?action=TurnBackReceptionPage">Quay lại trang của Lễ tân</a>
                    <% } else { %>
                    <a href="MainController?action=Login Member">Quay về trang đăng nhập</a>
                    <% }%>
                </div>

            </div>
        </div>

        <!-- JavaScript kiểm tra form -->
        <script>
            function kiemTraMatKhau() {
                const password = document.getElementById("guest_password").value;
                const passwordAgain = document.getElementById("guest_password_again").value;
                const msg = document.getElementById("msg");

                if (password !== passwordAgain) {
                    msg.innerHTML = "Mật khẩu không khớp!";
                    return false;
                } else {
                    msg.innerHTML = "";
                    return true;
                }
            }

            function kiemTraDongYCondition() {
                const condition = document.getElementById("condition").checked;
                document.getElementById("submit").style.visibility = condition ? "visible" : "hidden";
            }
        </script>
    </body>
</html>