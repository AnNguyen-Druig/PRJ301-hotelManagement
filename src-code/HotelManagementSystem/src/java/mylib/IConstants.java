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
    public final String ADMIN_PAGE = "/role/admin/admin.jsp";
    public final String RECEPTIONIST_PAGE = "/role/receptionist/receptionist.jsp";
    public final String MANAGER_PAGE = "/role/manager/manager.jsp";
    public final String HOUSEKEEPING_PAGE = "/role/housekeeping/housekeeping.jsp";
    public final String SERVICE_PAGE = "/role/service/service.jsp";
    public final String GUEST_PAGE = "/role/guest/guest.jsp";
    public final String BOOKING_INFORMATION_PAGE = "/common/bookinginformationpage.jsp";
    public final String MANAGE_ROOM_STATUS = "/role/housekeeping/housekeeping.jsp";
    public final String BOOKING_ROOM_REGISTER_PAGE = "/common/bookingroomregisterpage.jsp";
    public final String CHOOSE_SERVICE_PAGE = "/common/ServicePage/ChooseServicePage.jsp";
    public final String BOOKING_ROOM_DETAIL_PAGE = "/role/receptionist/bookingroomdetail.jsp";
    public final String BOOKING_ROOM_VIEW_PAGE = "/common/bookingroomview.jsp";
    public final String CHECKOUT_PAGE = "/common/checkoutpage.jsp";
    public final String REPORT_MAIN_PAGE = "common/ReportJSP/reportmainpage.jsp";
    public final String REPORT_1_PAGE = "/common/ReportJSP/Report1Page.jsp";
    public final String REPORT_2_PAGE = "/common/ReportJSP/Report2Page.jsp";
    
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
    public final String AC_GO_BACK_SERVICE_PAGE = "gobackservice";
    public final String AC_MAKENEWBOOKING = "Make new Booking";
    public final String AC_UPDATE_BOOKING = "UpdateBooking";
    public final String AC_CANCEL_BOOKING = "CancelBooking";
    public final String AC_TURNBACK_RECEPTION = "TurnBackReceptionPage";
    public final String AC_VIEW_BOOKING = "viewbooking";
    public final String AC_CHECKOUT_BOOKING_ROOM = "checkoutbookingroom";
    public final String AC_SAVE_BOOKING_SERVICE = "savebookingservice";
    public final String AC_UPDATE_BOOKING_SERVICE = "updatebookingservice";
    public final String AC_DELETE_BOOKING_SERVICE = "deletebookingservice";
    public final String AC_ADD_SERVICE = "addservice";
    public final String AC_VIEW_REPORT_PAGE = "reportpage";
    public final String AC_SAVE_BOOKING_UPDATE = "Save Changes";
    public final String AC_SAVE_PAYMENT_AND_INVOICE = "savepaymentandinvoice";
    public final String AC_CHANGE_STATUS_CHECKIN = "Check In";
    public final String AC_CHANGE_STATUS_CANCEL = "Cancel Booking";
    public final String AC_CHANGE_STATUS_CHECKOUT = "Check Out";
    public final String AC_CHANGE_STATUS_COMPLETE = "Approve Checkout";
    public final String AC_REPORT_1_PAGE = "report1page";
    public final String AC_REPORT_2_PAGE = "report2page";

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
    public final String CTL_GET_SERVICE_CONTROLLER = "GetServiceController";
    public final String CTL_BOOKINGBY_GUESTIDNUMBER = "BookingGuestIDNumberController";
    public final String CTL_SHOW_BOOKING_IN_RECEPTION = "ShowBookingInReception";
    public final String CTL_UPDATE_BOOKING_IN_RECEPTION = "UpdateBookingInReceptionController";
    public final String CTL_VIEW_BOOKING = "ViewBookingController";
    public final String CTL_EDIT_SERVICE = "EditServiceController";
    public final String CTL_ADD_SERVICE = "AddServiceController";
    public final String CTL_SAVE_BOOKING_UPDATE = "SaveUpdateBookingController";
    public final String CTL_GET_BOOKING_ROOM = "GetBookingRoomController";
    public final String CTL_SAVE_PAYMENT_AND_INVOICE = "SavePaymentAndInvoiceController";
    public final String CTL_CHANGE_STATUS_BOOKING_CHECKIN = "ChangeStatusBookingCheckInController";
    public final String CTL_CHANGE_STATUS_BOOKING_CHECKOUT = "ChangeStatusBookingCheckOutController";
    public final String CTL_CHANGE_STATUS_BOOKING_CANCEL = "ChangeStatusBookingCancelController";
    public final String CTL_CHANGE_STATUS_BOOKING_COMPLETE = "ChangeStatusBookingCompleteController";

    // ERROR
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
    public final String ERR_REQUIRE_SELECT_DATERANGE = "Bạn cần phải chọn Loai Phong va ngày CheckIn, CheckOut";
    public final String ERR_INVALID_EMPTYACCOUNT = "Không tìm thấy tài khoản!";
    public final String ERR_EMPTY_GUEST_IDNUMBER = "Vui lòng nhập số CCCD.";
    public final String ERR_EMPTYBOOKING = "Không có dữ liệu Booking!";
    public final String ERR_SAVE_BOOKING_SERVICE = "Đặt dịch vụ KHÔNG THÀNH CÔNG";  
    public final String ERR_SAVE_UPDATE_BOOKING = "Cập nhật thông tin KHÔNG THÀNH CÔNG";
    
    //SUCESSFULL
    public final String SUCC_SAVE_BOOKING_SERVICE =  "Bạn đã đặt dịch vụ thành công.";
    public final String SUCC_SAVE_UPDATE_BOOKING = "Bạn đã cập nhật thông tin thành công.";
}
