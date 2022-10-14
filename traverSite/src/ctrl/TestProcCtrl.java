package ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/testProc")
public class TestProcCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public TestProcCtrl() { super(); }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("utf-8");

        String quest1 = request.getParameter("quest1");
        String quest2 = request.getParameter("quest2");
        String quest3 = request.getParameter("quest3");
        String quest4 = request.getParameter("quest4");
        
        String mbti = quest1 + quest2 + quest3 + quest4;
        String kind = "mbti2";
        
        request.setAttribute("kind", kind);
        request.setAttribute("mi_mbti", mbti);
        
        RequestDispatcher dispatcher = 
                request.getRequestDispatcher("member_proc.mem");
            dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
}
