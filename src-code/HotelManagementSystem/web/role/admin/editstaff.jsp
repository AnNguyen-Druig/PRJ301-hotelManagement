<%-- 
    Document   : editstaff
    Created on : Nov 3, 2025, 1:35:35 PM
    Author     : ASUS
--%>

<%@page import="mylib.IConstants"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
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
            .green {
                color: green;
            }
            .orange {
                color: orange
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <%
            StaffDTO staffsession = (StaffDTO) session.getAttribute("STAFF");
            if (staffsession == null) {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            } else {
        %>
        <h1 style="text-align: center;">Cập Nhập Thông Tin Nhân Viên</h1>
        <h4 class="green">${requestScope.SUCCESS_MSG}</h4>
        <h4 class="red">${requestScope.ERROR_MSG}</h4>

        <div class="container">
            <form action="MainController" method="POST">
                <h3>Tài Khoản</h3>
                <div class="mb-3">
                    <label for="staff_username" class="form-label">Tên đăng nhập <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_USERNAME}</span>
                    </label>
                    <input type="text" class="form-control" name="staff_username" required="" value="${param.staff_username != null ? param.staff_username : requestScope.STAFF.userName}">
                </div>
                <div class="mb-3">
                    <label for="staff_password" class="form-label">Mật khẩu <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_PASSWORD}</span>
                    </label>
                    <input type="password" class="form-control" name="staff_password" id="staff_password" required="" onkeyup="kiemTraMatKhau()" value="${param.staff_password != null ? param.staff_password : requestScope.STAFF.password}">
                </div>
                <div class="mb-3">
                    <label for="staff_password_again" class="form-label">Nhập lại mật khẩu <span class="red">*</span><span class="red" id="msg"></span></label>
                    <input type="password" class="form-control" name="staff_password_again" id="staff_password_again" required="" onkeyup="kiemTraMatKhau()" value="${param.staff_password_again != null ? param.staff_password_again : requestScope.STAFF.password}">
                </div>
                <h3>Thông Tin Nhân Viên</h3>
                <div class="mb-3">
                    <label for="staff_fullname" class="form-label">Họ và tên <span class="orange">* Không cập nhật họ và tên</span>
                        <span class="red">${requestScope.ERROR_FULLNAME}</span>
                    </label>
                    <input type="text" class="form-control" name="staff_fullname" required="" readonly="" value="${param.staff_fullname != null ? param.staff_fullname : requestScope.STAFF.fullName}">
                </div>
                <div class="mb-3">
                    <label for="staff_phone" class="form-label">Số điện thoại <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_PHONE}</span>
                    </label>
                    <input type="tel" class="form-control" name="staff_phone" required="" value="${param.staff_phone != null ? param.staff_phone : requestScope.STAFF.phone}">
                </div>
                <div class="mb-3">
                    <label for="staff_email" class="form-label">Email <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_EMAIL}</span>
                    </label>
                    <input type="email" class="form-control" name="staff_email" required="" value="${param.staff_email  != null ? param.staff_email : requestScope.STAFF.email}">
                </div>
                <div class="mb-3">
                    <label for="staff_dateofbirth" class="form-label">Ngày sinh <span class="red">*</span>
                        <span class="red">${requestScope.ERROR_DATEOFBIRTH}</span>
                    </label>
                    <input type="date" class="form-control" name="staff_dateofbirth" required="" value="${param.staff_dateofbirth  != null ? param.staff_dateofbirth : requestScope.STAFF.dateOfBirth}">
                </div>
                <div class="mb-3">
                    <label for="staff_idnumber" class="form-label">CCCD/CMND <span class="orange">*Không cập nhật CCCD</span>
                        <span class="red">${requestScope.ERROR_IDNUMBER}</span>
                    </label>
                    <input type="number" class="form-control" name="staff_idnumber" required="" readonly="" value="${param.staff_idnumber != null ? param.staff_idnumber : requestScope.STAFF.idNumber}">
                </div>
                <div class="mb-3">
                    <label for="staff_address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" name="staff_address" value="${param.staff_address  != null ? param.staff_address : requestScope.STAFF.address}">
                </div>
                <div class="mb-3">
                    <label for="staff_role" class="form-label">Vai Trò</label>
                    <select id="staff_role" name="staff_role" required="">
                        <option value="">Chọn vai trò</option>
                        <option value="Receptionist" ${(param.staff_role != null ? param.staff_role : requestScope.STAFF.role) == 'Receptionist' ? 'selected' : ''}>Lễ tân</option>
                        <option value="Manager" ${(param.staff_role != null ? param.staff_role : requestScope.STAFF.role) == 'Manager' ? 'selected' : ''}>Quản lý</option>
                        <option value="Housekeeping" ${(param.staff_role != null ? param.staff_role : requestScope.STAFF.role) == 'Housekeeping' ? 'selected' : ''}>Nhân viên buồng phòng</option>
                        <option value="ServiceStaff" ${(param.staff_role != null ? param.staff_role : requestScope.STAFF.role) == 'ServiceStaff' ? 'selected' : ''}>Nhân viên dịch vụ</option>
                        <option value="Admin" ${(param.staff_role != null ? param.staff_role : requestScope.STAFF.role) == 'Admin' ? 'selected' : ''}>Quản trị viên</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label>Trạng thái</label> </br>

                    <input type="radio" name="staff_status" id="status_active" required="" value="Active" ${(param.staff_status != null ? param.staff_status : requestScope.STAFF.status) == 'Active' ? 'checked' : ''}>
                    <label for="status_active">Active</label>

                    <input type="radio" name="staff_status" id="status_inactive" value="Inactive" ${(param.staff_status != null ? param.staff_status : requestScope.STAFF.status) == 'Inactive' ? 'checked' : ''}>
                    <label for="status_inactive">Inactive</label>
                </div>
                <!--                 Gui theo staffID de SignUpStaffController dung trong update va delete-->
                <input type="hidden" name="staffID" value="${requestScope.STAFF.staffID}">
                <button class="btn btn-primary form-control" type="submit" value="<%= IConstants.AC_EDIT_STAFF%>" name="action">Cập nhật thông tin</button>
            </form>
        </div>
        <form action="MainController" method="POST">
            <button type="submit" name="action" value="backtoadminpage">Quay lại</button>
        </form>
        <%
            }
        %>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
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
