package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/ischdProcDel")
public class IschdProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public IschdProcDelCtrl() { super(); }
	
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8"); 
        String giid = request.getParameter("giid");
        //System.out.println(giid);
        
        HttpSession session = request.getSession();
        MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo"); 
        if (loginInfo == null) { // 로그인 되어 있지 않으면
            response.setContentType("text/html; charset=utf-8"); 
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인 후 사용하실 수 있습니다.');");
            out.println("location.replace('/traverSite/lmth/member/login_form.jsp');");
            out.println("</script>");
            out.close();
        } 
        String miid = loginInfo.getMi_id(); 
       
        // 관심일정 목록에서 특정 관심일정 삭제하기 위한 where절
        // delete from t_schedule_zzim where mi_id = 'test11' and gi_id = 'GI1003';
        String where = " where mi_id = '" + miid + "' and gi_id = '" + giid + "' ";
        
        IschdProcDelSvc ischdProcDelSvc = new IschdProcDelSvc();
        int result = ischdProcDelSvc.ischdDelete(where);        
        
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
