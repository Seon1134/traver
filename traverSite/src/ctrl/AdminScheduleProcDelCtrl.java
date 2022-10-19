package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/admimScheduleProcDel")
public class AdminScheduleProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminScheduleProcDelCtrl() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
        
        String siid = request.getParameter("siid");
        String where = " where ";
        if (siid.indexOf(',') > 0) {
            String arr[] = siid.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i == 0) {
                    where += " si_id = " + arr[i]; 
                } else {
                    where += " or si_id = " + arr[i]; 
                }
            }
        } else {
            where = " where si_id = '" + siid + "' ";
        }
        AdminScheduleProcDelSvc adminScheduleProcDelSvc = new AdminScheduleProcDelSvc();
        int result = adminScheduleProcDelSvc.adminScheduleProcDel(where);
        
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(result);
	}
}
