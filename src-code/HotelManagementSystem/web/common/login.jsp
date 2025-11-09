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

    <%-- Nhúng file CSS chung (sẽ bị ghi đè bởi CSS nội bộ) --%>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styles.css">

    <%-- CSS NỘI BỘ - GHI ĐÈ HOÀN TOÀN --%>
    <style>
        /* === RESET & CƠ BẢN === */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            color: #2c3e50;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* === GHI ĐÈ styles.css === */
        body, h1, h2, h3, input, label, a, div {
            background-color: transparent !important;
            color: inherit !important;
            font-family: inherit !important;
            line-height: normal !important;
        }

        /* === CONTAINER CHÍNH === */
        .login-container {
            max-width: 420px;
            width: 90%;
            margin: 2.5rem auto;
            background: #ffffff;
            padding: 2.5rem 2rem;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(0, 0, 0, 0.05);
            animation: fadeIn 0.6s ease-out;
            flex: 1;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* === TIÊU ĐỀ === */
        h1 {
            text-align: center;
            margin: 0 0 1.8rem 0;
            font-size: 2rem;
            font-weight: 600;
            color: #1a3b5d;
            letter-spacing: -0.5px;
        }

        /* === FORM GROUP === */
        .form-group {
            margin-bottom: 1.3rem;
        }

        label {
            display: block;
            margin-bottom: 0.6rem;
            font-weight: 600;
            color: #2c3e50;
            font-size: 0.95rem;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.85rem 1rem;
            border: 1.5px solid #d0d7de;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #fafbfc;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #006699;
            background-color: #ffffff;
            box-shadow: 0 0 0 3px rgba(0, 102, 153, 0.15);
        }

        /* === NÚT ĐĂNG NHẬP === */
        .button-group {
            display: flex;
            gap: 0.8rem;
            margin-top: 1.5rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        input[type="submit"] {
            flex: 1;
            min-width: 130px;
            padding: 0.85rem 1rem;
            font-size: 1rem;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: none;
        }

        input[name="action"][value="Login Staff"] {
            background: linear-gradient(135deg, #006699, #004d73);
            color: white;
        }

        input[name="action"][value="Login Member"] {
            background: linear-gradient(135deg, #27ae60, #1e8449);
            color: white;
        }

        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }

        input[name="action"][value="Login Staff"]:hover {
            background: linear-gradient(135deg, #004d73, #003950);
        }

        input[name="action"][value="Login Member"]:hover {
            background: linear-gradient(135deg, #1e8449, #1a6b3a);
        }

        /* === THÔNG BÁO LỖI === */
        .error-message {
            background-color: #fdf2f2;
            color: #c53030;
            padding: 0.9rem 1rem;
            border-radius: 10px;
            border-left: 4px solid #c53030;
            font-size: 0.95rem;
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: 500;
            animation: shake 0.4s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        /* === LIÊN KẾT DƯỚI === */
        .login-links {
            text-align: center;
            margin-top: 1.8rem;
            font-size: 0.95rem;
            color: #666;
        }

        .login-links a {
            color: #006699;
            text-decoration: none;
            font-weight: 500;
            padding: 0 0.3rem;
            transition: color 0.2s;
        }

        .login-links a:hover {
            color: #004d73;
            text-decoration: underline;
        }

        .login-links .separator {
            color: #aaa;
            margin: 0 0.5rem;
        }

        /* === RESPONSIVE === */
        @media (max-width: 480px) {
            .login-container {
                margin: 1.5rem auto;
                padding: 2rem 1.5rem;
            }

            h1 {
                font-size: 1.7rem;
            }

            .button-group {
                flex-direction: column;
            }

            input[type="submit"] {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <%@ include file="header.jsp" %>

    <div class="login-container">
        <h1>Đăng nhập</h1>

        <%
            String username = (String) request.getAttribute("username");
            if (username == null) {
                username = "";
            }

            String error = (String) request.getAttribute("ERROR");
            if (error != null && !error.trim().isEmpty()) {
        %>
            <div class="error-message"><%= error %></div>
        <% } %>

        <form action="MainController" method="post">
            <div class="form-group">
                <label for="username-input">Tên đăng nhập:</label>
                <input type="text" name="txtusername" id="username-input" value="<%= username %>" required>
            </div>
            <div class="form-group">
                <label for="password-input">Mật khẩu:</label>
                <input type="password" name="txtpassword" id="password-input" required>
            </div>
            <div class="button-group">
                <input type="submit" name="action" value="Login Staff">
                <input type="submit" name="action" value="Login Member">
            </div>
        </form>

        <div class="login-links">
            <a href="MainController?action=Signup">Đăng Ký (Guest)</a>
            <span class="separator">|</span>
            <a href="MainController?action=default">Quay về Trang chủ</a>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>