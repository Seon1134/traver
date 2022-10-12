package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/scheduleDay")
public class ScheduleDayListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ScheduleDayListCtrl() {super(); }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        
        
        int sddnum = Integer.parseInt(request.getParameter("sddnum"));     // 해당 일차
        String sddate = request.getParameter("sddate");     // 해당 날짜
        String piid =  request.getParameter("piid");        // 장소 id
        String piname = request.getParameter("piname");     // 장소 이름
        
        
        /*
         * 만약 날짜를 수정하게되면?
         * 각 번호에 부여돼있던 모든 날짜가 바뀌어야해. 그건 곤란.
         * 그럼 처음부터 일차번호만 넣고, for문 돌리면서 날짜는 등록할때 계산해서 set해서 넣자.
         * 
         * 보여주는건 어레이리스트 순서대로.
         */
                
        
        HttpSession session = request.getSession();
        ArrayList<ScheduleDay> scheduleDayList = (ArrayList<ScheduleDay>)session.getAttribute("scheduleDayList");
        
        int result = 0;
        
        if (scheduleDayList.size() < 10) {
            ScheduleDay sd = new ScheduleDay();
            sd.setSd_dnum(sddnum);
            sd.setSd_date(sddate);
            sd.setPi_id(piid);
            sd.setPi_name(piname);
            
            scheduleDayList.add(sd);
            session.setAttribute("scheduleDayList", scheduleDayList);

            result = scheduleDayList.size();   
        } else {
            result = 0;
        }
        

        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(result);
	}

}
