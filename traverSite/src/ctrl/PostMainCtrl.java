package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/postMain")
public class PostMainCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PostMainCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        
        String mbti = "";
        String miid = "";
        if ( session.getAttribute("loginInfo") != null ) { // 로그인 상태면
            MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
            mbti = mi.getMi_mbti();
            if ( mbti.equals("0000") ) mbti = "ISTJ"; // '테스트 안함' 선택 시 
        } else mbti = "ISTJ"; // 로그인 x 상태면
        
        if ( request.getParameter("mbti") != null ) {
            mbti = request.getParameter("mbti");
        }
        
        PostMainSvc postMainSvc = new PostMainSvc();
        
        // MBTI 좋아요 수가 많은 게시글 불러오기 
        ArrayList<GoodPost> mbtiPostList = postMainSvc.getMBTIPostList(mbti);
        request.setAttribute("mbtiPostList", mbtiPostList);
        
        // MBTI 무관 인기 게시글 불러오기
        ArrayList<GoodPost> popPostList = postMainSvc.getPopPostList();
        request.setAttribute("popPostList", popPostList);
        
        RequestDispatcher dispatcher = 
                request.getRequestDispatcher("lmth/mbti/mbti_main.jsp");
            dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}