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
                justify-content: space-between;
                align-items: center;
                padding: 10px 20px; /* Tăng padding trái/phải */
                border-bottom: 1px solid #eee;
                background-color: #ffffff; /* Nền logo luôn là màu trắng */
            }
            .header-logo img {
                height: 50px;
                border-radius: 50%;
            }
            .header-logo a { /* CSS cho link Đăng nhập/xuất */
                text-decoration: none;
                color: #0056b3;
                font-weight: bold;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }
            .header-logo a:hover {
                background-color: #f0f0f0;
            }

            /* === SỬA MÀU SẮC MENU === */
            .header-menu ul {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex;
                background-color: #004a99; /* Màu xanh đậm (dễ nhìn hơn) */
                justify-content: center;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1); /* Thêm bóng mờ */
            }
            .header-menu li a {
                display: block;
                padding: 15px 20px;
                text-decoration: none;
                color: #ffffff; /* Chữ màu trắng */
                font-weight: bold; /* Chữ đậm hơn */
                transition: background-color 0.3s;
            }
            .header-menu li a:hover {
                background-color: #003366; /* Màu xanh đậm hơn khi hover */
            }
            /* === HẾT PHẦN SỬA === */
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
                            <%
                                String action = "";
                                if (staff != null) {
                                    String role = staff.getRole();
                                    switch (role) {
                                        case "Receptionist":
                                            action = IConstants.AC_TURNBACK_RECEPTION;
                                            break;
                                        case "Manager":
                                            action = IConstants.AC_MANAGER_GO_BACK;
                                            break;
                                        case "ServiceStaff":
                                            action = IConstants.AC_GET_ROOM_SERVICE;
                                            break;
                                        case "Admin":
                                            action = IConstants.AC_BACK_TO_ADMIN_PAGE;
                                            break;
                                        case "Housekeeping":
                                            action = IConstants.AC_BACK_TO_HOUSEKEEPING;
                                            break;
                                        default:
                                            action = IConstants.AC_GO_BACK_GUEST_PAGE;
                                            break;
                                    }
                            %>       
                        <li><a href="MainController?action=<%= action%>">Quay về trang <%= staff.getRole()%></a></li>
                            <%
                            } else if (guest != null) {
                                action = IConstants.AC_GO_BACK_GUEST_PAGE;
                            %>
                        <li><a href="MainController?action=<%= action%>">Quay về trang Khách</a></li>
                            <%
                                }
                            %>

                    </ul>
                </div>    
            </div>
        </div>
    </body>
</html>
