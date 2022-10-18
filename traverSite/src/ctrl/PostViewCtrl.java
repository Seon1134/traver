package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/postView")
public class PostViewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PostViewCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String gpid = request.getParameter("gpid");
        String giid = request.getParameter("giid");
        String miid = "";
        boolean isGood = false;
        boolean isInterest = false;
        
        PostViewSvc postViewSvc = new PostViewSvc();
        if ( request.getParameter("miid") != null ) { 
            miid = request.getParameter("miid");
            isGood = postViewSvc.isGood(gpid,miid); // 좋아요 눌렀는지 여부 확인
            isInterest = postViewSvc.isInterest(giid,miid); // 관심등록 했는지 여부 확인
            if (  request.getParameter("kind") != null ) {
                if ( request.getParameter("kind").equals("good") ) { // 메인이나 리스트에서  호출한 것이 아니라 좋아요 버튼을 눌러서 리로드 하는 경우
                    postViewSvc.gcntUpdate(gpid, miid); // 좋아요 수 증가
                } else if ( request.getParameter("kind").equals("interest") ) { // 메인이나 리스트에서  호출한 것이 아니라 관심등록 버튼을 눌러서 리로드 하는 경우
                    postViewSvc.goodUpdate(giid, miid); // 관심일정에 추가
                }
            }
        }
        
        GoodInfo goodInfo = postViewSvc.getGoodInfo(giid);
        ArrayList <GoodDay> goodDayList = postViewSvc.getGoodDayList(giid);
        
        GoodPost goodPost = postViewSvc.getGoodPost(gpid);
        request.setAttribute("goodPost", goodPost);
        request.setAttribute("isGood", isGood);
        request.setAttribute("isInterest", isInterest);
        request.setAttribute("goodInfo", goodInfo);
        request.setAttribute("goodDayList", goodDayList);
        
        RequestDispatcher dispatcher = 
                request.getRequestDispatcher("lmth/mbti/mbti_view.jsp");
            dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}