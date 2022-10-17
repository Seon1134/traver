package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/report")
public class ReportProcCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ReportProcCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
        Report report = new Report();
        report.setMi_id(loginInfo.getMi_id());
        report.setGp_id(request.getParameter("gp_id"));
        report.setRe_why(request.getParameter("report"));
        report.setRe_ip(request.getRemoteAddr());

        ReportProcSvc reportProcSvc = new ReportProcSvc();
        int result = reportProcSvc.reportInsert(report);

        if (result == 1) {
            response.sendRedirect("/traverSite/postList");
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
