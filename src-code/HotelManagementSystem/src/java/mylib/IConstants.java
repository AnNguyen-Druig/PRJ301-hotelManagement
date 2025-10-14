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
<<<<<<< HEAD
    public final String BOOKING_INFORMATION_PAGE = "/common/bookinginformationpage.jsp";
    public final String MANAGE_ROOM_STATUS = "/common/manageroomstatus.jsp";
=======
    public final String BOOKING_ROOM_REGISTER_PAGE = "/common/bookingroomregisterpage.jsp";
    
>>>>>>> 85193788154a760a9aeeb7745e3a7b6335f93a1b

    //Action
    public final String AC_DEFAULT = "default";
    public final String AC_LOGINSTAFF = "Login Staff";
    public final String AC_LOGINGUEST = "Login Member";
    public final String AC_SIGNUP = "Signup";
    public final String AC_LOGOUT = "logout";
    public final String AC_BOOKING = "booking";
    public final String AC_BOOKING_ROOM = "bookingroom";
<<<<<<< HEAD
    public final String AC_UPDATE_STATUS = "update_status";
    public final String AC_GO_BACK_STATUS = "goback";
    public final String AC_UPDATE_ROOM_STATUS = "update_room_status";
    public final String AC_PERFORM_UPDATE = "perform_room_update";
    
=======
    public final String AC_SAVE_BOOKING_ROOM = "savebookingroom";

>>>>>>> 85193788154a760a9aeeb7745e3a7b6335f93a1b
    //Controller
    public final String CTL_LOGINSTAFF = "LoginController";
    public final String CTL_LOGINGUEST = "LoginGuestController";
    public final String CTL_SIGNUP = "SignUpController";
    public final String CTL_GETROOM = "GetRoomController";
    public final String CTL_FILTERROOM = "FilterRoomController";
    public final String CTL_BOOKING_ROOM= "BookingRoomController";
    public final String CTL_LOGOUT = "LogoutController";
<<<<<<< HEAD
    public final String CTL_MANAGE_ROOM_STATUS = "ManageRoomStatus";
=======
    public final String CTL_SAVE_BOOKING_ROOM = "SaveBookingRoomController";
>>>>>>> 85193788154a760a9aeeb7745e3a7b6335f93a1b


    // Messages
    public final String ERR_EMPTY_FIELD = "Username and Password must not be empty!";
    public final String ERR_INVALID_LOGIN = "Username or Password incorrect!";
    public final String ERR_INVALID_USERNAME = "Username already existed! Enter another username!";
    public final String ERR_INVALID_PASSWORD = "Password not match!";
    public final String ERR_EMPTY_ROOM = "Het phong";

}
