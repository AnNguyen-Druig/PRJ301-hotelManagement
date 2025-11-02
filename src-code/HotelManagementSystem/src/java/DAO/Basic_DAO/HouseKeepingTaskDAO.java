/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.HouseKeepingTaskDTO;
import DTO.Basic_DTO.RoomDTO;
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
public class HouseKeepingTaskDAO {
    public ArrayList<HouseKeepingTaskDTO> getAllRoomPending() {
        ArrayList<HouseKeepingTaskDTO> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if(cn != null) {
                String sql = "Select *\n"
                            + "From housekeeping_task as h\n"
                            + "join STAFF as S on S.StaffID = h.AssignedStaff\n"
                            + "Where h.Status = 'Pending' OR h.Status = 'Occupied'";
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet table = ps.executeQuery();
                if(table != null) {
                    while(table.next()) {
                        int taskId = table.getInt("TaskID");
                        int roomId = table.getInt("RoomID");
                        String staffName = table.getString("FullName");
                        Date taskDate = table.getDate("TaskDate");
                        String status = table.getString("Status");
                        String cleanType = table.getString("CleaningType");
                        HouseKeepingTaskDTO housekeeping = new HouseKeepingTaskDTO(taskId, roomId, staffName, taskDate, cleanType, status);
                        list.add(housekeeping);
                    }
                }
            }
        } catch (Exception e) {
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
        return list;
    }
    
    public HouseKeepingTaskDTO getTaskID(int TaskID){
        Connection cn = null;
        HouseKeepingTaskDTO result = null;
        try{
            cn = DBUtills.getConnection();
            if(cn != null){
                String sql = "Select *\n"
                        + "From housekeeping_task as h\n"
                        + "join STAFF as S on S.StaffID = h.AssignedStaff\n"
                        + "Where TaskID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, TaskID);
                ResultSet table = st.executeQuery();
                if(table != null){
                    while(table.next()){
                        int taskId = table.getInt("TaskID");
                        int roomId = table.getInt("RoomID");
                        String staffName = table.getString("FullName");
                        Date taskDate = table.getDate("TaskDate");
                        String status = table.getString("Status");
                        String cleanType = table.getString("CleaningType");
                        result = new HouseKeepingTaskDTO(taskId, roomId, staffName, taskDate, cleanType, status);
                    }
                }
            }
        }catch (Exception e) {
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    
    public boolean updateTaskStatus(int taskId, int staffId, String newStatus, String newCleanType){
        boolean result = false;
        Connection cn = null;
        try{
            cn = DBUtills.getConnection();
            String sql = "UPDATE dbo.HOUSEKEEPING_TASK SET Status = ?, AssignedStaff = ?, CleaningType = ? WHERE TaskID = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, newStatus);
            st.setInt(2, staffId);
            st.setString(3, newCleanType);
            st.setInt(4, taskId);         
            int affect = st.executeUpdate();
            if(affect > 0){
                result = true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    
    public ArrayList<HouseKeepingTaskDTO> getAllRoomProgress() {
        ArrayList<HouseKeepingTaskDTO> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if(cn != null) {
                String sql = "Select *\n"
                        + "From housekeeping_task as h\n"
                        + "join STAFF as S on S.StaffID = h.AssignedStaff\n"
                        + "Where h.Status = 'InProgress'";
                PreparedStatement ps = cn.prepareStatement(sql);
                ResultSet table = ps.executeQuery();
                if(table != null) {
                    while(table.next()) {
                        int taskId = table.getInt("TaskID");
                        int roomId = table.getInt("RoomID");
                        String staffName = table.getString("FullName");
                        Date taskDate = table.getDate("TaskDate");
                        String status = table.getString("Status");
                        String cleanType = table.getString("CleaningType");
                        HouseKeepingTaskDTO housekeeping = new HouseKeepingTaskDTO(taskId, roomId, staffName, taskDate, cleanType, status);
                        list.add(housekeeping);
                    }
                }
            }
        } catch (Exception e) {
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
        return list;
    }
}