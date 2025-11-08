<%--
    Document   : login.jsp
    Created on : Oct 1, 2025, 6:56:45 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Đăng Nhập</title>

        <%-- Nhúng file CSS chung --%>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styles.css">

        <%-- CSS bổ sung (dành riêng cho trang login) --%>
        <style>
            .login-card {
                /* SỬA: Tăng max-width để form rộng hơn */
                max-width: 650px; /* Tăng từ 550px lên 650px */
                margin: 40px auto;
                padding: 30px;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
                background-color: #fff;
            }
            .login-card h1 {
                text-align: center;
                margin-top: 0;
                margin-bottom: 20px;
            }
            .login-card .form-group {
                margin-bottom: 20px;
            }
            .login-card label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }

            /* === SỬA LỖI INPUT BỊ "HẸP" === */
            .login-card input[type="text"],
            .login-card input[type="password"] {
                width: 100%;
                min-width: 0;
                box-sizing: border-box;

                /* Thêm padding để input "bự" (cao) hơn */
                padding: 0.75rem 0.5rem; /* 12px trên dưới, 8px trái phải */
                font-size: 1.1rem; /* Chữ to hơn 1 chút */
            }
            /* === HẾT PHẦN SỬA === */

            .login-card .button-group {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }
            .login-card .button-group input[type="submit"] {
                width: 100%;
                /* Style của nút submit đã được định nghĩa trong styles.css */
            }
            .login-links {
                text-align: center;
                margin-top: 25px;
                font-size: 0.9em;
            }
            .login-links a {
                color: #0056b3;
                text-decoration: none;
                margin: 0 10px;
            }
            .login-links a:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <%-- Đảm bảo body có class="flex-wrapper" (từ styles.css) --%>
    <body class="flex-wrapper">

        <%-- Nhúng Header (dùng include TĨNH vì là file fragment) --%>
        <%@ include file="header.jsp" %>

        <main class="main-content">

            <div class="login-card">
                <h1>Đăng nhập</h1>

                <%-- Hiển thị lỗi (nếu có) --%>
                <%                    String username = (String) request.getAttribute("username");
                    if (username == null) {
                        username = "";
                    }

                    String error = (String) request.getAttribute("ERROR");
                    if (error != null && !error.trim().isEmpty()) {
                %>
                <%-- Dùng class .error-message từ styles.css --%>
                <div class="error-message" style="margin-bottom: 15px;">
                    <%= error%>
                </div>
                <%
                    }
                %>

                <form action="MainController" method="post">
                    <div class="form-group">
                        <label for="username-input">Tên đăng nhập:</label>
                        <input type="text" name="txtusername" id="username-input" value="<%= username%>" required>
                    </div>
                    <div class="form-group">
                        <label for="password-input">Mật khẩu:</label>
                        <input type="password" name="txtpassword" id="password-input" required>
                    </div>

                    <div class="button-group">
                        <%-- Nút này sẽ lấy style 'button' mặc định từ styles.css --%>
                        <input type="submit" name="action" value="Login Staff"> 
                        <%-- Nút này lấy style '.btn-secondary' từ styles.css --%>
                        <input type="submit" name="action" value="Login Member" class="btn-secondary">
                    </div>
                </form>

                <div class="login-links">
                    <a href="MainController?action=Signup">Đăng Ký (Guest)</a>
                    |
                    <a href="MainController?action=default">Quay về Trang chủ</a>
                </div>
            </div>

        </main>

        <%-- Nhúng Footer (dùng include TĨNH) --%>
        <%@ include file="footer.jsp" %>

    </body>
</html>