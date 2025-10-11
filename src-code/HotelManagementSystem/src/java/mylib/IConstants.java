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
    public final String BOOKING_PAGE = "/common/booking.jsp";
    public final String SIGNUP_PAGE = "/common/signup.jsp";
    public final String SIGNUP_SUCCESS_PAGE = "/common/signup_success.jsp";
    public final String ADMIN_PAGE = "/role/admin.jsp";
    public final String RECEPTIONIST_PAGE = "/role/receptionist.jsp";
    public final String MANAGER_PAGE = "/role/manager.jsp";
    public final String HOUSEKEEPING_PAGE = "/role/housekeeping.jsp";
    public final String SERVICE_PAGE = "/role/service.jsp";
    public final String GUEST_PAGE = "/role/guest.jsp";

    //Action
    public final String AC_DEFAULT = "default";
    public final String AC_LOGINSTAFF = "Login Staff";
    public final String AC_LOGINGUEST = "Login Member";
    public final String AC_SIGNUP = "signup";
    public final String AC_SIGNUP_PAGE = "signupPage";
    public final String AC_LOGOUT = "logout";
    public final String AC_BOOKING = "booking";

    //Controller
    public final String CTL_LOGINSTAFF = "LoginController";
    public final String CTL_LOGINGUEST = "LoginGuestController";
    public final String CTL_SIGNUP = "SignUpController";
    public final String CTL_BOOKING = "BookingController";

    // Messages
    public final String ERR_EMPTY_FIELD = "Username and Password must not be empty!";
    public final String ERR_INVALID_LOGIN = "Username or Password incorrect!";
    public final String ERR_INVALID_USERNAME = "Username already existed! Enter another username!";
    public final String ERR_INVALID_PASSWORD = "Password not match!";

}
