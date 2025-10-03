<%-- 
    Document   : header
    Created on : Oct 2, 2025, 3:43:40 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="header-logo">
                    <a href="<%=request.getContextPath()%>/MainController?action=Login">
                        <img src="<%=request.getContextPath()%>/img/logo.jpg" alt="Logo"/>
                    </a>
                </div>

                <div class="header-menu">
                    <ul>
                        <ul>
                            <li><a href="#">Home</a></li>
                            <li><a href="#">Services</a></li>
                            <li><a href="#">Buy second hand things</a></li>
                            <li><a href="#">Accessories</a></li>
                            <li><a href="#">News</a></li>
                            <li><a href="#" id="contactLink">Contact</a></li>
                        </ul>
                    </ul>
                </div>    
            </div>
        </div>
    </body>
</html>
