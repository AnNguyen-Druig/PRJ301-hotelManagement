<%-- 
    Document   : HouseKeepingReportPage
    Created on : Oct 28, 2025, 9:33:38 AM
    Author     : Nguyễn Đại
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report Page</title>
        <style>
            body { 
                font-family: Arial, sans-serif; 
                margin: 20px; 
                background-color: #f5f5f5;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .header {
                text-align: center;
                margin-bottom: 30px;
                color: #333;
            }
            .button-container {
                display: flex;
                gap: 15px;
                justify-content: center;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }
            .report-btn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            .report-btn:hover {
                background-color: #0056b3;
            }
            .report-btn.active {
                background-color: #28a745;
            }
            .report-content {
                display: none;
                margin-top: 20px;
            }
            .report-content.active {
                display: block;
            }
            table { 
                border-collapse: collapse; 
                width: 100%; 
                margin-top: 20px;
            }
            th, td { 
                border: 1px solid #ddd; 
                padding: 12px; 
                text-align: left;
            }
            th { 
                background: #f8f9fa; 
                font-weight: bold;
                color: #495057;
            }
            tr:nth-child(even) {
                background-color: #f8f9fa;
            }
            .msg { 
                margin: 10px 0; 
                color: #dc3545; 
                padding: 10px;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                border-radius: 4px;
            }
                .no-data {
                text-align: center;
                color: #6c757d;
                font-style: italic;
                padding: 20px;
            }
            .report-side-by-side {
                display: flex;
                gap: 20px;
                margin-top: 20px;
            }
            .report-side-by-side .report-content {
                flex: 1;
                display: block !important;
            }
            .back-btn {
                background-color: #6c757d;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                margin-top: 20px;
            }
            .back-btn:hover {
                background-color: #5a6268;
            }
        </style>        
    </head>
    <body>
        <jsp:useBean id="STAFF" scope="session" class="DTO.StaffDTO" />
            <div class="header">
                <h1>Hello, ${STAFF.fullName} - Report Dashboard</h1>
                <p>Chọn báo cáo để xem chi tiết</p>
            </div>
            
            <div class="button-container">
                <button class="report-btn" onclick="loadReport1()">Report 1 - Daily Room Cleaning</button>
                <button class="report-btn" onclick="loadReport2()">Report 2 - Services requested</button>
                <button class="report-btn" onclick="loadReport3()">Report 3 - Completed Services</button>
                <button class="report-btn" onclick="loadAllReports()">Load All Reports</button>
            </div>
    </body>
</html>
