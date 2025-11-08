<%-- 
    Document   : admin
    Created on : Oct 2, 2025, 3:18:57 PM
    Author     : Admin
--%>

<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page import="mylib.IConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Thêm thư viện JSTL --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .green{
                color: green;
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <%
            // Kiểm tra session (giữ nguyên)
            StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
            if (staff != null) {
        %>
        <h1>Welcome <%= staff.getFullName()%> Staff!</h1>
        <h4><a href="MainController?action=logout">Logout</a></h4>

        <hr>
        <h3>Quản lý Nhân viên</h3>

        <%-- FORM LỌC NHÂN VIÊN --%>
        <form action="MainController" method="POST">    

            <%-- Dropdown 1: Lọc theo Vai Trò --%>
            <label for="role">Lọc theo Vai Trò:</label>
            <select id="role" name="role">
                <%-- Dùng EL để kiểm tra và thêm 'selected' --%>
                <option value="AllRoom" ${param.role == 'AllRoom' ? 'selected' : ''}>Tất cả vai trò</option>
                <option value="Receptionist" ${param.role == 'Receptionist' ? 'selected' : ''}>Lễ tân</option>
                <option value="Manager" ${param.role == 'Manager' ? 'selected' : ''}>Quản lý</option>
                <option value="Housekeeping" ${param.role == 'Housekeeping' ? 'selected' : ''}>Nhân viên buồng phòng</option>
                <option value="ServiceStaff" ${param.role == 'ServiceStaff' ? 'selected' : ''}>Nhân viên dịch vụ</option>
                <option value="Admin" ${param.role == 'Admin' ? 'selected' : ''}>Quản trị viên</option>
            </select>

            <%-- Dropdown 2: Lọc theo Trạng Thái (MỚI) --%>
            <label for="status" style="margin-left: 20px;">Lọc theo Trạng Thái:</label>
            <select id="status" name="status">
                <%-- Dùng EL để kiểm tra và thêm 'selected' --%>
                <option value="AllStatus" ${param.status == 'AllStatus' ? 'selected' : ''}>Tất cả trạng thái</option>
                <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Đang hoạt động</option>
                <option value="Inactive" ${param.status == 'Inactive' ? 'selected' : ''}>Đã vô hiệu hóa</option>
            </select>

            <button type="submit" value="<%= IConstants.AC_FILTER_STAFF%>" name="action">Lọc</button>
        </form>
        
        <<form action="MainController" method="GET">
            <button type="submit" name="action" value="<%= IConstants.AC_SIGN_UP_STAFF %>">Thêm nhân viên</button>
        </form>
        
        <%-- BẢNG HIỂN THỊ KẾT QUẢ --%>
        <c:if test="${not empty STAFF_LIST}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ và Tên</th>
                        <th>Vai Trò (Role)</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Điện thoại</th>
                        <th>Địa chỉ</th> <%-- THÊM CỘT MỚI --%>
                        <th>CCCD</th> <%-- THÊM CỘT MỚI --%>
                        <th>Ngày sinh</th>
                        <th>Trạng thái (Status)</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Dùng JSTL <c:forEach> để lặp qua danh sách --%>
                    <c:forEach var="s" items="${STAFF_LIST}">
                        <tr>
                            <td>${s.staffID}</td>
                            <td>${s.fullName}</td>
                            <td>${s.role}</td>
                            <td>${s.userName}</td>
                            <td>${s.email}</td>
                            <td>${s.phone}</td>
                            <td>${s.address}</td> <%-- THÊM DỮ LIỆU MỚI --%>
                            <td>${s.idNumber}</td> <%-- THÊM DỮ LIỆU MỚI --%>
                            <td>${s.dateOfBirth}</td>
                            <td>
                                <%-- Hiển thị Status đẹp hơn --%>
                                <c:if test="${s.status == 'Active'}">
                                    <span style="color: green; font-weight: bold;">Đang hoạt động</span>
                                </c:if>
                                <c:if test="${s.status == 'Inactive'}">
                                    <span style="color: red;">Đã vô hiệu hóa</span>
                                </c:if>
                            </td>
                            <td>
                                <form action="MainController" method="POST">
                                    <input type="hidden" name="staffID" value="${s.staffID}">
                                    <button type="submit" value="<%= IConstants.AC_UPDATE_STAFF %>" name="action">Sửa đổi</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <%-- Thông báo nếu không tìm thấy --%>
        <c:if test="${empty STAFF_LIST}">
            <p>Không tìm thấy nhân viên nào.</p>
        </c:if>

        <%
                // Đóng thẻ if của Java (giữ nguyên)
            } else {
                request.getRequestDispatcher(IConstants.LOGIN_PAGE).forward(request, response);
            }
        %>
    </body>
</html>