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
        
        ScheduleInfo scheduleInfo = null;
        ArrayList<ScheduleDay> scheduleDayList = null;
        
        ArrayList<ScheduleInfo> scheduleInfoList = postFormInSvc.getScheduleList(miid);
        
        if ( request.getParameter("siid") != null ) {
            String siid = request.getParameter("siid");
            for ( int i = 0; i < scheduleInfoList.size(); i++ ) {
                ScheduleInfo si = scheduleInfoList.get(i);
                if ( si.getSi_id().equals(siid) ) {
                    scheduleInfo = si;
                }
            }
            scheduleDayList = postFormInSvc.getScheduleDayList(siid);
        }
        
        
        String title = "";
        String content = "";
        if ( request.getParameter("title") != null ) {
            title = request.getParameter("title");
        }
        if ( request.getParameter("content") != null ) {
            content = request.getParameter("content");
        }
        
        request.setAttribute("scheduleInfoList", scheduleInfoList);
        request.setAttribute("scheduleInfo", scheduleInfo);
        request.setAttribute("scheduleDayList", scheduleDayList);
        request.setAttribute("title", title);
        request.setAttribute("content", content);
        
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