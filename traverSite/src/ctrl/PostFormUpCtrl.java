package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;


@WebServlet("/postFormUp")
public class PostFormUpCtrl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public PostFormUpCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        String title = request.getParameter("title");
        String nickname = request.getParameter("nickname");
        String mbti = request.getParameter("mbti");
        String giname = request.getParameter("giname");
        String list = request.getParameter("list");
        String content = request.getParameter("content");
        String gpid = request.getParameter("gpid");
        String giid = request.getParameter("giid");
        
        request.setAttribute("title", title);
        request.setAttribute("nickname", nickname);
        request.setAttribute("mbti", mbti);
        request.setAttribute("giname", giname);
        request.setAttribute("list", list);
        request.setAttribute("content", content);
        request.setAttribute("gpid", gpid);
        request.setAttribute("giid", giid);
        
        RequestDispatcher dispatcher = 
                request.getRequestDispatcher("lmth/mbti/mbti_form_up.jsp");
            dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}