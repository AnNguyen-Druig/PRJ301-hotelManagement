<%--
    File   : footer.jsp
    Author : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Footer</title>
<style>
    /* === Thiết lập layout để footer luôn nằm dưới cùng === */
    html, body {
        height: 100%;           /* Chiều cao toàn trang */
        margin: 0;              /* Xóa margin mặc định */
        display: flex;
        flex-direction: column; /* Sắp xếp theo chiều dọc */
        font-family: Arial, sans-serif;
    }

    main {
        flex: 1; /* Kéo dãn phần nội dung chiếm toàn bộ chiều cao còn lại */
    }

    /* === CSS cho footer === */
    .footer-container {
        background-color: #004a99;
        color: #f1f1f1;
        padding: 30px 40px;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        flex-wrap: wrap;
        border-top: 3px solid #003366;
        font-size: 14px;
    }

    .footer-left, .footer-right {
        flex-basis: 45%;
        min-width: 250px;
        text-align: center;
    }

    .footer-left h4, .footer-right h4 {
        font-size: 16px;
        color: #ffffff;
        margin-top: 0;
        margin-bottom: 10px;
        border-bottom: 1px solid #555;
        padding-bottom: 5px;
        display: inline-block;
        padding: 0 20px;
    }

    .footer-left p, .footer-right p {
        margin: 5px 0;
        color: #ccc;
        line-height: 1.6;
    }

    .footer-right a {
        color: #ccc;
        text-decoration: none;
    }

    .footer-right a:hover {
        color: #ffffff;
        text-decoration: underline;
    }
</style>
</head>
<body>

    <!-- Phần nội dung trang -->
    <main>
        <%-- Nội dung chính của trang sẽ được render ở đây --%>
    </main>

    <!-- Footer -->
    <footer class="footer-container">
        <div class="footer-left">
            <h4>Thông tin khách sạn</h4>
            <p><strong>Tên:</strong> Khách Sạn của Anh Hai</p>
            <p><strong>Địa chỉ:</strong> Số 10 FPT</p>
        </div>

        <div class="footer-right">
            <h4>Thông tin liên hệ</h4>
            <p><strong>Email:</strong> 
                <a href="mailto:projectprjfpt@gmail.com">projectprjfpt@gmail.com</a>
            </p>
            <p><strong>Số điện thoại:</strong> 
                <a href="tel:0342264734">0342 264 734</a>
            </p>
        </div>
    </footer>

</body>
</html>
