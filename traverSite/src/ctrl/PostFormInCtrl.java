package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/postFormIn")
public class PostFormInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PostFormInCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        
        HttpSession session = request.getSession();
        MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
        String miid = mi.getMi_id();
        
        PostFormInSvc postFormInSvc = new PostFormInSvc();
        
        ArrayList<ScheduleInfo> scheduleList = postFormInSvc.getScheduleList(miid);
        request.setAttribute("scheduleList", scheduleList);
        
        RequestDispatcher dispatcher = 
                request.getRequestDispatcher("lmth/mbti/mbti_form_in.jsp");
            dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}