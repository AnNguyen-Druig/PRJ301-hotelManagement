
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
    Email NVARCHAR(100)
);

-- ======================================================
-- 5. Service
-- ======================================================
CREATE TABLE SERVICE (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName NVARCHAR(100) NOT NULL,
    ServiceType NVARCHAR(50),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0)
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
    FOREIGN KEY (AssignedStaff) REFERENCES STAFF(StaffID)
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
-- OLD SEED DATA (from previous GivenDB.sql)
-- ======================================================

-- ROOM_TYPE
INSERT INTO ROOM_TYPE (TypeName, Capacity, PricePerNight)
VALUES 
(N'Single', 1, 50.00),
(N'Double', 2, 80.00),
(N'Suite', 4, 150.00),
(N'Deluxe', 3, 120.00),
(N'Family', 5, 200.00),
(N'Executive', 2, 100.00);

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
(N'Breakfast', N'Food', 10.00),
(N'Laundry', N'Laundry', 5.00),
(N'Spa Massage', N'Spa', 30.00),
(N'Lunch Buffet', N'Food', 15.00),
(N'Dry Cleaning', N'Laundry', 8.00),
(N'Gym Access', N'Spa', 20.00),
(N'Room Service Delivery', N'Food', 5.00),
(N'Swimming Pool', N'Spa', 25.00);

-- STAFF
INSERT INTO STAFF (FullName, Role, Username, PasswordHash, Phone, Email)
VALUES 
(N'Nguyễn Trần Đạt Ân', N'Admin', N'AnNguyen', N'123', N'0123456789', N'nguyentrandatan@gmail.com'),
(N'Trịnh Nhật Quang', N'Admin', N'QuangTrinh', N'456', N'0987654321', N'trinhnhatquang@gmail.com'),
(N'Nguyễn Bá Đại', N'Admin', N'NguyenDai', N'789', N'0123459876', N'nguyenbadai@gmail.com'),
(N'Nguyễn Văn Vỹ', N'Receptionist', N'VanVy', N'111', N'0999900001', N'nguyenvanv@hotel.com'),
(N'Trần Thị Anh', N'Manager', N'AnhTran', N'222', N'0200011112', N'tranthiw@hotel.com'),
(N'Lê Văn Bảo', N'Housekeeping', N'BaoLe', N'333', N'0311122223', N'levanx@hotel.com'),
(N'Phạm Thị Yến', N'ServiceStaff', N'PhamYen', N'444', N'0422233334', N'phamthiy@hotel.com'),
(N'Hoàng Văn An', N'Receptionist', N'AnHoang', N'555', N'04333344445', N'hoangvanz@hotel.com'),
(N'Vũ Thị Lựu', N'Housekeeping', N'VuLuu', N'666', N'06444455556', N'vuthiaa@hotel.com'),
(N'Đặng Văn Bảo', N'ServiceStaff', N'DangBao', N'777', N'07555566667', N'dangvanbb@hotel.com'),
(N'Bùi Thị Cung', N'Manager', N'BuiCung', N'888', N'09666677778', N'buithicc@hotel.com');

