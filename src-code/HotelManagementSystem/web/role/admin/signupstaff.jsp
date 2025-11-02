<%-- 
    Document   : signup
    Created on : Oct 9, 2025, 3:17:01 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Trang Đăng Ký Nhân Viên</title>
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
        <h1 style="text-align: center;">Đăng Ký Nhân Viên</h1>

        <div class="container">
            <form action="MainController" method="POST">
                <h3>Tài Khoản</h3>
                <div class="mb-3">
                    <label for="staff_username" class="form-label">Tên đăng nhập <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_USERNAME}</span>
                    </label>
                    <input type="text" class="form-control" name="staff_username" required="" value="${param.staff_username}">
                </div>
                <div class="mb-3">
                    <label for="staff_password" class="form-label">Mật khẩu <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_PASSWORD}</span>
                    </label>
                    <input type="password" class="form-control" name="staff_password" id="staff_password" required="" onkeyup="kiemTraMatKhau()" value="${param.staff_password}">
                </div>
                <div class="mb-3">
                    <label for="staff_password_again" class="form-label">Nhập lại mật khẩu <span class="red">*</span><span class="red" id="msg"></span></label>
                    <input type="password" class="form-control" name="staff_password_again" id="staff_password_again" required="" onkeyup="kiemTraMatKhau()" value="${param.staff_password_again}">
                </div>
                <h3>Thông Tin Nhân Viên</h3>
                <div class="mb-3">
                    <label for="staff_fullname" class="form-label">Họ và tên <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_FULLNAME}</span>
                    </label>
                    <input type="text" class="form-control" name="staff_fullname" required="" value="${param.staff_fullname}">
                </div>
                <div class="mb-3">
                    <label for="staff_phone" class="form-label">Số điện thoại <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_PHONE}</span>
                    </label>
                    <input type="tel" class="form-control" name="staff_phone" required="" value="${param.staff_phone}">
                </div>
                <div class="mb-3">
                    <label for="staff_email" class="form-label">Email <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_EMAIL}</span>
                    </label>
                    <input type="email" class="form-control" name="staff_email" required="" value="${param.staff_email}">
                </div>
                <div class="mb-3">
                    <label for="staff_dateofbirth" class="form-label">Ngày sinh <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_DATEOFBIRTH}</span>
                    </label>
                    <input type="date" class="form-control" name="staff_dateofbirth" required="" value="${param.staff_dateofbirth}">
                </div>
                <div class="mb-3">
                    <label for="staff_idnumber" class="form-label">CCCD/CMND <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_IDNUMBER}</span>
                    </label>
                    <input type="number" class="form-control" name="staff_idnumber" required="" value="${param.staff_idnumber}">
                </div>
                <div class="mb-3">
                    <label for="staff_address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" name="staff_address" value="${param.staff_address}">
                </div>
                <div class="mb-3">
                    <label for="staff_role" class="form-label">Vai Trò</label>
                    <select id="staff_role" name="staff_role" required="">
                        <option value="">Chọn vai trò</option>
                        <option value="Receptionist" ${param.staff_role == 'Receptionist' ? 'selected' : ''}>Lễ tân</option>
                        <option value="Manager" ${param.staff_role == 'Manager' ? 'selected' : ''}>Quản lý</option>
                        <option value="Housekeeping" ${param.staff_role == 'Housekeeping' ? 'selected' : ''}>Nhân viên buồng phòng</option>
                        <option value="ServiceStaff" ${param.staff_role == 'ServiceStaff' ? 'selected' : ''}>Nhân viên dịch vụ</option>
                        <option value="Admin" ${param.staff_role == 'Admin' ? 'selected' : ''}>Quản trị viên</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label>Trạng thái</label> </br>
                    
                    <input type="radio" name="staff_status" id="status_active" required="" value="Active">
                    <label for="status_active">Active</label>
                    
                    <input type="radio" name="staff_status" id="status_inactive" value="Inactive">
                    <label for="status_inactive">Inactive</label>
                </div>
         
                <button class="btn btn-primary form-control" type="submit" value="<%= IConstants.AC_SIGN_UP_STAFF%>" name="action">Đăng ký nhân viên</button>
            </form>
        </div>
    </body>

    <script>
        //Dùng để kiểm tra 2 mật khẩu có khớp với nhau không
        function kiemTraMatKhau() {
            password = document.getElementById("staff_password").value;
            password_again = document.getElementById("staff_password_again").value;
            if (password !== password_again) {
                document.getElementById("msg").innerHTML = "Mật khẩu không khớp!";
                return false;
            } else {
                document.getElementById("msg").innerHTML = "";
                return true;
            }
        }
    </script>
</html>
