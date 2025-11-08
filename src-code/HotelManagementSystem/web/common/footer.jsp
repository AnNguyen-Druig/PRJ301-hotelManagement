<%--
    File   : footer.jsp
    Author : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Footer</title>
<style>
    /* === SỬA LẠI CSS CHO FOOTER === */
    .footer-container {
        background-color: #004a99; /* Màu nền xanh đậm */
        color: #f1f1f1; /* Màu chữ sáng */
        padding: 30px 40px; /* Padding (trên/dưới 30px, trái/phải 40px) */

        /* Sửa: Dùng Flexbox để chia 2 cột */
        display: flex;
        justify-content: space-between; /* Đẩy 2 phần ra 2 bên */
        align-items: flex-start; /* Căn lề theo đầu */
        flex-wrap: wrap; /* Cho phép xuống hàng trên màn hình nhỏ */

        border-top: 3px solid #003366; /* Viền trên đậm hơn */
        font-family: Arial, sans-serif;
        font-size: 14px;
        /* Bỏ text-align: center ở đây */
    }

    /* CSS cho 2 cột trái và phải */
    .footer-left, .footer-right {
        flex-basis: 45%; /* Mỗi bên chiếm khoảng 45% */
        min-width: 250px; /* Độ rộng tối thiểu trước khi xuống hàng */

        /* Sửa: Thêm text-align: center vào ĐÂY */
        text-align: center; /* Căn giữa nội dung BÊN TRONG cột này */
    }

    .footer-left h4, .footer-right h4 {
        font-size: 16px;
        color: #ffffff;
        margin-top: 0;
        margin-bottom: 10px;
        border-bottom: 1px solid #555;
        padding-bottom: 5px;

        /* Căn giữa đường gạch chân (vì cha đã text-align: center) */
        display: inline-block;
        width: auto;
        padding-left: 20px;
        padding-right: 20px;
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
    /* === HẾT PHẦN SỬA === */
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