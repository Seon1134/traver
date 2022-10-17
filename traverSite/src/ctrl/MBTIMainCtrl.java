package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;



@WebServlet("/MBTIMain") // Best여행 클릭 시 MBTI값 여부에 따라 다른 컨트롤러로 이동
public class MBTIMainCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MBTIMainCtrl() { super(); }
    
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    if(session.getAttribute("loginInfo")!=null) {  // 로그인 되어 있으면
	        MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
    	    String mimbti = loginInfo.getMi_mbti();
    	    if ( !mimbti.equals("")) { // mbti값이 있으면
    	        request.setAttribute("mbti", mimbti);
    	        
    	        RequestDispatcher dispatcher = 
                        request.getRequestDispatcher("/postMain"); // Best여행으로 이동
                    dispatcher.forward(request, response);
    	    } else { //mbti값이 없으면
    	        RequestDispatcher dispatcher = 
                        request.getRequestDispatcher("lmth/mbti/mbti_start_main.jsp"); // mbti 첫 방문 페이지로 이동
                dispatcher.forward(request, response); 
    	    }
	    } else { // 로그인 되어 있지 않으면
	        RequestDispatcher dispatcher = 
                    request.getRequestDispatcher("/postMain"); // Best여행으로 이동
                dispatcher.forward(request, response);
	    }
                
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

}
