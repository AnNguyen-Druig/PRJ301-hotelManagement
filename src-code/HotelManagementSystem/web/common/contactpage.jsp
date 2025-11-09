<%--
    Document : contactpage
    Created on : Nov 8, 2025, 8:16:04 AM
    Author : Admin
--%>
<%@page import="mylib.IConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thông Tin Liên Hệ</title>

        <!-- CSS INTERNAL - ĐỒNG BỘ VỚI style.css -->
        <style>
            /* ===== CƠ BẢN - KHÔNG ĐỘNG VÀO HEADER/FOOTER ===== */
            body {
                background-color: #f8f9fa;
                color: #333333;
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 0;
            }

            h1 {
                color: #004a99;
                font-size: 2.2em;
                text-align: center;
                margin: 50px 0 40px;
                padding-bottom: 14px;
                border-bottom: 4px solid #004a99;
                display: inline-block;
                min-width: 400px;
                position: relative;
                left: 50%;
                transform: translateX(-50%);
                font-weight: bold;
            }

            /* ===== NỘI DUNG CHÍNH ===== */
            .contact-container {
                max-width: 900px;
                margin: 30px auto;
                background-color: #ffffff;
                padding: 40px;
                border-radius: 16px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
                text-align: center;
            }

            .member {
                background-color: #f8fdff;
                border-left: 6px solid #004a99;
                padding: 20px 25px;
                margin: 25px 0;
                border-radius: 12px;
                box-shadow: 0 3px 12px rgba(0, 74, 153, 0.1);
                transition: all 0.3s ease;
            }

            .member:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0, 74, 153, 0.18);
            }

            .member h2 {
                color: #004a99;
                font-size: 1.6em;
                margin: 0 0 10px 0;
                font-weight: bold;
            }

            .member h3 {
                color: #0066cc;
                font-size: 1.2em;
                margin: 0;
                font-weight: normal;
                word-break: break-all;
            }

            .member h3 a {
                color: #0066cc;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .member h3 a:hover {
                color: #004a99;
                text-decoration: underline;
            }

            /* ===== QR ỦNG HỘ ===== */
            .support-section {
                margin-top: 50px;
                padding: 30px;
                background: linear-gradient(135deg, #e6f5ff, #d4edff);
                border-radius: 14px;
                border: 2px dashed #004a99;
                box-shadow: 0 5px 15px rgba(0, 74, 153, 0.15);
            }

            .support-section h3 {
                color: #004a99;
                font-size: 1.7em;
                margin: 0 0 20px 0;
                font-weight: bold;
            }

            .qr-image {
                max-width: 250px;
                width: 100%;
                height: auto;
                border: 4px solid #004a99;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease;
            }

            .qr-image:hover {
                transform: scale(1.05);
            }

            .support-note {
                margin-top: 15px;
                font-size: 1em;
                color: #004a99;
                font-style: italic;
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 768px) {
                .contact-container {
                    margin: 20px;
                    padding: 25px;
                }

                h1 {
                    font-size: 1.8em;
                    min-width: 300px;
                }

                .member {
                    padding: 18px;
                }

                .member h2 {
                    font-size: 1.4em;
                }

                .member h3 {
                    font-size: 1.1em;
                }

                .support-section {
                    padding: 20px;
                }

                .qr-image {
                    max-width: 200px;
                }
            }

            @media (max-width: 576px) {
                h1 {
                    font-size: 1.6em;
                }

                .member h2 {
                    font-size: 1.3em;
                }

                .support-section h3 {
                    font-size: 1.4em;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />

        <h1>Thông Tin Liên Hệ</h1>

        <div class="contact-container">

            <!-- Thành viên 1 -->
            <div class="member">
                <h2>Student 1: Trịnh Nhật Quang</h2>
                <h3>
                    <a href="mailto:trinhnhatquang99@gmail.com">trinhnhatquang99@gmail.com</a>
                </h3>
            </div>

            <!-- Thành viên 2 -->
            <div class="member">
                <h2>Student 2: Nguyễn Trần Đạt Ân</h2>
                <h3>
                    <a href="mailto:nguyentrandatan@gmail.com">nguyentrandatan@gmail.com</a>
                </h3>
            </div>

            <!-- Thành viên 3 -->
            <div class="member">
                <h2>Student 3: Nguyễn Bá Đại</h2>
                <h3>
                    <a href="mailto:nguyendai2412005@gmail.com">nguyendai2412005@gmail.com</a>
                </h3>
            </div>

            <!-- Ủng hộ -->
            <div class="support-section">
                <h3>Ủng hộ chúng tôi</h3>
                <img src="<%=request.getContextPath()%>/img/QR.jpg" alt="QR Code ủng hộ" class="qr-image"/>
                <p class="support-note">Cảm ơn bạn đã ủng hộ nhóm phát triển!</p>
            </div>

        </div>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>