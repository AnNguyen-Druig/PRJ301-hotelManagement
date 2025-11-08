<%--
    File   : homepage.jsp
    Author : Admin
--%>

<%@page import="mylib.IConstants"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ - Khách Sạn của Anh Hai</title>
        <style>
            /* Reset cơ bản */
            body, html {
                margin: 0;
                padding: 0;
                height: 100%;
                font-family: Arial, sans-serif;
            }

            /* 1. Kỹ thuật "Đẩy Footer xuống dưới" (Sticky Footer) bằng Flexbox */
            .flex-wrapper {
                display: flex;
                flex-direction: column; /* Sắp xếp các con (header, main, footer) theo chiều dọc */
                min-height: 100vh; /* Chiều cao tối thiểu bằng 100% chiều cao màn hình */
            }

            .main-content {
                flex: 1; /* Cho phép phần nội dung chính co giãn để lấp đầy không gian */
                padding: 0; /* Xóa padding mặc định nếu có */
                background-color: #ffffff; /* Màu nền cho nội dung */
            }

            /* 2. CSS cho vùng Hero (Chào mừng) */
            .hero-section {
                background-color: #4A5568; /* Màu nền xám đậm (thay cho ảnh) */
                color: white;
                text-align: center;
                padding: 100px 20px; /* Padding lớn để tạo không gian */
            }
            .hero-section h1 {
                margin: 0;
                font-size: 3.5em;
                font-weight: bold;
            }
            .hero-section p {
                font-size: 1.2em;
                margin-top: 10px;
                color: #e2e8f0;
            }
            .hero-section .cta-button {
                display: inline-block;
                margin-top: 25px;
                padding: 12px 25px;
                background-color: #E53E3E; /* Màu đỏ nổi bật */
                color: white;
                text-decoration: none;
                font-weight: bold;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .hero-section .cta-button:hover {
                background-color: #C53030;
            }

            /* 3. CSS cho các khu vực nội dung (Giới thiệu, Phòng) */
            .content-section {
                max-width: 1000px; /* Giới hạn chiều rộng nội dung */
                margin: 40px auto; /* Căn giữa và tạo khoảng cách */
                padding: 0 20px;
            }
            .content-section h2 {
                text-align: center;
                font-size: 2.5em;
                margin-bottom: 30px;
                color: #2D3748;
            }

            /* 4. CSS cho layout thẻ (Featured Rooms) */
            .room-grid {
                display: flex;
                justify-content: space-around; /* Phân bổ không gian */
                flex-wrap: wrap; /* Tự động xuống hàng */
                gap: 20px; /* Khoảng cách giữa các thẻ */
            }
            .room-card {
                flex-basis: 300px; /* Chiều rộng cơ sở của mỗi thẻ */
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                overflow: hidden; /* Ẩn phần tràn của ảnh */
                text-align: center;
            }
            .room-card img {
                width: 100%;
                height: 200px;
                object-fit: cover; /* Đảm bảo ảnh lấp đầy mà không bị méo */
            }
            .room-card h4 {
                font-size: 1.5em;
                margin: 15px 0 10px 0;
                color: #2D3748;
            }
            .room-card p {
                font-size: 0.9em;
                padding: 0 15px 15px 15px;
                color: #4A5568;
            }

        </style>
    </head>

    <%-- Bọc toàn bộ trang bằng wrapper --%>
    <body class="flex-wrapper">

        <%-- 1. HEADER --%>
        <%-- Sử dụng jsp:include (an toàn hơn) để nhúng header --%>
        <jsp:include page="header.jsp" />

        <%-- 2. NỘI DUNG CHÍNH --%>
        <main class="main-content">

            <!-- Vùng Hero (Chào mừng) -->
            <section class="hero-section">
                <h1>Chào mừng đến với Khách Sạn của Anh Hai</h1>
                <p>Trải nghiệm sự sang trọng và thoải mái bậc nhất tại Số 10 FPT.</p>
                <%-- Link này trỏ đến action 'booking' trong MainController --%>
                <a href="MainController?action=booking" class="cta-button">Đặt phòng ngay</a>
            </section>

            <!-- Vùng Giới thiệu -->
            <section class="content-section">
                <h2>Về chúng tôi</h2>
                <p style="text-align: center; line-height: 1.6;">
                    Chào mừng bạn đến với "Khách Sạn của Anh Hai", nơi sự tinh tế và lòng hiếu khách giao thoa. Tọa lạc tại trái tim "Số 10 FPT", khách sạn chúng tôi tự hào mang đến một không gian nghỉ dưỡng đẳng cấp, dịch vụ chuyên nghiệp cùng những trải nghiệm ẩm thực khó quên. Hãy để chúng tôi chăm sóc kỳ nghỉ của bạn.
                </p>
            </section>

            <!-- Vùng Phòng nổi bật -->
            <section class="content-section">
                <h2>Phòng nổi bật</h2>
                <div class="room-grid">

                    <%-- Thẻ 1: Phòng Single --%>
                    <div class="room-card">
                        <%-- Ảnh minh họa (placeholder) --%>
                        <img src="<%=request.getContextPath()%>/img/SingleRoom.jpg" alt="Phòng Single" onerror="this.src='https://placehold.co/400x300/ccc/333?text=Lỗi+Ảnh'">
                        <h4>Phòng Single</h4>
                        <p>Lý tưởng cho khách du lịch một mình hoặc đi công tác, cung cấp không gian ấm cúng và đầy đủ tiện nghi.</p>
                    </div>

                    <%-- Thẻ 2: Phòng Double --%>
                    <div class="room-card">
                        <img src="<%=request.getContextPath()%>/img/DoubleRoom.jpg" alt="Phòng Double" onerror="this.src='https://placehold.co/400x300/ccc/333?text=Lỗi+Ảnh'">
                        <h4>Phòng Double</h4>
                        <p>Rộng rãi và thoải mái, hoàn hảo cho các cặp đôi hoặc bạn bè tận hưởng kỳ nghỉ cùng nhau.</p>
                    </div>

                    <%-- Thẻ 3: Phòng Suite --%>
                    <div class="room-card">
                        <img src="<%=request.getContextPath()%>/img/SuiteRoom.jpg" alt="Phòng Suite" onerror="this.src='https://placehold.co/400x300/ccc/333?text=Lỗi+Ảnh'">
                        <h4>Phòng Suite</h4>
                        <p>Sang trọng bậc nhất với phòng khách riêng biệt, tầm nhìn tuyệt đẹp và dịch vụ cao cấp nhất.</p>
                    </div>

                    <%-- THÊM MỚI 3 LOẠI PHÒNG CÒN LẠI --%>

                    <%-- Thẻ 4: Phòng Deluxe --%>
                    <div class="room-card">
                        <img src="<%=request.getContextPath()%>/img/DeluxeRoom.jpg" alt="Phòng Deluxe" onerror="this.src='https://placehold.co/400x300/ccc/333?text=Lỗi+Ảnh'">
                        <h4>Phòng Deluxe</h4>
                        <p>Nâng cấp trải nghiệm của bạn với phòng Deluxe, kết hợp giữa không gian rộng rãi và nội thất cao cấp.</p>
                    </div>

                    <%-- Thẻ 5: Phòng Family --%>
                    <div class="room-card">
                        <img src="<%=request.getContextPath()%>/img/FamilyRoom.jpg" alt="Phòng Family" onerror="this.src='https://placehold.co/400x300/ccc/333?text=Lỗi+Ảnh'">
                        <h4>Phòng Family</h4>
                        <p>Không gian lý tưởng cho cả gia đình, với nhiều giường và khu vực sinh hoạt chung ấm cúng.</p>
                    </div>

                    <%-- Thẻ 6: Phòng Executive --%>
                    <div class="room-card">
                        <img src="<%=request.getContextPath()%>/img/ExecutiveRoom.jpg" alt="Phòng Executive" onerror="this.src='https://placehold.co/400x300/ccc/333?text=Lỗi+Ảnh'">
                        <h4>Phòng Executive</h4>
                        <p>Thiết kế dành cho doanh nhân, cung cấp không gian làm việc yên tĩnh và các tiện ích văn phòng.</p>
                    </div>

                </div>
            </section>

        </main>

        <%-- 3. FOOTER --%>
        <%-- Đặt footer ở cuối wrapper --%>
        <jsp:include page="footer.jsp" />

    </body>
</html>