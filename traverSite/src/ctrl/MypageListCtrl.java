package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;
import java.util.*;

@WebServlet("/mypageList")
public class MypageListCtrl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public MypageListCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();
        MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
        String miid = loginInfo.getMi_id();
        
        MypageListSvc mypageListSvc = new MypageListSvc();
        ArrayList<GoodPost> goodPostList = mypageListSvc.getGoodPostList(miid);
        // ArrayList<ReviewList> reviewList = mypageListSvc.getReviewList(miid);
        
        request.setAttribute("goodPostList", goodPostList);
        // request.setAttribute("reviewList", reivewList);
        
        RequestDispatcher dispatcher = 
                request.getRequestDispatcher("lmth/mypage/post_review_list.jsp");
            dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}
