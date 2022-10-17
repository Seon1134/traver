package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/adminMemberProcDel")
public class AdminMemberProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminMemberProcDelCtrl() {
        super();
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    
        String miid = request.getParameter("miid");
        String where = " where ";
        if (miid.indexOf(',') > 0) {
            String arr[] = miid.split(",");
            for (int i = 0; i < arr.length; i++) {
                if (i == 0) {
                    where += " mi_id = " + arr[i]; 
                } else {
                    where += " or mi_id = " + arr[i]; 
                }
            }
        } else {
            where = " where mi_id = '" + miid + "' ";
        }
        AdminMemberProcDelSvc adminMemberProcDelSvc = new AdminMemberProcDelSvc();
        int result = adminMemberProcDelSvc.adminMemberProcDel(where);
        
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(result);
	}
}
