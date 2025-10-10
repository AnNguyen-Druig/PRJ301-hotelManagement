<%-- 
    Document   : signup
    Created on : Oct 9, 2025, 3:17:01 PM
    Author     : Admin
--%>

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
        <h1>Đăng Ký Thành Viên</h1>
        <!--        <form action="MainController" method="post">
                    <p>Username: <input type="text" name="guest_username"></p>
                    <p>Password: <input type="password" name="guest_password"></p>
                    <p>Fullname: <input type="text" name="guest_fullname"></p>
                    <p>Phone: <input type="tel" name="guest_phone"></p>
                    <p>Email: <input type="email" name="guest_email"></p>
                    <p>Address: <input type="text" name="guest_address"></p>
                    <p>Date Of Birth: <input type="date" name="guest_dateofbirth"></p>
                    <p>ID Number: <input type="number" name="guest_idnumber" min="10" max="12"></p>
                </form>-->

        <form action="MainController" method="post">
            <h3>Tài Khoản</h3>
            <div class="mb-3">
                <label for="guest_username" class="form-label">Username <span class="red">*</span></label>
                <input type="text" class="form-control" name="guest_username" required="">
            </div>
            <div class="mb-3">
                <label for="guest_password" class="form-label">Password <span class="red">*</span></label>
                <input type="password" class="form-control" name="guest_password" id="guest_password" required="" onkeyup="kiemTraMatKhau()">
            </div>
            <div class="mb-3">
                <label for="guest_password_again" class="form-label">Password Again <span class="red">*</span><span class="red" id="msg"></span></label>
                <input type="password" class="form-control" name="guest_password_again" id="guest_password_again" required="" onkeyup="kiemTraMatKhau()">
            </div>
            <h3>Thông Tin Khách Hàng</h3>
            <div class="mb-3">
                <label for="guest_password" class="form-label">Fullname <span class="red">*</span></label>
                <input type="text" class="form-control" name="guest_fullname" required="">
            </div>
            <div class="mb-3">
                <label for="guest_phone" class="form-label">Phone <span class="red">*</span></label>
                <input type="tel" class="form-control" name="guest_phone" required="">
            </div>
            <div class="mb-3">
                <label for="guest_email" class="form-label">Email <span class="red">*</span></label>
                <input type="email" class="form-control" name="guest_email" required="">
            </div>
            <div class="mb-3">
                <label for="guest_dateofbirth" class="form-label">Date Of Birth <span class="red">*</span></label>
                <input type="date" class="form-control" name="guest_dateofbirth" required="">
            </div>
            <div class="mb-3">
                <label for="guest_idnumber" class="form-label">ID Number <span class="red">*</span></label>
                <input type="number" class="form-control" name="guest_idnumber" min="10" max="12" required="">
            </div>
            <div class="mb-3">
                <label for="guest_address" class="form-label">Address</label>
                <input type="text" class="form-control" name="guest_address">
            </div>
            <div class="mb-3">
                <label for="condition" class="form-label">Đồng ý với các điều khoản của Hotel <span class="red">*</span></label>
                <input type="checkbox" class="form-check-input" name="condition" required="" onchange="kiemTraDongYCondition()">
            </div>
            <div class="mb-3">
                <label for="nhanemail" class="form-label">Đồng ý nhận email thông báo khuyến mãi</label>
                <input type="checkbox" class="form-check-input" name="nhanemail">
            </div>

            <input class="btn btn-primary form-control" type="submit" value="Sign Up" name="submit" id="submit" style="visibility: hidden">
        </form>
    </body>
    
    <script>
        //Dùng để kiểm tra 2 mật khẩu có khớp với nhau không
        function kiemTraMatKhau() {
            password = document.getElementById("guest_password").value;
            password_again = document.getElementById("guest_password_again").value;
            if(password !== password_again) {
                document.getElementById("msg").innerHTML = "Mật khẩu và mật khẩu nhập lại không khớp!";
                return false;
            } else {
                document.getElementById("msg").innerHTML = "";
                return true;
            }
        }
        
        function kiemTraDongYCondition() {
            dongYCondition = document.getElementById("condition");
            if(dongYCondition.checked == true) {
                document.getElementById("submit").style.visibility="visible";
            } else {
                document.getElementById("submit").style.visibility="hidden";
            } 
        }
        
    </script>
</html>
