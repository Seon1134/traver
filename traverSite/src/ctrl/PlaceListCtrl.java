package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/placeList")
public class PlaceListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PlaceListCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
		
		String placeCategory = request.getParameter("placeCategory"); // 우측 사이드박스의 카테고리 선택여부 변수
		String viewOption = request.getParameter("viewOption"); // '추가한 장소' '찜한장소'등 상단 [옵션박스] value 변수
		// 0 Day별로 / 1 전체보기 / 2 추가장소 / 3 찜 / 4 추가찜
		String searchKeyword = request.getParameter("searchKeyword"); // '검색어' 변수
		String where = " where pi_isview = 'y' "; // 옵션 값을 넘길 where 절을 저장할 변수
		int viewDayNum = 1;   // Day별 장소수을 저장할 변수
		
		if (request.getParameter("viewDayNum") != null ) {
		    viewDayNum = Integer.parseInt(request.getParameter("viewDayNum"));
		}
		
		if (viewOption == null || viewOption.equals("")) {	// 만약 옵션박스를 어떤것도 선택하지 않았으면 기본값은 1
			viewOption = "1";
		}
		if (placeCategory == null || placeCategory.equals("")) {// 선택한 카테고리의 값이 없으면 기본값은 0
			placeCategory = "0";
		}
		if (searchKeyword == null || searchKeyword.equals("")) { // 입력한 키워드가 없으면 기본값은 "" 
			searchKeyword = "";
		}

		// view 옵션 관련 where 추가 switch문
		switch (viewOption) {
		case "1" :  // 만약 전체보기를 선택한다면 카테고리는 선택해제
			break;
		case "2" : //'추가한 장소 보기'를 선택했으면
			// request로 추가한 장소 String 값을 가져와 .split(',');
			// for문 돌리면서  pi_id = idx값 or문 만들어서 where문 제작
			break;
		case "3" : //'찜한 장소 보기'를 선택했으면
			HttpSession session = request.getSession();
			MemberInfo mi = new MemberInfo();
			String miid = mi.getMi_id();
			
			String where2 = " where mi_id = " + miid;
			// 장소 idx를 뽑아올 셀렉트문을 실행할 메소드명 (miid)
			// for문 돌리면서 pi_idx = idx값 or문 만들어서 where문 제작
			break;
		case "4" : // '찜한 장소 보기' and '추가한 장소'를 선택했으면
			// 위의 두개 합치기
			break;
		}// 옵션을 선택하지 않았으면 무엇도 추가하지 않는다 (전부 보여주기)

		
		
		// 카테고리 관련 where 추가 switch문
		switch (placeCategory) {
		    case "0" : // 카테고리 선택을 안했으면
		        break;
    		case "1" : // '숙소'카테고리를 선택했으면
    			where += " and pi_ctgr = '1' "; 	break;
    		case "2" : // '음식점' 카테고리를 선택했으면
    			where += " and pi_ctgr = '2' ";		break;
    		case "3" : // '관광지' 카테고리를 선택했으면
    			where += " and pi_ctgr = '3' "; 	break;
		} // 카테고리를 선택하지 않았으면 무엇도 추가하지 않는다. (전부 보여주기)
		
		
		
		// searchKeyword 관련 where 추가 if문
		if (!searchKeyword.equals("")) { // 검색어가 있으면
			where += " and pi_name like '%" + searchKeyword + "%' ";
		}
		

		PlaceListSvc placeListSvc = new PlaceListSvc();
		ArrayList<PlaceInfo> placeList = placeListSvc.getPlaceList(where);
		
		request.setAttribute("placeList", placeList);
        request.setAttribute("viewDayNum", viewDayNum);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(placeList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("lmth/gotraver/map_main.jsp");
		dispatcher.forward(request,	response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}

