<%-- 
    Document   : contactpage
    Created on : Nov 8, 2025, 8:16:04 AM
    Author     : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />
        <h1>Thông Tin Liên Hệ</h1>
        <h2>Student 1: Trịnh Nhật Quang</h2>
        <h3>Email: trinhnhatquang99@gmail.com</h3>
        <h2>Student 2: Nguyễn Trần Đạt Ân</h2>
        <h3>Email: nguyentrandatan@gmail.com</h3>
        <h2>Student 3: Nguyễn Bá Đại</h2>
        <h3>Email: nguyendai2412005@gmail.com</h3>
        
        <h3>Ủng hộ chúng tôi</h3>
        <img src="<%=request.getContextPath()%>/img/QR.jpg" alt="QR"/>
        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>
