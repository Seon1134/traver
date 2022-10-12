package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/adminPlaceProcDel")
public class AdminPlaceProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminPlaceProcDelCtrl() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    String piid = request.getParameter("piid");
	    String where = " where ";
	    if (piid.indexOf(',') > 0) {
	        String arr[] = piid.split(",");
	        for (int i = 0; i < arr.length; i++) {
	            if (i == 0) {
	                where += " pi_id = " + arr[i]; 
	            } else {
	                where += " or pi_id = " + arr[i]; 
	            }
	        }
	    } else {
	        where = " where pi_id = '" + piid + "' ";
	    }
	    AdminPlaceProcDelSvc adminPlaceProcDelSvc = new AdminPlaceProcDelSvc();
	    int result = adminPlaceProcDelSvc.adminPlaceProcDel(where);
	    
	    response.setContentType("text/html; charset=utf-8");
	    PrintWriter out = response.getWriter();
	    out.println(result);
	}
}
