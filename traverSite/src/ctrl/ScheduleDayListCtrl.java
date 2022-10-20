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
        
        String piid =  request.getParameter("piid");        // 장소 id
        String coords =  request.getParameter("coords");        // 장소 id
        String piname = request.getParameter("piname");     // 장소 이름
        int sddnum = Integer.parseInt(request.getParameter("sddnum"));     // 해당 일차
        String sddate = request.getParameter("sddate");     // 해당 날짜
        
        
        /*
         * 만약 날짜를 수정하게되면?
         * 각 번호에 부여돼있던 모든 날짜가 바뀌어야해. 그건 곤란.
         * 그럼 처음부터 일차번호만 넣고, for문 돌리면서 날짜는 등록할때 계산해서 set해서 넣자.
         * 
         * 보여주는건 어레이리스트 순서대로.
         */
                
        
        HttpSession session = request.getSession();
        ArrayList<ScheduleDay> scheduleDayList = (ArrayList<ScheduleDay>)session.getAttribute("scheduleDayList");
        
        int result = 0; // 0 알 수 없는 오류, 1 장소개수 초과 실패, 2 중복 장소 실패, 3 성공
        boolean isCanAddDay = true;   // 동일 일차 10개 초과여부 저장 변수
        boolean isCanAddPlace = true;   // 동일 일차 장소 중복여부 저장 변수 
        int dayCount = 0; // 해당일차의 개수를 저장할 변수 
        
        for (int i = 0 ; i < scheduleDayList.size(); i++ ) { // 일차 개수, 중복 장소여부 검사 반복문
            ScheduleDay sd = scheduleDayList.get(i);
            if( sd.getSd_dnum() == sddnum ) { // 일차 개수 검사 + 증가 (저장된 일자와 선택된 일자 동일시)
                dayCount ++;    // 일차 개수 1증가
                if (sd.getPi_id().equals(piid)) {   // 중복 장소 존재이라면 저장 + 정지
                    isCanAddPlace = false;
                    result = 2;
                    break;
                }
            }
            if (dayCount >= 10) { // 일차 10개 초과라면 저장 + 정지
                isCanAddDay = false;
                result = 1;
                break;
            }
        }

        
        if (isCanAddDay == true && isCanAddPlace == true) { // 장소 추가가 가능하면 추가 (10개미만, 중복X)
            ScheduleDay sd = new ScheduleDay();
            sd.setPi_id(piid);
            sd.setPi_name(piname);
            sd.setSd_coords(coords);
            sd.setSd_dnum(sddnum);
            sd.setSd_date(sddate);
            
            scheduleDayList.add(sd);
            session.setAttribute("scheduleDayList", scheduleDayList);

            result = 3; //성공
        } 
        

        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(result);
	}

}
