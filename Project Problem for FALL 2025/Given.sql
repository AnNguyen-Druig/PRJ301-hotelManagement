
-- ======================================================
-- Hotel Management System Database (Fall 2025)
-- Rebuild DB, keep OLD seed data + add NEW seed data for reports/statistics.
-- No VIEWs, ready for development/testing.
-- ======================================================

USE master;
GO

DROP DATABASE IF EXISTS HotelManagement;
GO

CREATE DATABASE HotelManagement COLLATE Vietnamese_CI_AS;
GO

USE HotelManagement;
GO

-- ======================================================
-- 1. Guest
-- ======================================================
CREATE TABLE GUEST (
    GuestID INT IDENTITY(1,1) PRIMARY KEY,
	Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) UNIQUE,
    Email NVARCHAR(100) UNIQUE,
    Address NVARCHAR(200),
    IDNumber NVARCHAR(12) UNIQUE,
    DateOfBirth DATE
);

-- ======================================================
-- 2. Room Type
-- ======================================================
CREATE TABLE ROOM_TYPE (
    RoomTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL CHECK (Capacity > 0),
    PricePerNight DECIMAL(10,2) NOT NULL CHECK (PricePerNight >= 0)
);

-- ======================================================
-- 3. Room
-- ======================================================
CREATE TABLE ROOM (
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    RoomNumber NVARCHAR(10) UNIQUE NOT NULL,
    RoomTypeID INT NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Available','Occupied','Dirty','Maintenance')),
    FOREIGN KEY (RoomTypeID) REFERENCES ROOM_TYPE(RoomTypeID)
);

-- ======================================================
-- 4. Staff
-- ======================================================
CREATE TABLE STAFF (
    StaffID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Role NVARCHAR(50) CHECK (Role IN ('Receptionist','Manager','Housekeeping','ServiceStaff','Admin')),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    
    -- CÁC CỘT MỚI ĐƯỢC THÊM VÀO --
    Address NVARCHAR(200) NULL,
    IDNumber NVARCHAR(12) UNIQUE NULL,
	DateOfBirth DATE,

    Status NVARCHAR(20) NOT NULL DEFAULT N'Active' CHECK (Status IN (N'Active', N'Inactive'))
);

-- ======================================================
-- 5. Service
-- ======================================================
CREATE TABLE SERVICE (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName NVARCHAR(100) NOT NULL,
    ServiceType NVARCHAR(50),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
);

-- ======================================================
-- 6. Booking
-- ======================================================
CREATE TABLE BOOKING (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    GuestID INT NOT NULL,
    RoomID INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    BookingDate DATE DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Reserved','CheckIn','CheckOut','Canceled','Complete')),
    FOREIGN KEY (GuestID) REFERENCES GUEST(GuestID),
    FOREIGN KEY (RoomID) REFERENCES ROOM(RoomID),
    CHECK (CheckOutDate > CheckInDate)
);

-- ======================================================
-- 7. Booking_Service
-- ======================================================
CREATE TABLE BOOKING_SERVICE (
    Booking_Service_ID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT NOT NULL,
    ServiceID INT NOT NULL,
    Quantity INT DEFAULT 1 CHECK (Quantity > 0),
    ServiceDate DATE DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Pending','Completed','Canceled')),
    AssignedStaff INT NULL,
    FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID),
    FOREIGN KEY (ServiceID) REFERENCES SERVICE(ServiceID),
    FOREIGN KEY (AssignedStaff) REFERENCES STAFF(StaffID),
	RequestTime INT NOT NULL CHECK (RequestTime >= 0)
);

-- ======================================================
-- 8. Invoice
-- ======================================================
CREATE TABLE INVOICE (
    InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT NOT NULL UNIQUE,
    IssueDate DATE DEFAULT GETDATE(),
    TotalAmount DECIMAL(12,2) NOT NULL CHECK (TotalAmount >= 0),
    Status NVARCHAR(20) CHECK (Status IN ('Unpaid','Paid','Canceled')),
    FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID)
);

