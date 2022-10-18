package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/mschdDetail")
public class MschdDetailCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MschdDetailCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    
	    HttpSession session = request.getSession();
        MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
        
        if (loginInfo == null) { // 로그인 되어 있지 않으면
            response.setContentType("text/html; charset=utf-8"); 
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인 후 사용하실 수 있습니다.');");
            out.println("location.replace('/traverSite/index.jsp');");
            out.println("</script>");
            out.close();
        } 
        String miid = loginInfo.getMi_id(); 
        
        String siid = request.getParameter("siid");
        // 일정 상세 화면에서 보여줄 일정의 아이디로 where절에서 사용
        
        MschdDetailSvc mschdDetailSvc = new MschdDetailSvc();
        ScheduleInfo si = mschdDetailSvc.getMschdDetail(miid, siid); 
         // 지정한 일정아이디에 해당하는 일정정보들을 ScheduleInfo형 인스턴스 si에 받아옴
        
        
        //System.out.println(si.getSi_dnum()); 콘솔확인용
        
        
        request.setAttribute("si", si);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("lmth/mysche/mschd_detail.jsp");
        dispatcher.forward(request, response);
        
	}

}
