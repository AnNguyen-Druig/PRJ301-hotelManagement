<%-- 
    Document   : login.jsp
    Created on : Oct 1, 2025, 6:56:45 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Login Page</h1>
        <form action="MainController" method="post">
            <p>Username: <input type="text" name="txtusername"></p>
            <p>Password: <input type="password" name="txtpassword"></p>
            <p><input type="submit" name="action" value="Login Staff"></p>
            <p><input type="submit" name="action" value="Login Member"></p>
        </form>
        
        <p>
            <%
                String error = (String) request.getAttribute("ERROR");
                if(error != null && !error.trim().isEmpty()) {
                    out.print(error);
                }
            %>
        </p>
        <a href="MainController?action=signupPage">Đăng Ký</a>
    </body>
</html>
