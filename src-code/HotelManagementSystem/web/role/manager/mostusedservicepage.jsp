<%--
    Document : mostusedservicepage
    Created on : Nov 1, 2025, 2:13:28 PM
    Author : Admin
--%>
<%@page import="mylib.IConstants"%>
<%@page import="DTO.Manager_DTO.MostUsedServiceDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dịch Vụ Được Sử Dụng Nhiều Nhất</title>

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

            h2 {
                color: #004a99;
                font-size: 1.8em;
                text-align: center;
                margin: 40px 0 25px;
                padding-bottom: 12px;
                border-bottom: 3px solid #004a99;
                display: inline-block;
                min-width: 320px;
                position: relative;
                left: 50%;
                transform: translateX(-50%);
                font-weight: bold;
            }

            /* ===== NỘI DUNG CHÍNH ===== */
            .service-container {
                max-width: 1000px;
                margin: 20px auto;
                background-color: #ffffff;
                padding: 35px;
                border-radius: 14px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            }

            .section {
                margin-bottom: 50px;
            }

            .section h3 {
                color: #004a99;
                font-size: 1.4em;
                margin: 0 0 20px 0;
                font-weight: bold;
                text-align: center;
            }

            /* ===== BẢNG DỮ LIỆU ===== */
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                font-size: 1em;
                background-color: #ffffff;
            }

            table th {
                background-color: #004a99;
                color: white;
                padding: 14px 12px;
                text-align: center;
                font-weight: bold;
                font-size: 1.05em;
                border: none;
            }

            table td {
                padding: 14px 12px;
                text-align: center;
                border-bottom: 1px solid #e0e0e0;
                transition: background-color 0.2s ease;
            }

            table tr:hover td {
                background-color: #f1f9ff;
            }

            table tr:nth-child(even) {
                background-color: #f8fdff;
            }

            /* Hạng 1, 2, 3 nổi bật */
            .rank-1 {
                background-color: #fff3cd !important;
                font-weight: bold;
            }
            .rank-2 {
                background-color: #d4edda !important;
            }
            .rank-3 {
                background-color: #d1ecf1 !important;
            }

            /* Doanh thu */
            .income {
                font-weight: bold;
                color: #004a99;
                font-family: 'Courier New', monospace;
                font-size: 1.1em;
            }

            .count {
                font-weight: bold;
                color: #0066cc;
            }

            /* ===== HIGHLIGHT DỊCH VỤ CAO/THẤP NHẤT ===== */
            .highlight-box {
                background: linear-gradient(135deg, #e6f5ff, #d4edff);
                border-left: 6px solid #004a99;
                padding: 18px 22px;
                margin: 25px 0;
                border-radius: 10px;
                font-size: 1.2em;
                text-align: center;
                box-shadow: 0 3px 10px rgba(0, 74, 153, 0.15);
            }

            .highlight-box.highest {
                background: linear-gradient(135deg, #d4edda, #c3e6cb);
                border-left-color: #28a745;
            }

            .highlight-box.lowest {
                background: linear-gradient(135deg, #f8d7da, #f5c6cb);
                border-left-color: #dc3545;
            }

            .highlight-box strong {
                color: #004a99;
                font-size: 1.1em;
            }

            /* ===== LỖI ===== */
            .error-msg {
                color: #721c24;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                padding: 16px;
                border-radius: 8px;
                text-align: center;
                margin: 20px 0;
                font-weight: bold;
                font-size: 1.1em;
            }

            /* ===== NÚT QUAY LẠI ===== */
            .back-link {
                display: block;
                text-align: center;
                margin: 40px 0 20px;
            }

            .back-link a {
                display: inline-block;
                background-color: #004a99;
                color: white;
                text-decoration: none;
                padding: 14px 28px;
                border-radius: 8px;
                font-weight: bold;
                font-size: 1.1em;
                transition: all 0.3s ease;
                box-shadow: 0 3px 8px rgba(0, 74, 153, 0.2);
            }

            .back-link a:hover {
                background-color: #003366;
                transform: translateY(-2px);
                box-shadow: 0 5px 12px rgba(0, 74, 153, 0.3);
            }

            hr {
                border: none;
                border-top: 2px solid #004a99;
                margin: 50px 0;
                opacity: 0.7;
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 768px) {
                .service-container {
                    margin: 15px;
                    padding: 25px;
                }

                table {
                    font-size: 0.9em;
                }

                table th, table td {
                    padding: 10px 6px;
                }

                h2 {
                    font-size: 1.5em;
                }

                .highlight-box {
                    font-size: 1.1em;
                    padding: 16px;
                }

                .back-link a {
                    padding: 12px 20px;
                    font-size: 1em;
                }
            }

            @media (max-width: 576px) {
                table {
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
                }

                table th, table td {
                    min-width: 100px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="<%= IConstants.HEADER_PAGE%>" />

        <%
            ArrayList<MostUsedServiceDTO> mostList = (ArrayList) request.getAttribute("MOST_SERVICE");
            MostUsedServiceDTO highestService = (MostUsedServiceDTO) request.getAttribute("HIGHEST_INCOME_SERVICE");
            MostUsedServiceDTO lowestService = (MostUsedServiceDTO) request.getAttribute("LOWEST_INCOME_SERVICE");
            ArrayList<MostUsedServiceDTO> highestList = (ArrayList) request.getAttribute("HIGHEST_LIST");
            String errMsg = (String) request.getAttribute("ERROR");
            if (errMsg == null)
                errMsg = "";
        %>

        <div class="service-container">

            <!-- TOP DỊCH VỤ ĐƯỢC DÙNG NHIỀU NHẤT -->
            <div class="section">
                <h2>Top các dịch vụ được sử dụng Nhiều Nhất</h2>

                <% if (mostList != null && !mostList.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Hạng</th>
                            <th>Service ID</th>
                            <th>Loại Dịch Vụ</th>
                            <th>Tên Dịch Vụ</th>
                            <th>Số Lượng Sử Dụng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int rank = 1;
                            for (MostUsedServiceDTO s : mostList) {
                                String rowClass = "";
                                if (rank == 1)
                                    rowClass = "rank-1";
                                else if (rank == 2)
                                    rowClass = "rank-2";
                                else if (rank == 3)
                                    rowClass = "rank-3";
                        %>
                        <tr class="<%= rowClass%>">
                            <td><%= rank++%></td>
                            <td><%= s.getServiceId()%></td>
                            <td><%= s.getServiceType()%></td>
                            <td><%= s.getServiceName()%></td>
                            <td class="count"><%= s.getCountNumService()%></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else {%>
                <p class="error-msg"><%= errMsg.isEmpty() ? "Không có dữ liệu dịch vụ được sử dụng." : errMsg%></p>
                <% } %>
            </div>

            <!-- DỊCH VỤ CAO NHẤT & THẤP NHẤT -->
            <% if (highestService != null) {%>
            <div class="highlight-box highest">
                <strong>Dịch vụ có doanh thu Cao Nhất:</strong><br>
                <%= highestService.getServiceName()%> — 
                <span class="income"><%= String.format("%,.0f", highestService.getIncomeService()).replace(',', '.')%> VND</span>
            </div>
            <% } else if (!errMsg.isEmpty()) {%>
            <p class="error-msg"><%= errMsg%></p>
            <% } %>

            <% if (lowestService != null) {%>
            <div class="highlight-box lowest">
                <strong>Dịch vụ có doanh thu Thấp Nhất:</strong><br>
                <%= lowestService.getServiceName()%> — 
                <span class="income"><%= String.format("%,.0f", lowestService.getIncomeService()).replace(',', '.')%> VND</span>
            </div>
            <% } else if (!errMsg.isEmpty()) {%>
            <p class="error-msg"><%= errMsg%></p>
            <% } %>

            <hr/>

            <!-- TOP DỊCH VỤ DOANH THU CAO NHẤT -->
            <div class="section">
                <h2>Top các dịch vụ có doanh thu Cao Nhất</h2>

                <% if (highestList != null && !highestList.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Hạng</th>
                            <th>Service ID</th>
                            <th>Loại Dịch Vụ</th>
                            <th>Tên Dịch Vụ</th>
                            <th>Doanh Thu</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int rank = 1;
                            for (MostUsedServiceDTO s : highestList) {
                                String rowClass = "";
                                if (rank == 1)
                                    rowClass = "rank-1";
                                else if (rank == 2)
                                    rowClass = "rank-2";
                                else if (rank == 3)
                                    rowClass = "rank-3";
                        %>
                        <tr class="<%= rowClass%>">
                            <td><%= rank++%></td>
                            <td><%= s.getServiceId()%></td>
                            <td><%= s.getServiceType()%></td>
                            <td><%= s.getServiceName()%></td>
                            <td class="income"><%= String.format("%,.0f", s.getIncomeService()).replace(',', '.')%> VND</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else {%>
                <p class="error-msg"><%= errMsg.isEmpty() ? "Không có dữ liệu doanh thu dịch vụ." : errMsg%></p>
                <% }%>
            </div>

            <hr/>

            <!-- NÚT QUAY LẠI -->
            <div class="back-link">
                <a href="MainController?action=gobackmanager">Quay lại Dashboard</a>
            </div>
        </div>

        <jsp:include page="<%= IConstants.FOOTER_PAGE%>" />
    </body>
</html>