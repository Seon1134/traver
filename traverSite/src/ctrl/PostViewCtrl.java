package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/postView")
public class PostViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PostViewCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String gpid = request.getParameter("gpid");
        String miid = "";
        int result = 0;
        int isGood = 0;
        
        PostViewSvc postViewSvc = new PostViewSvc();
        if ( request.getParameter("miid") != null ) {
            miid = request.getParameter("miid");
            result = postViewSvc.gcntUpdate(gpid, miid);
            isGood = postViewSvc.isGood(gpid,miid);
        }
        
        System.out.println("컨트롤러 isGood : " + isGood);
        GoodPost goodPost = postViewSvc.getGoodPost(gpid);
        request.setAttribute("goodPost", goodPost);
        request.setAttribute("result", result);
        request.setAttribute("isGood", isGood);
        
        RequestDispatcher dispatcher = 
                request.getRequestDispatcher("lmth/mbti/mbti_view.jsp");
            dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}