-- ======================================================
-- 9. Payment
-- ======================================================
CREATE TABLE PAYMENT (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT NOT NULL,
    PaymentDate DATE DEFAULT GETDATE(),
    Amount DECIMAL(12,2) NOT NULL CHECK (Amount >= 0),
    PaymentMethod NVARCHAR(50) CHECK (PaymentMethod IN ('Cash','Credit Card','Debit Card','Online')),
    Status NVARCHAR(20) CHECK (Status IN ('Pending','Completed','Failed')),
    FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID)
);

-- ======================================================
-- 10. Device (for maintenance / room equipment)
-- ======================================================
CREATE TABLE DEVICE (
    DeviceID INT IDENTITY(1,1) PRIMARY KEY,
    DeviceName NVARCHAR(100) NOT NULL,
    RoomID INT NULL,
    DeviceType NVARCHAR(50),
    Status NVARCHAR(20) CHECK (Status IN ('Working','Broken','Under Repair')),
    LastMaintenanceDate DATE,
    FOREIGN KEY (RoomID) REFERENCES ROOM(RoomID)
);

-- ======================================================
-- 11. Maintenance Issue
-- ======================================================
CREATE TABLE MAINTENANCE_ISSUE (
    IssueID INT IDENTITY(1,1) PRIMARY KEY,
    RoomID INT NOT NULL,
    DeviceID INT NULL,
    Description NVARCHAR(255),
    ReportDate DATE DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Pending','Fixed')),
    FixedBy INT NULL,
    FOREIGN KEY (RoomID) REFERENCES ROOM(RoomID),
    FOREIGN KEY (DeviceID) REFERENCES DEVICE(DeviceID),
    FOREIGN KEY (FixedBy) REFERENCES STAFF(StaffID)
);

-- ======================================================
-- 12. HouseKeeping Task
-- ======================================================

CREATE TABLE dbo.HOUSEKEEPING_TASK(
      TaskID        INT IDENTITY(1,1) PRIMARY KEY,
      RoomID        INT NOT NULL FOREIGN KEY REFERENCES dbo.ROOM(RoomID),
      AssignedStaff INT FOREIGN KEY REFERENCES dbo.STAFF(StaffID),
      TaskDate      DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
      CleaningType  NVARCHAR(30) NOT NULL DEFAULT N'regular', -- regular/deep/post-checkout
      Notes         NVARCHAR(255) NULL,
      Status        NVARCHAR(20) NOT NULL 
          CHECK (Status IN ('Pending','InProgress','Completed','Canceled')) 
          DEFAULT 'Pending'
  );

CREATE TABLE TAX_CONFIG (
    TaxID INT IDENTITY(1,1) PRIMARY KEY,
    TaxName NVARCHAR(50) UNIQUE NOT NULL, -- Ví dụ: 'VAT', 'Service Tax'
    TaxValue DECIMAL(5,4) NOT NULL CHECK (TaxValue >= 0), -- Ví dụ: 0.08 (cho 8%)
    Description NVARCHAR(255),
    LastUpdated DATETIME DEFAULT GETDATE()
);

-- ======================================================
-- OLD SEED DATA (from previous GivenDB.sql)
-- ======================================================

-- ROOM_TYPE
INSERT INTO ROOM_TYPE (TypeName, Capacity, PricePerNight)
VALUES 
(N'Single', 1, 500000),      -- 500.000 VNĐ
(N'Double', 2, 800000),      -- 800.000 VNĐ
(N'Suite', 4, 1500000),      -- 1.500.000 VNĐ
(N'Deluxe', 3, 1200000),     -- 1.200.000 VNĐ
(N'Family', 5, 2000000),     -- 2.000.000 VNĐ
(N'Executive', 2, 1000000);  -- 1.000.000 VNĐ


