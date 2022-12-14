package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/scheduleInfo")
public class ScheduleInfoCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ScheduleInfoCtrl() { super(); }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        
        String sisdate = request.getParameter("sisdate");       // 시작일
        String siedate = request.getParameter("siedate");       // 종료일
        int sidnum =  Integer.parseInt(request.getParameter("sidnum"));        // 총 일차수
        String simax = request.getParameter("simax");   // 종료일 캘린더 max 값
        System.out.println(simax);
        /*
         * 만약 날짜를 수정하게되면?
         * 각 번호에 부여돼있던 모든 날짜가 바뀌어야해. 그건 곤란.
         * 그럼 처음부터 일차번호만 넣고, for문 돌리면서 날짜는 등록할때 계산해서 set해서 넣자.
         * 
         * 보여주는건 어레이리스트 순서대로.
         */
                
        
        HttpSession session = request.getSession();
        ScheduleInfo scheduleInfo = (ScheduleInfo)session.getAttribute("scheduleInfo");
        
        scheduleInfo.setSi_sdate(sisdate);
        scheduleInfo.setSi_edate(siedate);
        scheduleInfo.setSi_dnum(sidnum);
        scheduleInfo.setSi_max(simax);
       
        
        session.setAttribute("scheduleInfo", scheduleInfo);
        int result = scheduleInfo.getSi_dnum();
        
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(result);
	}

}
