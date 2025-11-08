<%-- 
    Document   : header
    Created on : Oct 2, 2025, 3:43:40 PM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page import="DTO.Basic_DTO.GuestDTO"%>
<%@page import="DTO.Basic_DTO.StaffDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .header-logo {
                display: flex;
                justify-content: space-between; /* Đẩy logo và link (Đăng nhập/xuất) ra 2 bên */
                align-items: center;
                padding: 10px;
                border-bottom: 1px solid #eee;
            }
            .header-logo img {
                height: 50px; /* Giới hạn chiều cao logo */
            }
            .header-menu ul {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex; /* Dàn các mục menu theo hàng ngang */
                background-color: #f8f8f8;
            }
            .header-menu li a {
                display: block;
                padding: 15px 20px;
                text-decoration: none;
                color: #333;
            }
            .header-menu li a:hover {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="header-logo">
                    <a href="<%=request.getContextPath()%>/MainController?action=default">
                        <img src="<%=request.getContextPath()%>/img/LOGO_HOTEL.jpg" alt="Logo"/>
                    </a>
                    <%
                        StaffDTO staff = (StaffDTO) session.getAttribute("STAFF");
                        GuestDTO guest = (GuestDTO) session.getAttribute("USER");

                        if (staff != null || guest != null) {
                    %>
                    <a href="MainController?action=logout">Đăng xuất</a>
                    <%
                    } else {
                    %>
                    <a href="MainController?action=Login Member">Đăng nhập</a>
                    <%
                        }
                    %>
                </div>

                <div class="header-menu">
                    <ul>
                        <li><a href="MainController?action=default">Trang chủ</a></li>
                        <li><a href="MainController?action=contact">Contact</a></li>
                    </ul>
                </div>    
            </div>
        </div>
    </body>
</html>