-- ROOM
INSERT INTO ROOM (RoomNumber, RoomTypeID, Status)
VALUES 
(N'101', 1, N'Available'),
(N'102', 2, N'Available'),
(N'201', 3, N'Available'),
(N'103', 1, N'Available'),
(N'104', 2, N'Occupied'),
(N'105', 1, N'Available'),
(N'106', 1, N'Available'),
(N'107', 1, N'Dirty'),
(N'108', 2, N'Available'),
(N'109', 2, N'Available'),
(N'110', 2, N'Maintenance'),
(N'209', 3, N'Available'),
(N'210', 3, N'Available'),
(N'202', 3, N'Dirty'),
(N'203', 4, N'Available'),
(N'205', 4, N'Available'),
(N'206', 4, N'Available'),
(N'303', 4, N'Available'),
(N'304', 4, N'Available'),
(N'305', 4, N'Occupied'),
(N'204', 5, N'Maintenance'),
(N'207', 5, N'Available'),
(N'208', 5, N'Available'),
(N'306', 5, N'Available'),
(N'307', 5, N'Available'),
(N'308', 5, N'Maintenance'),
(N'301', 6, N'Available'),
(N'302', 6, N'Available'),
(N'309', 6, N'Available'),
(N'310', 6, N'Available')

-- SERVICE
INSERT INTO SERVICE (ServiceName, ServiceType, Price)
VALUES
(N'Breakfast', N'Food', 100000),       -- 100.000 VNĐ
(N'Laundry', N'Laundry', 50000),       -- 50.000 VNĐ
(N'Spa Massage', N'Spa', 300000),      -- 300.000 VNĐ
(N'Lunch Buffet', N'Food', 150000),    -- 150.000 VNĐ
(N'Dry Cleaning', N'Laundry', 80000),  -- 80.000 VNĐ
(N'Gym Access', N'Spa', 200000),       -- 200.000 VNĐ
(N'Room Service Delivery', N'Food', 50000), -- 50.000 VNĐ
(N'Swimming Pool', N'Spa', 250000);    -- 250.000 VNĐ

-- STAFF (Đã cập nhật với DateOfBirth)
INSERT INTO STAFF (
    FullName, Role, Username, PasswordHash, Phone, Email, 
    Address, IDNumber, DateOfBirth, Status
)
VALUES 
-- Admins
(N'Nguyễn Trần Đạt Ân', N'Admin', N'AnNguyen', N'123', N'0123456789', N'nguyentrandatan@gmail.com', N'123 Đường A, Quận 1, TP.HCM', N'001080123451', '1990-01-01', N'Active'),
(N'Trịnh Nhật Quang', N'Admin', N'QuangTrinh', N'456', N'0987654321', N'trinhnhatquang@gmail.com', N'456 Đường B, Quận 3, TP.HCM', N'001080123452', '1992-02-15', N'Active'),
(N'Nguyễn Bá Đại', N'Admin', N'NguyenDai', N'789', N'0123459876', N'nguyenbadai@gmail.com', N'789 Đường C, Quận 5, TP.HCM', N'001080123453', '1988-11-30', N'Active'),

-- Receptionists (Active)
(N'Nguyễn Văn Vỹ', N'Receptionist', N'VanVy', N'111', N'0999900001', N'nguyenvanv@hotel.com', N'111 Đường D, Quận 10, TP.HCM', N'001080123454', '1995-03-20', N'Active'),
(N'Hoàng Văn An', N'Receptionist', N'AnHoang', N'555', N'04333344445', N'hoangvanz@hotel.com', N'222 Đường E, Quận Bình Thạnh, TP.HCM', N'001080123455', '1998-07-07', N'Active'),

-- Managers (Active)
(N'Trần Thị Anh', N'Manager', N'AnhTran', N'222', N'0200011112', N'tranthiw@hotel.com', N'333 Đường F, Quận Phú Nhuận, TP.HCM', N'001080123456', '1985-12-10', N'Active'),
(N'Bùi Thị Cung', N'Manager', N'BuiCung', N'888', N'09666677778', N'buithicc@hotel.com', N'444 Đường G, Quận 7, TP.HCM', N'001080123457', '1991-04-25', N'Active'),

