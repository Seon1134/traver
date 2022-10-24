package ctrl;

import java.io.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/postProcIn") // ¼öÁ¤Áß
public class PostProcInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PostProcInCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("utf-8");
        String title = request.getParameter("title");
        String sdList = request.getParameter("sdList");
        String[] si = request.getParameterValues("si");
        String[] sd = request.getParameterValues("sd");
        String content = request.getParameter("content");
        HttpSession session = request.getSession();
        MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
        
        PostProcInSvc postProcInSvc = new PostProcInSvc();
        
        String gigd = postProcInSvc.goodInsert(si, sd);
        
        String[] gigdArr = gigd.split("/");
        String gi = gigdArr[0];
        
        GoodPost goodPost = new GoodPost();
        
        goodPost.setGi_id(gi);
        goodPost.setMi_id(mi.getMi_id());
        goodPost.setMi_nickname(mi.getMi_nickname());
        goodPost.setGp_mbti(mi.getMi_mbti());
        goodPost.setGp_title(title);
        goodPost.setGp_list(sdList);
        goodPost.setGp_content(content);
        goodPost.setGp_img(si[4]);
        goodPost.setGp_ip(request.getRemoteAddr());
        
        String gpgi = postProcInSvc.goodPostInsert(goodPost);
        
        String[] gpgiArr = gpgi.split(",");
       
        String url = "postView?gpid=" + gpgiArr[0] + "&giid=" + gpgiArr[1] + "&miid=" + mi.getMi_id();
        response.sendRedirect(url);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}
