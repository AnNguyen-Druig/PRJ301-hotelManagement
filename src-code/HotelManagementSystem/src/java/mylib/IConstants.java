/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package mylib;

/**
 *
 * @author Admin
 */
public interface IConstants {

    //View
    public final String DEFAULT_PAGE = "/common/homepage.jsp";
    public final String LOGIN_PAGE = "/common/login.jsp";
    public final String SIGNUP_PAGE = "/common/signup.jsp";
    public final String SIGNUP_SUCCESS_PAGE = "/common/signup_success.jsp";
    public final String BOOKING_ROOM_PAGE = "/common/bookingroompage.jsp";
    public final String ADMIN_PAGE = "/role/admin.jsp";
    public final String RECEPTIONIST_PAGE = "/role/receptionist.jsp";
    public final String MANAGER_PAGE = "/role/manager.jsp";
    public final String HOUSEKEEPING_PAGE = "/role/housekeeping.jsp";
    public final String SERVICE_PAGE = "/role/service.jsp";
    public final String GUEST_PAGE = "/role/guest.jsp";
    public final String BOOKING_INFORMATION_PAGE = "/common/bookinginformationpage.jsp";
    public final String MANAGE_ROOM_STATUS = "/role/housekeeping.jsp";
    public final String BOOKING_ROOM_REGISTER_PAGE = "/common/bookingroomregisterpage.jsp";
    public final String CHOOSE_SERVICE_PAGE = "/common/ChooseServicePage.jsp";
    
    //Action
    public final String AC_DEFAULT = "default";
    public final String AC_LOGINSTAFF = "Login Staff";
    public final String AC_LOGINGUEST = "Login Member";
    public final String AC_SIGNUP = "Signup";
    public final String AC_LOGOUT = "logout";
    public final String AC_BOOKING = "booking";
    public final String AC_BOOKING_ROOM = "bookingroom";
    public final String AC_UPDATE_STATUS = "update_status";
    public final String AC_GO_STATUS = "gotohousekeeping";
    public final String AC_UPDATE_ROOM_STATUS = "update_room_status";
    public final String AC_PERFORM_UPDATE = "perform_room_update";   
    public final String AC_SAVE_BOOKING_ROOM = "savebookingroom";
    public final String AC_FILTER_ROOM = "filterroom";
    public final String AC_GET_ROOM_SERVICE = "getroomservice";
    public final String AC_CHOOSE_SERVICE_PAGE = "ChooseService";

    //Controller
    public final String CTL_LOGIN = "LoginController";
    public final String CTL_SIGNUP = "SignUpController";
    public final String CTL_GETROOM = "GetRoomController";
    public final String CTL_FILTERROOM = "FilterRoomController";
    public final String CTL_BOOKING_ROOM= "BookingRoomController";
    public final String CTL_LOGOUT = "LogoutController";
    public final String CTL_MANAGE_ROOM_STATUS = "ManageRoomStatus";
    public final String CTL_SAVE_BOOKING_ROOM = "SaveBookingRoomController";
    public final String CTL_SERVICE_ROOM_CONTROLLER = "GetRoomService";


    // Messages
    public final String ERR_EMPTY_FIELD = "Tên đăng nhập và mật khẩu không được để trống!";
    public final String ERR_INVALID_LOGIN = "Tên đăng nhập hoặc mật khẩu không chính xác!";
    public final String ERR_INVALID_USERNAME = "Tên đăng nhập đã tồn tại. Hãy nhập tên khác!";

    public final String ERR_INVALID_PASSWORD = "Mật khẩu không khớp!";
    public final String ERR_EMPTY_ROOM = "Hết phòng rồi"; 

    public final String ERR_INVALID_PASSWORDNOTMATCH = "Mật khẩu không khớp!";
    public final String ERR_INVALID_PASSWORDFORM = "Mật khẩu phải có ít nhất 8 kí tự, 1 chữ cái viết hoa, 1 chữ cái viết thường và 1 số!";
    public final String ERR_INVALID_FULLNAME = "Họ và tên chỉ bao gồm chữ cái!";
    public final String ERR_INVALID_PHONE = "Số điện thoại phải bắt đầu bằng 0 và có 10 kí tự số!";
    public final String ERR_INVALID_EMAIL = "Email không hợp lệ!";
    public final String ERR_INVALID_IDNUMBER = "CCCD/CMND phải có 12 kí tự số!";
    public final String ERR_CHECKINDATE_ISBEFORE_TODAY = "Ngày checkin phải sau ngày hôm nay";
    public final String ERR_CHECKOUTDATE_ISBEFORE_CHECKINDATE = "Ngày checkout phải sau ngày checkin";
    public final String ERR_REQUIRE_SELECT_DATERANGE = "Bạn cần phải chọn ngày CheckIn và CheckOut";
}
