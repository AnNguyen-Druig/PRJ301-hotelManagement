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
public class TaxDTO {
    private int taxID;
    private String taxName;
    private double taxValue;
    private String description;
    private Date LastUpdated;
    //Thiếu thuộc tính TaxID, tại sao lại ko thêm

    public TaxDTO() {
    }

    public TaxDTO(int taxID, String taxName, double taxValue, String description, Date LastUpdated) {
        this.taxID = taxID;
        this.taxName = taxName;
        this.taxValue = taxValue;
        this.description = description;
        this.LastUpdated = LastUpdated;
    }

    public int getTaxID() {
        return taxID;
    }

    public void setTaxID(int taxID) {
        this.taxID = taxID;
    }

    public String getTaxName() {
        return taxName;
    }

    public void setTaxName(String taxName) {
        this.taxName = taxName;
    }

    public double getTaxValue() {
        return taxValue;
    }

    public void setTaxValue(double taxValue) {
        this.taxValue = taxValue;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getLastUpdated() {
        return LastUpdated;
    }

    public void setLastUpdated(Date LastUpdated) {
        this.LastUpdated = LastUpdated;
    }

    
   
    
    
}