-- Housekeeping (Active)
(N'Lê Văn Bảo', N'Housekeeping', N'BaoLe', N'333', N'0311122223', N'levanx@hotel.com', N'555 Đường H, Quận Gò Vấp, TP.HCM', N'001080123458', '1999-08-14', N'Active'),
(N'Vũ Thị Lựu', N'Housekeeping', N'VuLuu', N'666', N'06444455556', N'vuthiaa@hotel.com', N'666 Đường I, Quận Tân Bình, TP.HCM', N'001080123459', '1997-06-18', N'Active'),

-- ServiceStaff (Active)
(N'Phạm Thị Yến', N'ServiceStaff', N'PhamYen', N'444', N'0422233334', N'phamthiy@hotel.com', N'777 Đường K, Quận 12, TP.HCM', N'001080123460', '2000-10-05', N'Active'),
(N'Đặng Văn Bảo', N'ServiceStaff', N'DangBao', N'777', N'07555566667', N'dangvanbb@hotel.com', N'888 Đường L, TP. Thủ Đức', N'001080123461', '1996-09-09', N'Active'),

-- Inactive Staff
(N'Trần Văn Long', N'Receptionist', N'LongTran', N'1001', N'0905111222', N'longtran@hotel.com', N'101 Đường M, Quận 1, TP.HCM', N'001080123462', '1994-01-22', N'Inactive'),
(N'Lê Thị Hoa', N'Housekeeping', N'HoaLe', N'1002', N'0905333444', N'hoale@hotel.com', N'102 Đường N, Quận 3, TP.HCM', N'001080123463', '1993-02-23', N'Inactive'),
(N'Phan Thanh Tâm', N'ServiceStaff', N'TamPhan', N'1003', N'0905555666', 'tamphan@hotel.com', N'103 Đường O, Quận 5, TP.HCM', N'001080123464', '1992-03-24', N'Inactive'),
(N'Đỗ Hùng Dũng', N'Receptionist', N'DungDo', N'1004', N'0905777888', N'dungdo@hotel.com', N'104 Đường P, Quận 7, TP.HCM', N'001080123465', '1991-04-25', N'Inactive'),
(N'Mai Thị Lan', N'Manager', N'LanMai', N'1005', N'0905999000', N'lanmai@hotel.com', N'105 Đường Q, Quận 10, TP.HCM', N'001080123466', '1989-05-26', N'Inactive');
--TAX 
INSERT INTO TAX_CONFIG (TaxName, TaxValue, Description)
VALUES (N'VAT', 0.1, N'Thuế suất Giá trị gia tăng (VAT) hiện hành');
Go
INSERT INTO DEVICE (DeviceName, RoomID, DeviceType, Status, LastMaintenanceDate)
VALUES
(N'Air Conditioner', (SELECT RoomID FROM ROOM WHERE RoomNumber = N'110'), N'Appliance', N'Broken', '2025-10-20'),
(N'Sink', (SELECT RoomID FROM ROOM WHERE RoomNumber = N'204'), N'Plumbing', N'Under Repair', '2025-10-15'),
(N'Television', (SELECT RoomID FROM ROOM WHERE RoomNumber = N'308'), N'Electronics', N'Working', '2025-09-25'),
(N'Ceiling Light', (SELECT RoomID FROM ROOM WHERE RoomNumber = N'107'), N'Lighting', N'Broken', '2025-10-26'),
(N'Mini Fridge', (SELECT RoomID FROM ROOM WHERE RoomNumber = N'305'), N'Appliance', N'Working', '2025-10-22');
GO
-- ======================================================
-- SEED DATA: Maintenance Issues
-- ======================================================

INSERT INTO MAINTENANCE_ISSUE (RoomID, DeviceID, Description, ReportDate, Status, FixedBy)
VALUES
-- Room 110: Broken AC, not yet fixed
((SELECT RoomID FROM ROOM WHERE RoomNumber = N'110'),
 (SELECT DeviceID FROM DEVICE WHERE DeviceName = N'Air Conditioner' AND RoomID = (SELECT RoomID FROM ROOM WHERE RoomNumber = N'110')),
 N'Air conditioner not cooling properly',
 '2025-10-25',
 N'Pending',
 NULL),

