package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/mschdProcDel")
public class MschdProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MschdProcDelCtrl() { super(); }
	
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8"); 
        String siid = request.getParameter("siid");
        //System.out.println(siid);
        
        HttpSession session = request.getSession();
        MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo"); 
        String miid = loginInfo.getMi_id(); 
       

        // t_schedule_info 및 t_schedule_day 에서 삭제하기 위한 where절
        // delete from t_schedule_info where mi_id = 'test11' and si_id = 'SI1001'
        String where = " where mi_id = '" + miid + "' and si_id = '" + siid + "' ";
        
        MschdProcDelSvc mschdProcDelSvc = new MschdProcDelSvc();
        int result = mschdProcDelSvc.mschdDelete(where);        
        
        response.setContentType("text/html; charset=utf-8"); 
        PrintWriter out = response.getWriter();
        out.println(result);
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    doProcess(request, response);
	}

}
