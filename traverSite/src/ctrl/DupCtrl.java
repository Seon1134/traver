package ctrl;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;

@WebServlet("/dup") // 아이디, 닉네임 중복 검사 + 비밀번호 확인
public class DupCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DupCtrl() { super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if ( request.getParameter("uid") != null ) {
		    String uid = request.getParameter("uid").trim().toLowerCase();
		    try {
	            DupSvc dupSvc = new DupSvc();
	            int result = dupSvc.chkDup("i",uid);
	            out.println(result);
	        } catch(Exception e) {
	            e.printStackTrace();
	            out.println(1);
	        }
		}
		
		if ( request.getParameter("nickname") != null) {
		    String nickname = request.getParameter("nickname").trim().toLowerCase();
		    try {
	            DupSvc dupSvc = new DupSvc();
	            int result = dupSvc.chkDup("n",nickname);
	            out.println(result);
	        } catch(Exception e) {
	            e.printStackTrace();
	            out.println(1);
	        }
		}
		
		if ( request.getParameter("pw") != null) { // 비밀번호 확인
            String pw = request.getParameter("pw").trim();
            String id = request.getParameter("id");
            try {
                DupSvc dupSvc = new DupSvc();
                int result = dupSvc.chkPw(id, pw);
                out.println(result);
            } catch(Exception e) {
                e.printStackTrace();
                out.println(0);
            }
        }
		
	}
}
