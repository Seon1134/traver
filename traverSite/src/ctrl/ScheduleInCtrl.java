package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/scheduleIn")
public class ScheduleInCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ScheduleInCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // 일정 추가한 장소 & 일정 정보를 DB에 저장할 컨트롤
        request.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();
        ArrayList<ScheduleDay> scheduleDayList = (ArrayList<ScheduleDay>)session.getAttribute("scheduleDayList");
        // 추가한 일정(장소)정보가 담긴 리스트
        
        if (scheduleDayList.size() == 0) {  // 어떤 장소도 추가되지 않았다면 튕겨버리기!
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('일정을 추가한 후 다시 시도해 주세요.');");
            out.println("</script>");
            out.close();
        }
        

        //scheduleInfo Insert 모음집
        String scheduleName = (String)session.getAttribute("schedule_name"); // 일정명
        if (scheduleName == null || scheduleName.equals("null")) {
            scheduleName = "임시 저장 일정";
        }
        ScheduleInfo scheduleInfo = (ScheduleInfo)session.getAttribute("scheduleInfo"); 
        // 일정 정보 불러오기 (시작일, 종료일, day개수)

        MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
        String miid = mi.getMi_id(); // scheduleInfo insert용 miid
        String imgPiid = scheduleDayList.get(0).getPi_id(); // 이미지 추출용 임의의 piid 하나
        // scheduleDayList = 추가한 일정(장소)리스트 불러오기 (일정ID, 장소ID, 장소명, 일차번호, 해당날짜, 순서)
        ScheduleInSvc scheduleInSvc = new ScheduleInSvc();
        String result = scheduleInSvc.scheduleInsert(miid, scheduleName, imgPiid, scheduleInfo, scheduleDayList);
       
        String[] arr = result.split(":");
        String siid = arr[0]; // 일정 ID
        int infoSuccess = Integer.parseInt(arr[1]); //저장된 info 개수
        int daySuccess = Integer.parseInt(arr[2]); // 저장된 day개수
        int dayTarget = Integer.parseInt(arr[3]); // 저장됐어야할 day개수
        
        if (infoSuccess > 0 && daySuccess == dayTarget) { // 일정등록 성공했으면
            // 세션에 저장된 값들 날려버리기
            session.removeAttribute("scheduleDayList");
            session.removeAttribute("scheduleInfo");
            session.removeAttribute("selectDay");
            session.removeAttribute("selectDate");
            session.removeAttribute("dateList");
            
            // 세션에 내용값들 다시 만들기
            ArrayList<ScheduleDay> scheduleDayLst = new ArrayList<ScheduleDay>();
            ScheduleInfo scheduleIfo = new ScheduleInfo();
            session.setAttribute("scheduleDayList", scheduleDayLst);
            session.setAttribute("scheduleInfo", scheduleIfo);
            session.setAttribute("selectDay", 0);
            session.setAttribute("selectDate", " ");
            
            
            request.setAttribute("siid", siid);
            response.sendRedirect("/traverSite/lmth/gotraver/remove_session.jsp?siid=" + siid); // 디테일페이지로 siid를 가지고 이동
        } else { // 일정 등록에 실패했으면
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script> alert('일정 등록에 실패했습니다.'); history.back(); </script>");
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
