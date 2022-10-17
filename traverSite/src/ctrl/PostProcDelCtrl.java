package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/postProcDel")
public class PostProcDelCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PostProcDelCtrl() { super(); }

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		System.out.println("delctrl");
		String gpid = request.getParameter("gp_id");
		String kind = request.getParameter("kind");
		HttpSession session = request.getSession();
        MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");

		PostProcDelSvc postProcDelSvc = new PostProcDelSvc();
		int result = postProcDelSvc.postDelete(gpid);

		if (result == 1) {
		    if (kind.equals("list")) {
		        response.sendRedirect("/traverSite/postList");
		    }
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('글 삭제에 실패했습니다.\\n다시 시도해 보세요.');");
			out.println("</script>");
			out.close();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
