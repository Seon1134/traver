package ctrl;

import java.io.*;
import java.net.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/adminMemberList")
public class AdminMemberListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminMemberListCtrl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    
	    int cpage = 1, psize = 10, bsize = 4, rcnt = 0, pcnt = 0, spage = 0;
        // 현재 페이지 번호, 페이지 크기, 블록 크기, 레코드(게시글) 개수, 페이지 개수, 시작페이지 등을 저장할 변수들
        
        if (request.getParameter("cpage") != null)
            cpage = Integer.parseInt(request.getParameter("cpage"));
        
        String schtype = request.getParameter("schtype"); // 검색조건(아이디, 닉네임, 이름, 이메일, 상태, 가입일)
        String keyword = request.getParameter("keyword");   // 검색어 
        String where = "";      // 검색 조건이 있을 경우 where절을 저장할 변수
        if (schtype == null || keyword == null) {
            schtype = "";   keyword = "";
        } else if (!schtype.equals("") && !keyword.equals("")) {    // 검색조건과 검색어가 있을 경우
            URLEncoder.encode(keyword, "UTF-8");
            // 쿼리스트링으로 주고 받는 검색어가 한글일 경우 IE에서 간혹 문제가 발생할 수 있으므로 유니코드로 변환시킴
            where = " where mi_" + schtype + " like '%" + keyword + "%' ";
        }
        
        AdminMemberListSvc adminMemberListSvc = new AdminMemberListSvc();
        ArrayList<MemberInfo> memberInfo = adminMemberListSvc.getAdminMemberList(where, cpage, psize);

        rcnt = adminMemberListSvc.getMemberListCount(where);
        // 검색된 게시글의 총 개수로 게시글 일련번호 출력과 전체 페이지수 계산을 위해 필요한 값

        AdminMemberInfo adminMemberInfo = new AdminMemberInfo();
        adminMemberInfo.setBsize(bsize);       adminMemberInfo.setCpage(cpage);
        adminMemberInfo.setPcnt(pcnt);         adminMemberInfo.setPsize(psize);
        adminMemberInfo.setRcnt(rcnt);         adminMemberInfo.setSpage(spage);
        adminMemberInfo.setSchtype(schtype);   adminMemberInfo.setKeyword(keyword);

        request.setAttribute("adminMemberInfo", adminMemberInfo);
        request.setAttribute("memberInfo", memberInfo);

        RequestDispatcher dispatcher = request.getRequestDispatcher("lmth/admin/01_member/mem_list.jsp");
        dispatcher.forward(request, response);
	}
}