-- Room 204: Plumbing issue fixed by Housekeeping staff
((SELECT RoomID FROM ROOM WHERE RoomNumber = N'204'),
 (SELECT DeviceID FROM DEVICE WHERE DeviceName = N'Sink' AND RoomID = (SELECT RoomID FROM ROOM WHERE RoomNumber = N'204')),
 N'Leaking sink under bathroom cabinet',
 '2025-10-15',
 N'Fixed',
 (SELECT StaffID FROM STAFF WHERE FullName = N'Lê Văn Bảo')),

-- Room 308: Broken TV fixed
((SELECT RoomID FROM ROOM WHERE RoomNumber = N'308'),
 (SELECT DeviceID FROM DEVICE WHERE DeviceName = N'Television' AND RoomID = (SELECT RoomID FROM ROOM WHERE RoomNumber = N'308')),
 N'TV not turning on',
 '2025-09-30',
 N'Fixed',
 (SELECT StaffID FROM STAFF WHERE FullName = N'Đặng Văn Bảo')),

-- Room 107: Light bulb problem, pending
((SELECT RoomID FROM ROOM WHERE RoomNumber = N'107'),
 (SELECT DeviceID FROM DEVICE WHERE DeviceName = N'Ceiling Light' AND RoomID = (SELECT RoomID FROM ROOM WHERE RoomNumber = N'107')),
 N'Ceiling light flickers when turned on',
 '2025-10-26',
 N'Pending',
 NULL),

-- Room 305: Mini-fridge fixed
((SELECT RoomID FROM ROOM WHERE RoomNumber = N'305'),
 (SELECT DeviceID FROM DEVICE WHERE DeviceName = N'Mini Fridge' AND RoomID = (SELECT RoomID FROM ROOM WHERE RoomNumber = N'305')),
 N'Mini fridge not cooling properly',
 '2025-10-20',
 N'Fixed',
 (SELECT StaffID FROM STAFF WHERE FullName = N'Phạm Thị Yến'));
GO


CREATE OR ALTER TRIGGER dbo.trg_BOOKING_SERVICE_AutoAssignStaff
ON dbo.BOOKING_SERVICE
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  ;WITH Picked AS (
    SELECT i.Booking_Service_ID,
           s.StaffID
    FROM inserted i
    OUTER APPLY (
        SELECT TOP (1) StaffID
        FROM dbo.STAFF
        WHERE Role = 'ServiceStaff'
        ORDER BY NEWID()               -- ngẫu nhiên
    ) s
  )
  UPDATE bs
    SET AssignedStaff = p.StaffID
  FROM dbo.BOOKING_SERVICE bs
  JOIN Picked p ON p.Booking_Service_ID = bs.Booking_Service_ID
  WHERE bs.AssignedStaff IS NULL;      -- chỉ auto-assign nếu chưa có
END
GO

CREATE OR ALTER TRIGGER dbo.trg_ROOM_AutoAssign_Housekeeping
ON dbo.ROOM
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  ;WITH DirtyOrOccurp AS (
      SELECT i.RoomID
      FROM inserted i
      JOIN deleted  d ON d.RoomID = i.RoomID
      WHERE i.Status IN (N'Dirty', N'Maintenance')
        AND ISNULL(d.Status, N'') NOT IN (N'Dirty', N'Maintenance')
  ),
  NeedTask AS (
      SELECT dr.RoomID
      FROM DirtyOrOccurp dr
      WHERE NOT EXISTS (
          SELECT 1 
          FROM dbo.HOUSEKEEPING_TASK t
          WHERE t.RoomID = dr.RoomID 
            AND t.Status IN (N'Pending', N'InProgress')
      )
  )
  INSERT INTO dbo.HOUSEKEEPING_TASK (RoomID, AssignedStaff, CleaningType, Status)
  SELECT RoomID, NULL, N'regular', N'Pending'
  FROM NeedTask;
END;
GO

