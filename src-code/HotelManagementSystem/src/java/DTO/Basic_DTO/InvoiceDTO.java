/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO.Basic_DTO;

import java.sql.Date;

/**
 *
 * @author ASUS
 */
public class InvoiceDTO {
    private int invoiceID;
    private int bookingID;
    private Date issueDate;
    private double totalAmount;
    private String status;

    public InvoiceDTO() {
    }

    public InvoiceDTO(int invoiceID, int bookingID, Date issueDate, double totalAmount, String status) {
        this.invoiceID = invoiceID;
        this.bookingID = bookingID;
        this.issueDate = issueDate;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
