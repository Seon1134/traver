package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.MemberProcSvc;
import vo.*;

@WebServlet("*.mem")	// 회원 관련 작업(가입, 정보수정, 탈퇴) traverSite
public class MemberCtrl extends HttpServlet {

	private static final long serialVersionUID = 1L;
    public MemberCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	String kind = "";
    	String mi_mbti = "";
    	String mi_pw = "";
    	if (request.getAttribute("kind") != null) 
    	        kind = (String)request.getAttribute("kind");
    	else    kind = request.getParameter("kind");
    	if (request.getAttribute("mi_mbti") != null)
    	        mi_mbti = (String)request.getAttribute("mi_mbti");
    	else if ( request.getParameter("mi_mbti") != null )   
    	    mi_mbti = request.getParameter("mi_mbti");
    	if ( request.getParameter("mi_pw") != null )
    	    mi_pw = request.getParameter("mi_pw");
    	
        MemberInfo memberInfo = new MemberInfo();  
        
        HttpSession session = request.getSession();
        MemberInfo mi = null;
        
        if (kind.equals("mbti1") || kind.equals("mbti2")) {
            memberInfo.setMi_mbti(mi_mbti);
        }
        
        if (kind.equals("pwUp")) {
            memberInfo.setMi_pw(mi_pw);
        }
        
        if (kind.equals("in") || kind.equals("up")) {
        // 현재 처리하는 작업이 회원 가입이나 정보 수정일 경우
            memberInfo.setMi_nickname(request.getParameter("mi_nickname"));
            memberInfo.setMi_mbti(mi_mbti);
            memberInfo.setMi_mail(request.getParameter("e1") + "@" + 
            request.getParameter("e3"));
        }
        
        if (kind.equals("in")) {
            memberInfo.setMi_id(request.getParameter("mi_id").trim().toLowerCase());
            memberInfo.setMi_pw(request.getParameter("mi_pw").trim());
            memberInfo.setMi_name(request.getParameter("mi_name").trim());
            memberInfo.setMi_birth(request.getParameter("mi_birth"));
            

        } else if (kind.equals("up") || kind.equals("del") || kind.equals("mbti1") || kind.equals("mbti2") || kind.equals("pwUp") ) {
        // 정보 수정이나 탈퇴인 경우는 로그인 상태이므로 아이디를 세션에서 추출하여 가져감
            mi = (MemberInfo)session.getAttribute("loginInfo");
            memberInfo.setMi_id(mi.getMi_id());
            // 매개변수로 가져갈 MemberInfo형 인스턴스 memberInfo에 회원 아이디를 저장함
            // 정보 수정이나 탈퇴시 where 절에서 조건으로 사용할 아이디가 필요하기 때문
        }
        
        
        MemberProcSvc memberProcSvc = new MemberProcSvc();
        int result = memberProcSvc.memberProc(kind, memberInfo);

        String link = "../index.jsp";   // 작업 후 이동할 경로를 저장할 변수
        if (result == 1) {  // 정상적으로 동작되었으면
            if (kind.equals("in"))          {
                session.setAttribute("loginInfo", memberInfo);
                session.setMaxInactiveInterval(1800);
                ArrayList<ScheduleDay> scheduleDayList = new ArrayList<ScheduleDay>(); // 내 일정에 담은 장소를 저장할 스케줄 장소리스트
                ScheduleInfo scheduleInfo = new ScheduleInfo(); // 일정정보
                session.setAttribute("scheduleDayList", scheduleDayList); //세션에 담기
                session.setAttribute("scheduleInfo", scheduleInfo); //세션에 담기
                session.setAttribute("selectDay", 0);
                session.setAttribute("selectDate", " ");
                link = "../member/join_end.jsp";
            }
            else if (kind.equals("del"))    link = "../member/logout.jsp";
            else if (kind.equals("up")) {
                link = "../mypage/info_up_form.jsp";
                mi.setMi_mbti(memberInfo.getMi_mbti());
                mi.setMi_mail(memberInfo.getMi_mail());
                // 정보 수정 성공시 현재 세션에 들어있는 로그인 회원 정보도 변경시킴
            } 
            else if (kind.equals("mbti1")) {
                link="/traverSite/MBTIMain";
                mi.setMi_mbti(memberInfo.getMi_mbti());
                mi.setMi_mail(memberInfo.getMi_mail());
            }
            else if (kind.equals("mbti2")) {
                link="lmth/mbti/mbti_start_sub2.jsp";
                mi.setMi_mbti(memberInfo.getMi_mbti());
                mi.setMi_mail(memberInfo.getMi_mail());
            }
            else if (kind.equals("pwUp")) {
                link="../mypage/pw_check.jsp";
                mi.setMi_pw(memberInfo.getMi_pw());
            }
        } else {
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script> alert('작업에 실패했습니다. 다시 시도해 보세요.'); history.back(); </script>");
            out.close();
        }
        
    	response.sendRedirect(link);
	}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
