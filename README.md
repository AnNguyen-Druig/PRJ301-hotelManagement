# Hotel Management System

![Hotel Logo](img/LOGO_HOTEL.jpg)

> Hệ thống quản lý khách sạn đa vai trò, được xây dựng theo mô hình Java Web truyền thống bằng Servlet/JSP cho bài tập/dự án môn PRJ301.

## Mục lục

1. [Giới thiệu dự án](#giới-thiệu-dự-án)
2. [Dự án này dùng để làm gì?](#dự-án-này-dùng-để-làm-gì)
3. [Chức năng chính theo vai trò](#chức-năng-chính-theo-vai-trò)
4. [Luồng nghiệp vụ tổng quát](#luồng-nghiệp-vụ-tổng-quát)
5. [Công nghệ sử dụng](#công-nghệ-sử-dụng)
6. [Kiến trúc và tổ chức mã nguồn](#kiến-trúc-và-tổ-chức-mã-nguồn)
7. [Cấu trúc thư mục](#cấu-trúc-thư-mục)
8. [Cơ sở dữ liệu](#cơ-sở-dữ-liệu)
9. [Yêu cầu môi trường](#yêu-cầu-môi-trường)
10. [Hướng dẫn cài đặt và chạy](#hướng-dẫn-cài-đặt-và-chạy)
11. [Tài khoản mẫu để đăng nhập](#tài-khoản-mẫu-để-đăng-nhập)
12. [Điểm nổi bật của dự án](#điểm-nổi-bật-của-dự-án)
13. [Hạn chế và lưu ý](#hạn-chế-và-lưu-ý)
14. [Tài liệu đi kèm trong repo](#tài-liệu-đi-kèm-trong-repo)

## Giới thiệu dự án

`Hotel Management System` là một hệ thống quản lý khách sạn chạy trên nền tảng Java Web, hỗ trợ nhiều vai trò trong cùng một ứng dụng:

- Khách hàng (`Guest`)
- Lễ tân (`Receptionist`)
- Quản lý (`Manager`)
- Nhân viên buồng phòng (`Housekeeping`)
- Nhân viên dịch vụ (`ServiceStaff`)
- Quản trị viên (`Admin`)

Ứng dụng được tổ chức theo hướng MVC đơn giản, sử dụng:

- `Servlet` để xử lý nghiệp vụ
- `JSP` để hiển thị giao diện
- `DAO + DTO` để truy cập và trao đổi dữ liệu
- `JDBC` để kết nối trực tiếp tới `Microsoft SQL Server`

Mã nguồn chính của hệ thống nằm trong:

- `src-code/HotelManagementSystem`

CSDL và dữ liệu mẫu nằm trong:

- `Project Problem for FALL 2025/Given.sql`

## Dự án này dùng để làm gì?

Dự án này được xây dựng để số hóa các nghiệp vụ vận hành cốt lõi của một khách sạn, từ khâu khách đặt phòng cho tới khi thanh toán và xuất hóa đơn.

Cụ thể, hệ thống giúp:

- Quản lý danh sách phòng, loại phòng và trạng thái phòng
- Cho khách hàng đăng ký tài khoản, đăng nhập và tự đặt phòng
- Tìm phòng trống theo loại phòng và khoảng thời gian lưu trú
- Quản lý vòng đời booking: `Reserved`, `CheckIn`, `CheckOut`, `Canceled`, `Complete`
- Hỗ trợ khách đang lưu trú đặt thêm dịch vụ
- Hỗ trợ lễ tân xử lý check-in, check-out và cập nhật booking
- Hỗ trợ bộ phận buồng phòng quản lý trạng thái phòng và tác vụ dọn phòng
- Hỗ trợ bộ phận dịch vụ xử lý yêu cầu dịch vụ theo từng booking
- Hỗ trợ quản lý theo dõi doanh thu, khách hàng, tỷ lệ lấp đầy và thống kê hủy phòng
- Hỗ trợ admin quản lý nhân viên và cấu hình thuế/giá dịch vụ

Nói ngắn gọn, đây là một hệ thống quản trị khách sạn end-to-end ở mức học thuật nhưng đã bao phủ khá đầy đủ các khâu vận hành thực tế.

## Chức năng chính theo vai trò

### 1. Guest

- Đăng ký tài khoản thành viên
- Đăng nhập tài khoản khách hàng
- Xem danh sách phòng còn trống
- Lọc phòng theo loại phòng, ngày check-in, ngày check-out
- Đặt phòng trực tiếp từ giao diện
- Xem các booking đã giữ chỗ và booking đang lưu trú
- Hủy đặt phòng trước ngày check-in
- Đặt thêm dịch vụ cho booking đang ở
- Thực hiện checkout và chọn phương thức thanh toán
- Xem hóa đơn sau khi thanh toán

### 2. Receptionist

- Xem toàn bộ danh sách booking
- Lọc booking theo trạng thái
- Tạo booking mới dựa trên CCCD/CMND khách
- Mở trang chi tiết booking để chỉnh sửa
- Đổi phòng / đổi ngày check-in / check-out trong booking
- Xử lý `Check In`
- Xử lý `Check Out`
- Hủy booking
- Xác nhận hoàn tất checkout

### 3. Service Staff

- Xem danh sách phòng/booking đang cần phục vụ dịch vụ
- Mở danh sách dịch vụ theo từng booking
- Theo dõi các dịch vụ đã được khách yêu cầu
- Cập nhật trạng thái dịch vụ
- Xem các báo cáo liên quan đến dịch vụ

### 4. Housekeeping

- Xem danh sách phòng cùng trạng thái hiện tại
- Cập nhật trạng thái phòng như `Available`, `Dirty`, `Maintenance`, `Occupied`
- Xem danh sách task dọn phòng đang `Pending` hoặc `InProgress`
- Nhận task, cập nhật loại vệ sinh và trạng thái công việc
- Khi hoàn tất dọn phòng, hệ thống cập nhật phòng về `Available`
- Xem các báo cáo housekeeping và maintenance

### 5. Manager

- Xem doanh thu theo ngày
- Xem doanh thu theo tháng/năm
- Xem doanh thu theo năm
- Xem top 10 khách hàng đặt phòng thường xuyên
- Xem khách hàng có tổng chi tiêu cao
- Xem dịch vụ được dùng nhiều nhất
- Xem dịch vụ mang lại doanh thu cao nhất và thấp nhất
- Xem tỷ lệ lấp đầy phòng theo tháng/năm
- Xem thống kê hủy phòng theo thời gian và theo loại phòng

### 6. Admin

- Xem toàn bộ danh sách nhân viên
- Lọc nhân viên theo vai trò và trạng thái
- Thêm nhân viên mới
- Cập nhật thông tin nhân viên
- Xóa nhân viên
- Thay đổi giá trị thuế VAT
- Thay đổi giá tiền dịch vụ

## Luồng nghiệp vụ tổng quát

1. Khách hàng tạo tài khoản hoặc đăng nhập vào hệ thống.
2. Khách tìm phòng trống theo loại phòng và khoảng ngày lưu trú.
3. Khách đặt phòng, hệ thống tạo booking với trạng thái `Reserved`.
4. Lễ tân tiếp nhận booking, chỉnh sửa nếu cần và chuyển trạng thái sang `CheckIn`.
5. Trong thời gian lưu trú, khách có thể đặt thêm dịch vụ; bộ phận dịch vụ tiếp nhận và xử lý.
6. Khi khách checkout, hệ thống tính tiền phòng + tiền dịch vụ + VAT.
7. Hệ thống lưu `Payment`, `Invoice` và chuyển booking sang trạng thái phù hợp.
8. Bộ phận housekeeping và manager theo dõi phòng, task, báo cáo và thống kê vận hành.

## Công nghệ sử dụng

| Nhóm | Công nghệ / Thành phần |
| --- | --- |
| Ngôn ngữ chính | Java 8 |
| Backend Web | Java Servlet, JSP |
| View engine | JSP + JSTL |
| Truy cập dữ liệu | JDBC thuần |
| Mẫu tổ chức mã | MVC, Front Controller, DAO, DTO |
| Cơ sở dữ liệu | Microsoft SQL Server |
| Web server / Servlet container | Apache Tomcat |
| Build tool | Apache Ant |
| IDE phù hợp nhất với project | NetBeans |
| Thư viện JDBC | `sqljdbc4.jar` |
| Frontend | HTML, CSS, một ít JavaScript nhúng trong JSP |
| Session/Auth | `HttpSession` với session cho `STAFF` và `USER` |

### Công nghệ nhận diện được trực tiếp từ codebase

- `web.xml` khai báo `MainController` là entry point của ứng dụng
- `nbproject/project.properties` cho thấy project đang dùng:
  - `j2ee.platform=1.7-web`
  - `javac.source=1.8`
  - server type là `Tomcat`
- `DBUtills.java` cho thấy project kết nối trực tiếp tới SQL Server bằng JDBC
- `project.xml` cho thấy project đang đóng gói thư viện:
  - `sqljdbc4.jar`
  - `JSTL` thông qua library của NetBeans

## Kiến trúc và tổ chức mã nguồn

Project áp dụng mô hình tổ chức tương đối rõ ràng:

- `controllers`: xử lý request/response, điều hướng luồng nghiệp vụ
- `DAO`: làm việc trực tiếp với database bằng JDBC
- `DTO`: các lớp dữ liệu trung gian giữa database và controller/view
- `mylib`: tiện ích dùng chung như hằng số và lớp kết nối DB
- `web`: toàn bộ giao diện JSP, CSS, tài nguyên ảnh

### Mô hình điều hướng

Ứng dụng sử dụng `MainController` như một `Front Controller`.

Luồng tổng quát:

`Browser -> MainController -> Specific Controller -> DAO -> SQL Server -> JSP`

### Snapshot nhanh của codebase

- `88` file Java nguồn
- `30` file JSP
- `8` nhóm controller
- `8` nhóm DAO
- `13` bảng dữ liệu chính trong script SQL

## Cấu trúc thư mục

```text
PRJ301-hotelManagement/
├─ img/
│  └─ Ảnh logo, ảnh phòng, QR
├─ Project Problem for FALL 2025/
│  ├─ Given.sql
│  ├─ PRJ_Student1.docx
│  └─ project problem for all 2025 block 10w.docx
├─ src-code/
│  └─ HotelManagementSystem/
│     ├─ build.xml
│     ├─ lib/
│     │  └─ sqljdbc4.jar
│     ├─ nbproject/
│     ├─ src/
│     │  ├─ conf/
│     │  └─ java/
│     │     ├─ controllers/
│     │     ├─ DAO/
│     │     ├─ DTO/
│     │     └─ mylib/
│     └─ web/
│        ├─ common/
│        ├─ css/
│        ├─ img/
│        ├─ role/
│        │  ├─ admin/
│        │  ├─ guest/
│        │  ├─ housekeeping/
│        │  ├─ manager/
│        │  ├─ receptionist/
│        │  └─ service/
│        ├─ META-INF/
│        └─ WEB-INF/
└─ README.md
```

## Cơ sở dữ liệu

Tên database theo code và script:

- `HotelManagement`

### Các bảng chính

Script `Given.sql` tạo các bảng sau:

1. `GUEST`
2. `ROOM_TYPE`
3. `ROOM`
4. `STAFF`
5. `SERVICE`
6. `BOOKING`
7. `BOOKING_SERVICE`
8. `INVOICE`
9. `PAYMENT`
10. `DEVICE`
11. `MAINTENANCE_ISSUE`
12. `HOUSEKEEPING_TASK`
13. `TAX_CONFIG`

### Ý nghĩa dữ liệu

- `GUEST`, `STAFF`: quản lý tài khoản người dùng và nhân viên
- `ROOM_TYPE`, `ROOM`: quản lý phòng và loại phòng
- `BOOKING`: quản lý đơn đặt phòng
- `BOOKING_SERVICE`: quản lý dịch vụ phát sinh theo booking
- `INVOICE`, `PAYMENT`: quản lý hóa đơn và thanh toán
- `DEVICE`, `MAINTENANCE_ISSUE`: theo dõi thiết bị và sự cố bảo trì
- `HOUSEKEEPING_TASK`: theo dõi công việc dọn phòng
- `TAX_CONFIG`: cấu hình VAT/thuế

### Trigger đáng chú ý trong `Given.sql`

Script CSDL có thêm 2 trigger hữu ích:

- `trg_BOOKING_SERVICE_AutoAssignStaff`
  - Tự động gán ngẫu nhiên nhân viên `ServiceStaff` cho booking dịch vụ mới
- `trg_ROOM_AutoAssign_Housekeeping`
  - Khi phòng chuyển sang `Dirty` hoặc `Maintenance`, hệ thống tự tạo task housekeeping nếu chưa có task đang mở

### Seed data hiện có

`Given.sql` đang seed sẵn:

- loại phòng
- danh sách phòng
- dịch vụ
- nhân viên theo nhiều vai trò
- cấu hình thuế VAT
- thiết bị và một số sự cố bảo trì

Lưu ý:

- Script chưa seed sẵn dữ liệu khách hàng/booking/invoice/payment ở mức lớn
- Các báo cáo về doanh thu, đặt phòng, dịch vụ sẽ có dữ liệu rõ hơn sau khi hệ thống được sử dụng hoặc khi bạn tự thêm dữ liệu test

## Yêu cầu môi trường

Để chạy project ổn định, nên chuẩn bị:

- `JDK 8`
- `Apache Tomcat 8.5` hoặc `Tomcat 9`
- `Microsoft SQL Server`
- `NetBeans` (khuyến nghị mạnh vì project đang theo cấu trúc NetBeans + Ant)
- Thư viện `JSTL`

> Vì mã nguồn đang dùng namespace `javax.servlet.*`, bạn nên dùng Tomcat 9 trở xuống. Tomcat 10+ chuyển sang `jakarta.*` và có thể không tương thích trực tiếp.

## Hướng dẫn cài đặt và chạy

### Bước 1. Tạo database

Chạy file:

- `Project Problem for FALL 2025/Given.sql`

Script này sẽ:

- xóa database cũ nếu đã tồn tại
- tạo lại database `HotelManagement`
- tạo bảng
- thêm seed data
- tạo trigger

### Bước 2. Kiểm tra cấu hình kết nối database

File cấu hình kết nối hiện tại:

- `src-code/HotelManagementSystem/src/java/mylib/DBUtills.java`

Cấu hình mặc định trong code:

```java
private static final String DB_NAME = "HotelManagement";
private static final String DB_USER_NAME = "SA";
private static final String DB_PASSWORD = "12345";
String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DB_NAME;
```

Nếu máy của bạn dùng:

- user SQL Server khác
- password khác
- cổng khác `1433`

thì cần sửa file này trước khi chạy.

### Bước 3. Mở project bằng NetBeans

Mở thư mục:

- `src-code/HotelManagementSystem`

Project này đã có sẵn:

- `build.xml`
- `nbproject/project.properties`
- cấu hình web app NetBeans

### Bước 4. Cấu hình server Tomcat

Trong NetBeans:

- add Apache Tomcat vào IDE
- gán Tomcat cho project
- kiểm tra context path hiện tại là `/HotelManagementSystem`

File context hiện tại:

- `src-code/HotelManagementSystem/web/META-INF/context.xml`

### Bước 5. Bổ sung JSTL nếu môi trường chưa có

Project đang khai báo JSTL thông qua library của NetBeans chứ không đóng kèm `.jar` trong repo.

Nếu project báo lỗi JSTL:

- hãy add thư viện `JSTL` vào project trong NetBeans
- hoặc chép JSTL jar vào `WEB-INF/lib` theo môi trường của bạn

### Bước 6. Build và chạy

Trong NetBeans:

- `Clean and Build`
- `Run`

Sau khi chạy, truy cập:

```text
http://localhost:8080/HotelManagementSystem/
```

Hoặc:

```text
http://localhost:8080/HotelManagementSystem/MainController
```

Do `web.xml` đã cấu hình:

- `welcome-file` là `MainController`

## Tài khoản mẫu để đăng nhập

Các tài khoản mẫu được seed trong `Given.sql`:

| Vai trò | Username | Password | Trạng thái |
| --- | --- | --- | --- |
| Admin | `AnNguyen` | `123` | Active |
| Receptionist | `VanVy` | `111` | Active |
| Manager | `AnhTran` | `222` | Active |
| Housekeeping | `BaoLe` | `333` | Active |
| ServiceStaff | `PhamYen` | `444` | Active |

Lưu ý:

- Hệ thống chỉ cho nhân viên đăng nhập khi `Status = Active`
- Tài khoản `Guest` không được seed sẵn rõ ràng trong script hiện tại, nên bạn có thể tự đăng ký ở giao diện `Signup`

## Điểm nổi bật của dự án

- Hỗ trợ nhiều vai trò thực tế trong một hệ thống duy nhất
- Bao phủ trọn quy trình nghiệp vụ khách sạn: đặt phòng -> check-in -> dùng dịch vụ -> checkout -> thanh toán -> hóa đơn
- Có thống kê và báo cáo cho quản lý, dịch vụ và buồng phòng
- Có trigger hỗ trợ tự động hóa một phần nghiệp vụ trong CSDL
- Cấu trúc code dễ học, phù hợp cho đồ án môn học Java Web
- Phân tách tương đối rõ giữa controller, DAO, DTO và JSP

## Hạn chế và lưu ý

Đây là một project học thuật, vì vậy vẫn có một số điểm cần lưu ý:

- Chưa sử dụng Maven/Gradle, việc quản lý dependency còn phụ thuộc NetBeans
- Chưa có bộ test tự động trong repo
- Thông tin kết nối database đang hard-code trong source code
- Project phù hợp để chạy local/dev hơn là production
- Một số báo cáo cần dữ liệu booking/thanh toán phát sinh thực tế mới hiển thị rõ

Nếu muốn phát triển tiếp, có thể cân nhắc:

- tách cấu hình DB ra file `.properties`
- dùng password hashing thực sự
- thêm phân quyền bằng filter/interceptor
- chuyển sang Maven hoặc Gradle
- viết unit test / integration test
- cải thiện UI/UX và chuẩn hóa CSS dùng chung

## Tài liệu đi kèm trong repo

- `Project Problem for FALL 2025/Given.sql`: script tạo database và dữ liệu mẫu
- `Project Problem for FALL 2025/PRJ_Student1.docx`: tài liệu liên quan đến bài tập/dự án
- `Project Problem for FALL 2025/project problem for all 2025 block 10w.docx`: đề bài/tài liệu học phần

---

## Kết luận

`Hotel Management System` là một dự án Java Web khá đầy đủ cho bài toán quản lý khách sạn ở mức học thuật: có quản lý phòng, booking, dịch vụ, buồng phòng, báo cáo quản trị, hóa đơn, thanh toán và quản trị nhân sự.

Nếu bạn đang dùng repo này để học tập, demo môn học hoặc tiếp tục phát triển đồ án, đây là một nền tảng tốt để mở rộng thêm:

- phân quyền chặt hơn
- báo cáo đẹp hơn
- API REST
- dashboard hiện đại hơn
- tích hợp thanh toán thật

README này được viết dựa trên cấu trúc và mã nguồn hiện có trong repo, không chỉ dựa trên tên project.
