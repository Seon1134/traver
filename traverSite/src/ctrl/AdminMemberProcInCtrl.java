package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/adminMemberProcIn")
public class AdminMemberProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminMemberProcInCtrl() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    
	    String id = request.getParameter("fm_id");
	    String name = request.getParameter("fm_name");
	    String nickname = request.getParameter("fm_nickname");
	    String mail = request.getParameter("fm_email");
	    String pw = request.getParameter("fm_pw");
	    String birth = request.getParameter("fm_birth");
	    String mbti = request.getParameter("fm_mbti");
	    
	    AdminMemberProcInSvc adminMemberProcInSvc = new AdminMemberProcInSvc();
	    int result = adminMemberProcInSvc.memberInsert(id, name, nickname, mail, pw, birth, mbti);
	    
	    if (result > 0) {
            response.sendRedirect("/traverSite/adminMemberList");
        } else {
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script> alert('등록에 실패하였습니다.'); history.back(); </script>");
            out.close();
        }
	}
}
