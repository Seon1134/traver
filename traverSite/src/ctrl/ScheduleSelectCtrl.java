package ctrl;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import svc.*;
import vo.*;

@WebServlet("/scheduleSelect")
public class ScheduleSelectCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ScheduleSelectCtrl() {  super(); }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectDay = request.getParameter("day");       // 선택한 날
        String selectDate = request.getParameter("sdate");   // 선택한 날의 날짜
        

        HttpSession session = request.getSession();
        session.setAttribute("selectDay", selectDay);
        session.setAttribute("selectDate", selectDate);
        
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(selectDay);
	}
}
