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
    public final String ADMIN_PAGE = "/role/admin.jsp";
    public final String RECEPTIONIST_PAGE = "/role/receptionist.jsp";
    public final String MANAGER_PAGE = "/role/manager.jsp";
    public final String HOUSEKEEPING_PAGE = "/role/housekeeping.jsp";
    public final String SERVICE_PAGE = "/role/service.jsp";

    //Action
    public final String AC_DEFAULT = "default";
    public final String AC_LOGIN = "Login";
    public final String AC_LOGOUT = "logout";

    //Controller
    public final String CTL_LOGIN = "LoginController";

    // Messages
    public final String ERR_EMPTY_FIELD = "Username and Password must not be empty!";
    public final String ERR_INVALID_LOGIN = "Username or Password incorrect!";

}
