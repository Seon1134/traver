package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminReportListSvc {
    public ArrayList<Report> getAdminReportList(String where, int cpage, int psize) {
        ArrayList<Report> adminReport = new ArrayList<Report>();
        Connection conn = getConnection();
        AdminReportListDao adminReportListDao = AdminReportListDao.getInstance();
        adminReportListDao.setConnection(conn);
        
        adminReport = adminReportListDao.getAdminReportList(where, cpage, psize);
        close(conn);
        
        return adminReport;
    }
}
