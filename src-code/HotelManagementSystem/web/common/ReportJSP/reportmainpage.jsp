<%-- 
    Document   : reportmainpage
    Created on : Oct 22, 2025, 11:50:29 PM
    Author     : Nguyễn Đại
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report View Page</title>
    </head>
    <body>
        <jsp:useBean id="USER" scope="session" class="DTO.StaffDTO" />
        <h1>Hello, ${USER.fullName} welcome to report page</h1>
        <p><a href="GetReportController">Report 1</a></p>
    </body>
</html>
