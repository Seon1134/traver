package ctrl;

import java.io.*;
import java.net.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;
import svc.*;
import vo.*;

@WebServlet("/adminPlaceProcUp")

public class AdminPlaceProcUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminPlaceProcUpCtrl() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    String piid = request.getParameter("piid");
	    String name = request.getParameter("pi_name").trim();
        String phone = request.getParameter("pi_phone").trim();
        String link = request.getParameter("pi_homepage").trim();
        String ctgr = request.getParameter("pi_ctgr").trim();
        String zip = request.getParameter("pi_postcode");
        String coords = request.getParameter("pi_addressCoords");
        String addr1 = request.getParameter("pi_address");
        String addr21 = request.getParameter("pi_detailAddress");
        String addr22 = request.getParameter("pi_extraAddress");
        String addr2 = addr21 + addr22;
        
        String isview = request.getParameter("pi_isview");
        String desc = request.getParameter("pi_text");
        String img1 = request.getParameter("file_path_ssum");
        String img2 = request.getParameter("file_path1");
        String img3 = request.getParameter("file_path2");
        String img4 = request.getParameter("file_path3");
        String img5 = request.getParameter("file_path4");
        
        PlaceInfo placeInfo = new PlaceInfo();
        placeInfo.setPi_id(piid);
        placeInfo.setPi_name(name);
        placeInfo.setPi_phone(phone);
        placeInfo.setPi_link(link);
        placeInfo.setPi_ctgr(ctgr);
        placeInfo.setPi_zip(zip);
        placeInfo.setPi_coords(coords);
        placeInfo.setPi_addr1(addr1);
        placeInfo.setPi_addr2(addr2);
        placeInfo.setPi_isview(isview);
        placeInfo.setPi_desc(desc);
        placeInfo.setPi_img1(img1);
        placeInfo.setPi_img2(img2);
        placeInfo.setPi_img3(img3);
        placeInfo.setPi_img4(img4);
        placeInfo.setPi_img5(img5);
        
        AdminPlaceProcUpSvc adminPlaceProcUpSvc = new AdminPlaceProcUpSvc();
        int result = adminPlaceProcUpSvc.AdminPlaceProcUp(placeInfo);
        
        
        if (result > 0) {   // 정상적으로 글이 수정되었다면
            response.sendRedirect("/traverSite/adminPlaceList");
        } else {    // 글 수정에 문제가 발생했다면
            response.setContentType("text/html; charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('글 수정에 실패했습니다. 다시 시도해 보세요.');");
            out.println("history.back();");
            out.println("</script>");
            out.close();
        }
	}
}
