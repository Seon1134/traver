package ctrl;

import java.io.*;
import java.net.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/adminMemberFormUp")
public class AdminMemberFormUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminMemberFormUpCtrl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
        String miid = request.getParameter("miid");
        
        AdminMemberFormUpSvc adminMemberFormUpSvc = new AdminMemberFormUpSvc();
        MemberInfo memberInfo = adminMemberFormUpSvc.getAdminMemberFormUp(miid);
        request.setAttribute("memberInfo", memberInfo);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("lmth/admin/01_member/mem_form_up.jsp");
        dispatcher.forward(request, response);
	}
}
