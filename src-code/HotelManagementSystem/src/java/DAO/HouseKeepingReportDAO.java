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
}
