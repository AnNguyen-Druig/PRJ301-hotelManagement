# Hotel Management System

![Hotel Logo](img/LOGO_HOTEL.jpg)

> A multi-role hotel management system built with the traditional Java Web stack using Servlet/JSP for the PRJ301 course project.

## Table of Contents

1. [Project Overview](#project-overview)
2. [What Is This Project For?](#what-is-this-project-for)
3. [Core Features by Role](#core-features-by-role)
4. [End-to-End Business Flow](#end-to-end-business-flow)
5. [Technology Stack](#technology-stack)
6. [Architecture and Source Organization](#architecture-and-source-organization)
7. [Directory Structure](#directory-structure)
8. [Database](#database)
9. [Environment Requirements](#environment-requirements)
10. [Setup and Run Guide](#setup-and-run-guide)
11. [Sample Login Accounts](#sample-login-accounts)
12. [Project Highlights](#project-highlights)
13. [Limitations and Notes](#limitations-and-notes)
14. [Repository Documents](#repository-documents)

## Project Overview

`Hotel Management System` is a Java Web-based hotel management application that supports multiple roles within a single system:

- Guest
- Receptionist
- Manager
- Housekeeping
- Service Staff
- Admin

The application follows a simple MVC-oriented structure and uses:

- `Servlet` for business logic handling
- `JSP` for rendering the user interface
- `DAO + DTO` for data access and data transfer
- `JDBC` for direct connection to `Microsoft SQL Server`

The main source code is located in:

- `src-code/HotelManagementSystem`

The database script and seed data are located in:

- `Project Problem for FALL 2025/Given.sql`

## What Is This Project For?

This project was built to digitize the core operational workflows of a hotel, from room booking to payment and invoice generation.

More specifically, the system helps with:

- Managing room lists, room types, and room status
- Allowing guests to register, log in, and book rooms online
- Searching for available rooms by room type and stay period
- Managing the full booking lifecycle: `Reserved`, `CheckIn`, `CheckOut`, `Canceled`, `Complete`
- Allowing in-house guests to request additional services
- Supporting receptionists in handling check-in, check-out, and booking updates
- Supporting housekeeping staff in tracking room status and cleaning tasks
- Supporting service staff in processing service requests for each booking
- Supporting managers in monitoring revenue, customers, occupancy rate, and cancellation statistics
- Supporting admins in managing employees and tax/service price configuration

In short, this is an end-to-end academic hotel management system that still covers a fairly complete set of real-world hotel operations.

## Core Features by Role

### 1. Guest

- Register a member account
- Log in as a guest
- View available rooms
- Filter rooms by room type, check-in date, and check-out date
- Book rooms directly through the interface
- View reserved and active bookings
- Cancel a booking before check-in
- Order additional services for an active booking
- Check out and choose a payment method
- View the invoice after payment

### 2. Receptionist

- View the full booking list
- Filter bookings by status
- Create a new booking based on a guest ID card
- Open the booking detail page for updates
- Change room assignment or check-in/check-out dates in a booking
- Process `Check In`
- Process `Check Out`
- Cancel bookings
- Confirm checkout completion

### 3. Service Staff

- View the list of rooms/bookings that require service
- Open the service list for each booking
- Track services requested by guests
- Update service status
- View service-related reports

### 4. Housekeeping

- View the list of rooms and their current status
- Update room status such as `Available`, `Dirty`, `Maintenance`, and `Occupied`
- View cleaning tasks with status `Pending` or `InProgress`
- Accept tasks, update cleaning type, and update task status
- Once cleaning is completed, the system updates the room back to `Available`
- View housekeeping and maintenance reports

### 5. Manager

- View daily revenue
- View monthly and yearly revenue
- View yearly revenue
- View the top 10 most frequent customers
- View customers with the highest total spending
- View the most frequently used services
- View the highest- and lowest-revenue services
- View room occupancy rates by month/year
- View cancellation statistics by time and room type

### 6. Admin

- View the full employee list
- Filter employees by role and status
- Add new employees
- Update employee information
- Delete employees
- Change the VAT tax value
- Change service prices

## End-to-End Business Flow

1. A guest creates an account or logs into the system.
2. The guest searches for available rooms by room type and stay date range.
3. The guest makes a booking, and the system creates it with the status `Reserved`.
4. The receptionist receives the booking, updates it if needed, and changes the status to `CheckIn`.
5. During the stay, the guest can request additional services, which are received and processed by the service staff.
6. When the guest checks out, the system calculates room charges + service charges + VAT.
7. The system stores the `Payment` and `Invoice` records, then updates the booking to the appropriate status.
8. Housekeeping staff and managers monitor rooms, tasks, reports, and operational statistics.

## Technology Stack

| Category | Technology / Component |
| --- | --- |
| Main language | Java 8 |
| Web backend | Java Servlet, JSP |
| View engine | JSP + JSTL |
| Data access | Plain JDBC |
| Code organization pattern | MVC, Front Controller, DAO, DTO |
| Database | Microsoft SQL Server |
| Web server / Servlet container | Apache Tomcat |
| Build tool | Apache Ant |
| IDE best suited for this project | NetBeans |
| JDBC library | `sqljdbc4.jar` |
| Frontend | HTML, CSS, and a small amount of JavaScript embedded in JSP |
| Session/Auth | `HttpSession` for both `STAFF` and `USER` sessions |

### Technologies Confirmed Directly from the Codebase

- `web.xml` defines `MainController` as the application's entry point
- `nbproject/project.properties` shows that the project uses:
  - `j2ee.platform=1.7-web`
  - `javac.source=1.8`
  - `Tomcat` as the server type
- `DBUtills.java` shows that the project connects directly to SQL Server through JDBC
- `project.xml` shows that the project includes:
  - `sqljdbc4.jar`
  - `JSTL` through NetBeans library configuration

## Architecture and Source Organization

The project follows a fairly clear organizational structure:

- `controllers`: handle request/response logic and business flow routing
- `DAO`: work directly with the database through JDBC
- `DTO`: data transfer classes used between the database and the controller/view layers
- `mylib`: shared utilities such as constants and the database connection class
- `web`: all JSP views, CSS files, and image assets

### Routing Model

The application uses `MainController` as a `Front Controller`.

Overall flow:

`Browser -> MainController -> Specific Controller -> DAO -> SQL Server -> JSP`

### Quick Snapshot of the Codebase

- `88` Java source files
- `30` JSP files
- `8` controller groups
- `8` DAO groups
- `13` main tables in the SQL script

## Directory Structure

```text
PRJ301-hotelManagement/
|-- img/
|   `-- Logo images, room images, QR assets
|-- Project Problem for FALL 2025/
|   |-- Given.sql
|   |-- PRJ_Student1.docx
|   `-- project problem for all 2025 block 10w.docx
|-- src-code/
|   `-- HotelManagementSystem/
|       |-- build.xml
|       |-- lib/
|       |   `-- sqljdbc4.jar
|       |-- nbproject/
|       |-- src/
|       |   |-- conf/
|       |   `-- java/
|       |       |-- controllers/
|       |       |-- DAO/
|       |       |-- DTO/
|       |       `-- mylib/
|       `-- web/
|           |-- common/
|           |-- css/
|           |-- img/
|           |-- role/
|           |   |-- admin/
|           |   |-- guest/
|           |   |-- housekeeping/
|           |   |-- manager/
|           |   |-- receptionist/
|           |   `-- service/
|           |-- META-INF/
|           `-- WEB-INF/
`-- README.md
```

## Database

Database name used in both the source code and SQL script:

- `HotelManagement`

### Main Tables

The `Given.sql` script creates the following tables:

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

### Data Meaning

- `GUEST`, `STAFF`: manage guest and employee accounts
- `ROOM_TYPE`, `ROOM`: manage room types and rooms
- `BOOKING`: manage booking records
- `BOOKING_SERVICE`: manage service requests linked to bookings
- `INVOICE`, `PAYMENT`: manage invoicing and payments
- `DEVICE`, `MAINTENANCE_ISSUE`: track equipment and maintenance incidents
- `HOUSEKEEPING_TASK`: track cleaning tasks
- `TAX_CONFIG`: configure VAT/tax settings

### Notable Triggers in `Given.sql`

The database script includes two useful triggers:

- `trg_BOOKING_SERVICE_AutoAssignStaff`
  - Automatically assigns a random `ServiceStaff` member to a new booking service request
- `trg_ROOM_AutoAssign_Housekeeping`
  - When a room changes to `Dirty` or `Maintenance`, the system automatically creates a housekeeping task if no open task exists yet

### Existing Seed Data

`Given.sql` already seeds:

- room types
- rooms
- services
- employees across multiple roles
- VAT configuration
- devices and some maintenance issues

Note:

- The script does not seed a large amount of guest, booking, invoice, or payment data
- Revenue, booking, and service reports will become more meaningful after the system has been used or after you add your own test data

## Environment Requirements

To run the project smoothly, prepare the following:

- `JDK 8`
- `Apache Tomcat 8.5` or `Tomcat 9`
- `Microsoft SQL Server`
- `NetBeans` strongly recommended because the project follows a NetBeans + Ant structure
- `JSTL` library

> Because the source code uses the `javax.servlet.*` namespace, you should use Tomcat 9 or below. Tomcat 10+ migrated to `jakarta.*` and may not be directly compatible.

## Setup and Run Guide

### Step 1. Create the Database

Run:

- `Project Problem for FALL 2025/Given.sql`

This script will:

- drop the old database if it already exists
- recreate the `HotelManagement` database
- create all tables
- insert seed data
- create triggers

### Step 2. Check the Database Connection Configuration

The current database connection file is:

- `src-code/HotelManagementSystem/src/java/mylib/DBUtills.java`

Default configuration in the code:

```java
private static final String DB_NAME = "HotelManagement";
private static final String DB_USER_NAME = "SA";
private static final String DB_PASSWORD = "12345";
String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DB_NAME;
```

If your machine uses:

- a different SQL Server username
- a different password
- a different port instead of `1433`

you need to update this file before running the project.

### Step 3. Open the Project in NetBeans

Open:

- `src-code/HotelManagementSystem`

This project already contains:

- `build.xml`
- `nbproject/project.properties`
- NetBeans web app configuration

### Step 4. Configure Tomcat

In NetBeans:

- add Apache Tomcat to the IDE
- assign Tomcat to the project
- verify that the current context path is `/HotelManagementSystem`

Current context file:

- `src-code/HotelManagementSystem/web/META-INF/context.xml`

### Step 5. Add JSTL If Your Environment Does Not Already Have It

The project references JSTL through a NetBeans library configuration rather than bundling the `.jar` file directly in the repository.

If the project reports JSTL errors:

- add the `JSTL` library to the project in NetBeans
- or copy the JSTL jar into `WEB-INF/lib` for your environment

### Step 6. Build and Run

In NetBeans:

- `Clean and Build`
- `Run`

After that, access:

```text
http://localhost:8080/HotelManagementSystem/
```

Or:

```text
http://localhost:8080/HotelManagementSystem/MainController
```

Because `web.xml` is configured with:

- `MainController` as the `welcome-file`

## Sample Login Accounts

The following sample accounts are seeded in `Given.sql`:

| Role | Username | Password | Status |
| --- | --- | --- | --- |
| Admin | `AnNguyen` | `123` | Active |
| Receptionist | `VanVy` | `111` | Active |
| Manager | `AnhTran` | `222` | Active |
| Housekeeping | `BaoLe` | `333` | Active |
| ServiceStaff | `PhamYen` | `444` | Active |

Note:

- Employees can log in only when `Status = Active`
- A `Guest` account is not clearly pre-seeded in the current script, so you can register one yourself through the `Signup` interface

## Project Highlights

- Supports multiple real-world hotel roles in a single system
- Covers the full hotel workflow: booking -> check-in -> service usage -> checkout -> payment -> invoice
- Includes reports and statistics for management, service operations, and housekeeping
- Uses database triggers to automate part of the workflow
- Has a clear and easy-to-learn code structure, suitable for a Java Web course project
- Separates controllers, DAO, DTO, and JSP layers relatively clearly

## Limitations and Notes

This is an academic project, so there are still a few things to keep in mind:

- It does not use Maven or Gradle, so dependency management still depends on NetBeans
- There is no automated test suite in the repository
- Database connection information is hard-coded in the source code
- The project is more suitable for local/dev usage than for production
- Some reports only become meaningful when real booking and payment data exists

If you want to continue improving the project, consider:

- moving database configuration into a `.properties` file
- using proper password hashing
- adding authorization with filters/interceptors
- migrating to Maven or Gradle
- writing unit tests and integration tests
- improving the UI/UX and standardizing shared CSS

## Repository Documents

- `Project Problem for FALL 2025/Given.sql`: database creation script and seed data
- `Project Problem for FALL 2025/PRJ_Student1.docx`: document related to the assignment/project
- `Project Problem for FALL 2025/project problem for all 2025 block 10w.docx`: assignment brief / course document

---

## Conclusion

`Hotel Management System` is a fairly complete Java Web project for an academic-level hotel management problem. It includes room management, booking management, services, housekeeping, management reports, invoices, payments, and employee administration.

If you are using this repository for learning, classroom demo purposes, or as a foundation for further development, it provides a solid base for extending features such as:

- stricter authorization
- better reporting
- REST APIs
- a more modern dashboard
- real payment integration

This README was written based on the actual structure and source code currently available in the repository, not only on the project name.
