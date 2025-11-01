/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.HouseKeepingReportDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import mylib.DBUtills;

/**
 *
 * @author Nguyễn Đại
 */
public class HouseKeepingReportDAO {
    public ArrayList<HouseKeepingReportDTO> getReport1(){
        Connection cn = null;
        ArrayList<HouseKeepingReportDTO> result = new ArrayList<>();
        try{
            cn = DBUtills.getConnection();
            if(cn != null){
                String sql = "Select HT.TaskDate, R.RoomNumber, HT.CleaningType, S.FullName, HT.Status\n"
                        + "From HOUSEKEEPING_TASK as HT\n"
                        + "join ROOM as R on R.RoomID = HT.RoomID\n"
                        + "join STAFF as S on HT.AssignedStaff = S.StaffID";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if(table != null){
                    while(table.next()){
                        Date date = table.getDate("TaskDate");
                        int roomNumber = table.getInt("RoomNumber");
                        String cleaningType = table.getString("CleaningType");
                        String staffName = table.getString("FullName");
                        String status = table.getString("Status");
                        HouseKeepingReportDTO report = new HouseKeepingReportDTO(date, roomNumber, cleaningType, staffName, status);
                        result.add(report);
                    }
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    
    public ArrayList<HouseKeepingReportDTO> getReport3(){
        Connection cn = null;
        ArrayList<HouseKeepingReportDTO> result = new ArrayList<>();
        try{
            cn = DBUtills.getConnection();
            if(cn != null){
                String sql = "Select R.RoomNumber, RT.TypeName, R.Status, HT.TaskDate, B.CheckInDate\n"
                        + "From HOUSEKEEPING_TASK as HT\n"
                        + "join Room as R on R.RoomID = HT.RoomID\n"
                        + "join BOOKING as B on B.RoomID = HT.RoomID\n"
                        + "join ROOM_TYPE as RT on RT.RoomTypeID = R.RoomTypeID";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if(table != null){
                    while(table.next()){
                        int roomNumber = table.getInt("RoomNumber");
                        String typeName = table.getString("TypeName");
                        String status = table.getString("Status");
                        Date taskDate = table.getDate("TaskDate");
                        Date checkIn = table.getDate("CheckInDate");
                        HouseKeepingReportDTO report = new HouseKeepingReportDTO(roomNumber, typeName, status, taskDate,checkIn);
                        result.add(report);
                    }
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    
    public ArrayList<HouseKeepingReportDTO> getReport5(){
        Connection cn = null;
        ArrayList<HouseKeepingReportDTO> result = new ArrayList<>();
        try{
            cn = DBUtills.getConnection();
            if(cn != null){
                String sql = "SELECT \n"
                        + "    S.FullName AS StaffName,\n"
                        + "    SUM(CASE WHEN HT.Status = N'Completed' THEN 1 ELSE 0 END) AS RoomsCleaned,\n"
                        + "    SUM(CASE WHEN HT.Status = N'Completed' \n"
                        + "              AND HT.CleaningType IN (N'Deep', N'DeepCleaning', N'DeepCleanings')\n"
                        + "             THEN 1 ELSE 0 END) AS DeepCleanings,\n"
                        + "    HT.TaskDate AS [Date]\n"
                        + "FROM dbo.HOUSEKEEPING_TASK AS HT\n"
                        + "JOIN dbo.STAFF AS S \n"
                        + "  ON S.StaffID = HT.AssignedStaff\n"
                        + "GROUP BY S.FullName, HT.TaskDate\n"
                        + "ORDER BY [Date], S.FullName;";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if(table != null){
                    while(table.next()){
                        String staffName = table.getString("StaffName");
                        int roomsCleaned = table.getInt("RoomsCleaned");
                        int deepCleanings = table.getInt("DeepCleanings");
                        Date date = table.getDate("Date");
                        HouseKeepingReportDTO report = new HouseKeepingReportDTO(date, staffName, roomsCleaned, deepCleanings);
                        result.add(report);
                    }
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
