package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/ischdDetail")
public class IschdDetailCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public IschdDetailCtrl() { super(); }

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        
        String giid = request.getParameter("giid");
        // 관심일정 상세 화면에서 보여줄 일정의 아이디로 where절에서 사용
       // System.out.println(giid); //콘솔확인용
        
                
        
        IschdDetailSvc ischdDetailSvc = new IschdDetailSvc();
        GoodInfo gi = ischdDetailSvc.getIschdDetail(miid, giid); 
        // 지정한 일정아이디에 해당하는 관심일정 정보들을 GoodInfo형 인스턴스 gi에 받아옴
        //System.out.println(gi.getGi_dnum()); 콘솔확인용
        
        GoodPost goodPost = ischdDetailSvc.getGoodPost(giid);
        //System.out.println(goodPost.getGp_id());
        
        request.setAttribute("goodPost", goodPost);
        request.setAttribute("gi", gi);
        
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("lmth/mysche/ischd_detail.jsp");
        dispatcher.forward(request, response);
		
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

}
