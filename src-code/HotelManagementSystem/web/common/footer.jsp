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
        /* CSS cho footer */
        .footer-container {
            background-color: #333; /* Màu nền tối cho footer */
            color: #f1f1f1; /* Màu chữ sáng */
            padding: 20px 40px; /* Padding (trên/dưới 20px, trái/phải 40px) */
            
            /* Sử dụng Flexbox để chia cột */
            display: flex;
            justify-content: space-between; /* Đẩy 2 phần ra 2 bên */
            align-items: flex-start; /* Căn lề theo đầu */
            flex-wrap: wrap; /* Cho phép xuống hàng trên màn hình nhỏ */
            
            border-top: 3px solid #555; /* Thêm một đường viền mỏng ở trên */
            font-family: Arial, sans-serif;
            font-size: 14px;
        }
        
        /* CSS cho 2 cột trái và phải */
        .footer-left, .footer-right {
            flex-basis: 45%; /* Mỗi bên chiếm khoảng 45% */
            min-width: 250px; /* Độ rộng tối thiểu trước khi xuống hàng */
            padding: 10px 0;
        }

        .footer-left h4, .footer-right h4 {
            font-size: 16px;
            color: #ffffff;
            margin-top: 0;
            margin-bottom: 10px;
            border-bottom: 1px solid #555;
            padding-bottom: 5px;
        }

        .footer-left p, .footer-right p {
            margin: 5px 0;
            color: #ccc; /* Màu chữ nhạt hơn */
            line-height: 1.6;
        }
        
        /* Làm cho link email và sđt có thể nhấp vào */
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
    
    <footer class="footer-container">
        
        <%-- Phần Trái --%>
        <div class="footer-left">
            <h4>Thông tin khách sạn</h4>
            <p>
                <strong>Tên:</strong> 
                Khách Sạn của Anh Hai
            </p>
            <p>
                <strong>Địa chỉ:</strong> 
                Số 10 FPT
            </p>
        </div>
        
        <%-- Phần Phải --%>
        <div class="footer-right">
            <h4>Thông tin liên hệ</h4>
            <p>
                <strong>Email:</strong> 
                <a href="mailto:projectprjfpt@gmail.com">projectprjfpt@gmail.com</a>
            </p>
            <p>
                <strong>Số điện thoại:</strong> 
                <a href="tel:0342264734">0342 264 734</a>
            </p>
        </div>
    </footer>

</body>
</html>