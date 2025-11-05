/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO.Basic_DAO;

import DTO.Basic_DTO.BookingDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import mylib.DBUtills;

/**
 *
 * @author Admin
 */
public class BookingDAO {

    public int saveBookingRoom(BookingDTO booking) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "INSERT INTO dbo.BOOKING (GuestID, RoomID, CheckInDate, CheckOutDate, BookingDate, Status)\n"
                        + "VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, booking.getGuestID());
                st.setInt(2, booking.getRoomID());
                st.setDate(3, booking.getCheckInDate());
                st.setDate(4, booking.getCheckOutDate());
                st.setDate(5, booking.getBookingDate());
                st.setString(6, booking.getStatus());
                result = st.executeUpdate();
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

    public ArrayList<BookingDTO> getAllBookingRoom() {
        Connection cn = null;
        ArrayList<BookingDTO> result = new ArrayList<>();
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "Select B.BookingID, B.RoomID, G.FullName, B.CheckInDate, B.Status\n"
                        + "from dbo.BOOKING as B\n"
                        + "JOIN dbo.GUEST AS G ON B.GuestID = G.GuestID "
                        //                        + "LEFT JOIN dbo.BOOKING_SERVICE AS BS ON BS.BookingID = B.BookingID "
                        + "Where B.Status = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "CheckIn");
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingID = table.getInt("BookingID");
                        int RoomID = table.getInt("RoomID");
                        String GuestName = table.getString("FullName");
                        Date CheckInDate = table.getDate("CheckInDate");
                        String Status = table.getString("Status");
                        BookingDTO booking = new BookingDTO(bookingID, RoomID, CheckInDate, Status, GuestName);
                        result.add(booking);
                    }
                }
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

    public ArrayList<BookingDTO> getAllBookingRoomGuest() {
        Connection cn = null;
        ArrayList<BookingDTO> result = new ArrayList<>();
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT b.BookingID, g.GuestID, g.FullName, r.RoomID, r.RoomNumber, rt.TypeName, b.CheckInDate, b.CheckOutDate, b.BookingDate, b.Status FROM BOOKING b JOIN GUEST g ON b.GuestID = g.GuestID \n"
                        + "JOIN ROOM r ON b.RoomID = r.RoomID JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingID = table.getInt("BookingID");
                        int guestID = table.getInt("GuestID");
                        String guestName = table.getString("FullName");
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        String roomType = table.getString("TypeName");
                        Date checkInDate = table.getDate("CheckInDate");
                        Date checkOutDate = table.getDate("CheckOutDate");
                        Date bookingDate = table.getDate("BookingDate");
                        String Status = table.getString("Status");
                        BookingDTO booking = new BookingDTO(bookingID, guestID, roomID, checkInDate, checkOutDate, bookingDate, Status, guestName, roomNumber, roomType);
                        result.add(booking);
                    }
                }
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

    public ArrayList<BookingDTO> getBookingListByStatus(String status) {
        Connection cn = null;
        ArrayList<BookingDTO> list = new ArrayList<>();
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT b.BookingID, g.GuestID, g.FullName, r.RoomID, r.RoomNumber, rt.TypeName, b.CheckInDate, b.CheckOutDate, b.BookingDate, b.Status FROM BOOKING b JOIN GUEST g ON b.GuestID = g.GuestID \n"
                        + "JOIN ROOM r ON b.RoomID = r.RoomID JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID WHERE b.Status = ?";
                PreparedStatement ps = cn.prepareStatement(sql);
                ps.setString(1, status);
                ResultSet table = ps.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingID = table.getInt("BookingID");
                        int guestID = table.getInt("GuestID");
                        String guestName = table.getString("FullName");
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        String roomType = table.getString("TypeName");
                        Date checkInDate = table.getDate("CheckInDate");
                        Date checkOutDate = table.getDate("CheckOutDate");
                        Date bookingDate = table.getDate("BookingDate");
                        BookingDTO booking = new BookingDTO(bookingID, guestID, roomID, checkInDate, checkOutDate, bookingDate, status, guestName, roomNumber, roomType);
                        list.add(booking);
                    }
                }
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
        return list;
    }

    public BookingDTO getBookingRoom(int BookingID) {
        Connection cn = null;
        BookingDTO result = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "select B.BookingID, B.RoomID\n"
                        + "From dbo.BOOKING as B\n"
                        + "Where B.BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, BookingID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingID = table.getInt("BookingID");
                        int RoomID = table.getInt("RoomID");
                        result = new BookingDTO(bookingID, RoomID);

                    }
                }
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

    public BookingDTO getBookingByBookingIDInReception(int bookingID) {
        Connection cn = null;
        BookingDTO result = null;
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT b.BookingID, g.GuestID, g.FullName, r.RoomID, r.RoomNumber, rt.RoomTypeID, rt.TypeName, b.CheckInDate, "
                        + "b.CheckOutDate, b.BookingDate, b.Status FROM BOOKING b JOIN GUEST g ON b.GuestID = g.GuestID \n"
                        + "JOIN ROOM r ON b.RoomID = r.RoomID JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "WHERE b.BookingID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, bookingID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int guestID = table.getInt("GuestID");
                        String guestName = table.getString("FullName");
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        int roomTypeID = table.getInt("RoomTypeID");
                        String roomType = table.getString("TypeName");
                        Date checkInDate = table.getDate("CheckInDate");
                        Date checkOutDate = table.getDate("CheckOutDate");
                        Date bookingDate = table.getDate("BookingDate");
                        String status = table.getString("Status");
                        result = new BookingDTO(bookingID, guestID, roomID, checkInDate, checkOutDate, bookingDate, status, guestName, roomNumber, roomType, roomTypeID);
                    }
                }
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

    public ArrayList<BookingDTO> getAllBookingByGuestID(int guestID) {
        Connection cn = null;
        ArrayList<BookingDTO> result = new ArrayList<>();
        try {
            cn = DBUtills.getConnection();
            if (cn != null) {
                String sql = "SELECT b.BookingID, g.GuestID, g.FullName, r.RoomID, r.RoomNumber, rt.TypeName, b.CheckInDate,\n"
                        + "       b.CheckOutDate, b.BookingDate, b.Status FROM BOOKING b \n"
                        + "INNER JOIN GUEST g ON b.GuestID = g.GuestID\n"
                        + "INNER JOIN ROOM r ON b.RoomID = r.RoomID \n"
                        + "INNER JOIN ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                        + "WHERE g.GuestID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, guestID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int bookingID = table.getInt("BookingID");
                        String guestName = table.getString("FullName");
                        int roomID = table.getInt("RoomID");
                        String roomNumber = table.getString("RoomNumber");
                        String roomType = table.getString("TypeName");
                        Date checkInDate = table.getDate("CheckInDate");
                        Date checkOutDate = table.getDate("CheckOutDate");
                        Date bookingDate = table.getDate("BookingDate");
                        String status = table.getString("Status");
                        BookingDTO bookingDTO = new BookingDTO(bookingID, guestID, roomID, checkInDate, checkOutDate, bookingDate, status, guestName, roomNumber, roomType);
                        result.add(bookingDTO);

                    }
                }
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

    public int saveUpdateBooking(BookingDTO booking) {
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "UPDATE BOOKING SET RoomID = ?, CheckInDate = ?, CheckOutDate = ? WHERE BookingID = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setInt(1, booking.getRoomID());
            ps.setDate(2, booking.getCheckInDate());
            ps.setDate(3, booking.getCheckOutDate());
            ps.setInt(4, booking.getBookingID());
            result = ps.executeUpdate();
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

    public boolean updateStatusBooking(int bookingID, String newStauts) {
        boolean result = false;
        Connection cn = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "UPDATE BOOKING SET Status = ? WHERE BookingID = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, newStauts);
            ps.setInt(2, bookingID);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
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

    public int countTotalBooking() {
        int result = 0;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT COUNT(BookingID) as [Tổng số booking đã tạo] FROM BOOKING";
            ps = cn.prepareStatement(sql);
            table = ps.executeQuery();
            if (table != null && table.next()) {
                int totalBooking = table.getInt("Tổng số booking đã tạo");
                result = totalBooking;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public int countTotalCancelBooking() {
        int result = 0;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT COUNT(BookingID) AS [Tổng số lượt hủy] FROM BOOKING WHERE Status = 'Canceled'";
            ps = cn.prepareStatement(sql);
            table = ps.executeQuery();
            if (table != null && table.next()) {
                int totalBooking = table.getInt("Tổng số lượt hủy");
                result = totalBooking;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public double rateCancelBooking() {
        double result = 0;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT CASE WHEN COUNT(BookingID) = 0 THEN 0.0 \n"
                    + "ELSE (CAST(SUM(CASE WHEN Status = 'Canceled' THEN 1 ELSE 0 END) AS DECIMAL(10, 2)) * 100.0 / COUNT(BookingID)) \n"
                    + " END AS [Tỷ lệ hủy phòng]\n"
                    + "FROM BOOKING";
            ps = cn.prepareStatement(sql);
            table = ps.executeQuery();
            if (table != null && table.next()) {
                double rateCancelBooking = table.getDouble("Tỷ lệ hủy phòng");
                result = rateCancelBooking;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public int countTotalCancelBookingInRange(Date startDate, Date endDate) {
        int result = 0;
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT COUNT(BookingID) AS [Tổng số lượt hủy] FROM BOOKING WHERE Status = 'Canceled' AND CheckInDate BETWEEN ? AND ?";
            ps = cn.prepareStatement(sql);
            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            table = ps.executeQuery();
            if (table != null && table.next()) {
                int totalBooking = table.getInt("Tổng số lượt hủy");
                result = totalBooking;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public Map<String, Integer> countTotalCancelBookingInMonthYear() {
        Map<String, Integer> list = new HashMap<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT \n"
                    + "    FORMAT(BookingDate, 'yyyy-MM') AS [Tháng/Năm], \n"
                    + "    COUNT(BookingID) AS [Tổng số lượt hủy]\n"
                    + "FROM BOOKING\n"
                    + "WHERE Status = 'Canceled'\n"
                    + "GROUP BY FORMAT(BookingDate, 'yyyy-MM')\n"
                    + "ORDER BY [Tháng/Năm] DESC";
            ps = cn.prepareStatement(sql);
            table = ps.executeQuery();
            if (table != null) {
                while (table.next()) {
                    String monthYear = table.getString("Tháng/Năm");
                    int totalBooking = table.getInt("Tổng số lượt hủy");
                    list.put(monthYear, totalBooking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public Map<String, Integer> countTotalCancelBookingByRoomType() {
        Map<String, Integer> list = new HashMap<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet table = null;
        try {
            cn = DBUtills.getConnection();
            String sql = "SELECT\n"
                    + "    rt.TypeName,\n"
                    + "    COUNT(b.BookingID) AS [Tổng số lượt hủy]\n"
                    + "FROM\n"
                    + "    BOOKING b\n"
                    + "JOIN\n"
                    + "    ROOM r ON b.RoomID = r.RoomID\n"
                    + "JOIN\n"
                    + "    ROOM_TYPE rt ON r.RoomTypeID = rt.RoomTypeID\n"
                    + "WHERE\n"
                    + "    b.Status = 'Canceled'\n"
                    + "GROUP BY\n"
                    + "    rt.TypeName\n"
                    + "ORDER BY\n"
                    + "    [Tổng số lượt hủy] DESC";
            ps = cn.prepareStatement(sql);
            table = ps.executeQuery();
            if (table != null) {
                while (table.next()) {
                    String roomType = table.getString("TypeName");
                    int totalBooking = table.getInt("Tổng số lượt hủy");
                    list.put(roomType, totalBooking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (table != null) {
                    table.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
}
