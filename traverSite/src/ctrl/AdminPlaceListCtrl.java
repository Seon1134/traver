package ctrl;

import java.io.*;
import java.net.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/adminPlaceList")
public class AdminPlaceListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminPlaceListCtrl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// 장소 등록 게시판 글목록을 저장하기 위한 ArrayList로 안에 저장될 데이터는 placeInfo형 인스턴스만 허용한다.
		
		int cpage = 1, psize = 10, bsize = 4, rcnt = 0, pcnt = 0, spage = 0;
		// 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수, 시작페이지 등을 저장할 변수들
		
		if (request.getParameter("cpage") != null)
            cpage = Integer.parseInt(request.getParameter("cpage"));
        // cpage 값이 있으면 받아서 int형으로 형변환 시킴(보안상의 이유와 산술연산을 해야 하기 때문)
		
		String schtype = request.getParameter("schtype"); // 검색조건(장소명, 번호, 분류, 게시 여부, 등록일, 주소)
        String keyword = request.getParameter("keyword");   // 검색어 
        String where = "";      // 검색 조건이 있을 경우 where절을 저장할 변수
        if (schtype == null || keyword == null) {
            schtype = "";   keyword = "";
        } else if (!schtype.equals("") && !keyword.equals("")) {    // 검색조건과 검색어가 있을 경우
            URLEncoder.encode(keyword, "UTF-8");
            // 쿼리스트링으로 주고 받는 검색어가 한글일 경우 IE에서 간혹 문제가 발생할 수 있으므로 유니코드로 변환시킴
            where = " where pi_" + schtype + " like '%" + keyword + "%' ";
        }
        
        AdminPlaceListSvc adminPlaceListSvc = new AdminPlaceListSvc();
        ArrayList<PlaceInfo> placeInfo = adminPlaceListSvc.getAdminPlaceList(where, cpage, psize);

        rcnt = adminPlaceListSvc.getPlaceListCount(where);
        // 검색된 게시글의 총 개수로 게시글 일련번호 출력과 전체 페이지수 계산을 위해 필요한 값

		AdminPlaceInfo adminPlaceList = new AdminPlaceInfo();
		adminPlaceList.setBsize(bsize);       adminPlaceList.setCpage(cpage);
		adminPlaceList.setPcnt(pcnt);         adminPlaceList.setPsize(psize);
		adminPlaceList.setRcnt(rcnt);         adminPlaceList.setSpage(spage);
		adminPlaceList.setSchtype(schtype);   adminPlaceList.setKeyword(keyword);

		request.setAttribute("adminPlaceList", adminPlaceList);
		request.setAttribute("placeInfo", placeInfo);

        RequestDispatcher dispatcher = request.getRequestDispatcher("lmth/admin/02_place/place_list.jsp");
        dispatcher.forward(request, response);
	}
}
