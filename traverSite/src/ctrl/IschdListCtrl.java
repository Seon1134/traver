package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.*;
import svc.*;
import vo.*;

@WebServlet("/ischdList")
public class IschdListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public IschdListCtrl() { super(); }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    
	    ArrayList<GoodInfo> goodList = new ArrayList<GoodInfo>();
        // 관심일정 목록을 저장하기 위한 ArrayList로 안에 저장될 데이터는 GoodInfo형 인스턴스만 허용
	   
	    HttpSession session = request.getSession();
        MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
        
	    String sy = ""; // 검색년도
        if (request.getParameter("sy") != null)  sy = request.getParameter("sy");
        
        String keyword = request.getParameter("keyword"); // 검색키워드
        
        // select * from t_schedule_zzim a, t_good_info b 
        // where a.mi_id = 'test11' and a.gi_id = b.gi_id and b.gi_name like '%%' order by a.sz_date
        
        String where = " where a.mi_id ='" + loginInfo.getMi_id() + "' and a.gi_id = b.gi_id ";  // 검색어가 있을 경우 where절을 저장할 변수 
        if (keyword == null ) {                   // 검색어가 없으면
            keyword = ""; 
        } else if (!keyword.equals("")) {    // 검색어가 있을 경우
            URLEncoder.encode(keyword, "UTF-8");
            // 쿼리스트링으로 주고 받는 검색어가 한글일 경우 IE에서 간혹 문제가 발생할 수 있으므로 유니코드로 변환시킴
            where += " and gi_name like '%" + keyword + "%' ";    
        }
        
        
        
        String o = request.getParameter("o");     // 정렬조건 
        if (o == null || o.equals(""))  o = "a";    // 정렬조건이 없으면 기본 a(등록 최신 순)정렬
        String orderBy = "";
        switch (o) {
        case "a" : // 등록 최신 순
            orderBy = " order by a.gi_id desc";   break;
        case "b" : // 등록 오래된 순
            orderBy = " order by a.gi_id";        break;
        }
        
        IschdListSvc ischdListSvc = new IschdListSvc();
        
        goodList = ischdListSvc.getIschdList(where, orderBy); // 목록화면에서 보여줄 관심일정 목록 ArrayList형으로 받아옴
        
        request.setAttribute("sy", sy); 
        request.setAttribute("keyword", keyword); 
        request.setAttribute("o", o); 
        request.setAttribute("goodList", goodList);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("lmth/mysche/ischd_list.jsp");
        dispatcher.forward(request, response);
        
	}

}
