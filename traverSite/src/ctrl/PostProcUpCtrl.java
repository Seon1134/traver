package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/postProcUp")
public class PostProcUpCtrl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public PostProcUpCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("utf-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String gpid = request.getParameter("gpid");
        String giid = request.getParameter("giid");

        HttpSession session = request.getSession();
        MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
        
        PostProcUpSvc postProcUpSvc = new PostProcUpSvc();
        postProcUpSvc.postUpdate(title, content, gpid);
        
        String url = "postView?gpid=" + gpid + "&giid=" + giid + "&miid=" + mi.getMi_id();
        response.sendRedirect(url);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}
