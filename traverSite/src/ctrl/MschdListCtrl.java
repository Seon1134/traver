package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/mschdList")
public class MschdListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MschdListCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
		// 내일정 목록을 저장하기 위한 ArrayList로 안에 저장될 데이터는 ScheduleInfo형 인스턴스만 허용
		
		HttpSession session = request.getSession();
		MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
		if (loginInfo == null) { // 로그인 되어 있지 않으면
            response.setContentType("text/html; charset=utf-8"); 
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인 후 사용하실 수 있습니다.');");
            out.println("location.replace('/traverSite/lmth/member/login_form.jsp');");
            out.println("</script>");
            out.close();
        } 
		
		String sy = "";
		if (request.getParameter("sy") != null)  sy = request.getParameter("sy");
		
		String keyword = request.getParameter("keyword"); // 일정명 검색어 keyword
		
		String where = " where mi_id ='" + loginInfo.getMi_id() + "' ";	 // 검색어가 있을 경우 where절을 저장할 변수 
		if (keyword == null ) {                   // 검색어가 없으면
		    keyword = ""; 
        } else if (!keyword.equals("")) {    // 검색어가 있을 경우
            URLEncoder.encode(keyword, "UTF-8");
            // 쿼리스트링으로 주고 받는 검색어가 한글일 경우 IE에서 간혹 문제가 발생할 수 있으므로 유니코드로 변환시킴
            where += " and si_name like '%" + keyword + "%' ";    
        }
		
		String o = request.getParameter("o");     // 정렬조건 
		if (o == null || o.equals(""))  o = "a";    // 정렬조건이 없으면 기본 a(등록 최신 순)정렬
        String orderBy = "";
        switch (o) {
        case "a" : // 등록 최신 순
            orderBy = " order by si_date desc";   break;
        case "b" : // 등록 오래된 순
            orderBy = " order by si_date";        break;
        }
		
		MschdListSvc mschdListSvc = new MschdListSvc();
		scheduleList = mschdListSvc.getMschdList(where, orderBy); // 목록화면에서 보여줄 일정 목록 ArrayList형으로 받아옴
		
		request.setAttribute("sy", sy); 
		request.setAttribute("keyword", keyword); 
		request.setAttribute("o", o); 
		request.setAttribute("scheduleList", scheduleList);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("lmth/mysche/mschd_list.jsp");
        dispatcher.forward(request, response);
	}
	
}
