package ctrl;

import java.io.*;
import java.net.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/adminPlaceFormUp")
public class AdminPlaceFormUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminPlaceFormUpCtrl() {
        super();
    }
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String piid = request.getParameter("piid");
        
        AdminPlaceFormUpSvc adminPlaceFormUpSvc = new AdminPlaceFormUpSvc();
        PlaceInfo placeInfo = adminPlaceFormUpSvc.getAdminPlaceInfo(piid);
        request.setAttribute("placeInfo", placeInfo);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("lmth/admin/02_place/place_form_up.jsp");
        dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
	}
}
