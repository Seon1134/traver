package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/postList")
public class PostListCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PostListCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String mbti = "";                                 //라디오버튼으로 선택한 mbti값
        String order = "gp_date";                                //라디오버튼으로 선택한 정렬 기준
        String dora = "desc";                                 //라디오버튼으로 선택한 정렬 방식
        String where = " where 1+1";
        String orderby = "";
        String schselect = "";
        String schkeyword = "";
        String miid = "";
        HttpSession session = request.getSession();

        if ( request.getParameter("mbti") != null ) {
            if ( !request.getParameter("mbti").equals("total")) {
                mbti = request.getParameter("mbti");
                where += " and gp_mbti = '" + mbti + "'";
            }
        } else { mbti = "total"; }
        
        if ( request.getParameter("schselect") != null && request.getParameter("schkeyword") != null) {
            schselect = request.getParameter("schselect");
            schkeyword = request.getParameter("schkeyword");
            
            if ( schselect.equals("title"))
                where += " and gp_title like '%" + schkeyword + "%' ";
            else if ( schselect.equals("id") )
                where += " and mi_id like '%" + schkeyword + "%' ";
            else if ( schselect.equals("nickname") )
                where += " and mi_nickname like '%" + schkeyword + "%' ";
            else if ( schselect.equals("content") )
                where += " and gp_content like '%" + schkeyword + "%' ";
            else if ( schselect.equals("place") )
                where += " and gp_list like '%" + schkeyword + "%' ";
        } 
        
        if ( session.getAttribute("loginInfo") != null ) {
            MemberInfo mi = (MemberInfo)session.getAttribute("loginInfo");
            miid = mi.getMi_id();
            where += " and gp_id not in (select gp_id from t_report where mi_id = '" + miid + "') ";
        }
       
        if ( request.getParameter("order") != null && request.getParameter("dora") != null) {
            order = request.getParameter("order");
            dora = request.getParameter("dora");
        } 
        
        orderby += " order by " + order + " " + dora  ;
        
        PostListSvc postListSvc = new PostListSvc();
        
        ArrayList<GoodPost> postList = postListSvc.getPostList(where, orderby);
        
        request.setAttribute("order", order);
        request.setAttribute("dora", dora);
        request.setAttribute("mbti", mbti);
        request.setAttribute("schselect", schselect);
        request.setAttribute("schkeyword", schkeyword);
        
        request.setAttribute("postList", postList);
        
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(postList);
        
        RequestDispatcher dispatcher = 
                request.getRequestDispatcher("lmth/mbti/mbti_list.jsp");
            dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}