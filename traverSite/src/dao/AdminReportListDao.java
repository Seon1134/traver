package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminReportListDao {
    private static AdminReportListDao adminReportListDao; 
    private Connection conn;
    private AdminReportListDao() {}
    
    public static AdminReportListDao getInstance() {
        if (adminReportListDao == null) {
            adminReportListDao = new AdminReportListDao();
        }
        return adminReportListDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<Report> getAdminReportList(String where, int cpage, int psize) {
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<Report> adminReport = new ArrayList<Report>(); 
        Report re = null;
    
        try {
            stmt = conn.createStatement();
            String sql = "select mi_id, mi_nickname, mi_name, mi_mail, mi_status, mi_join " + 
                    " from t_member_info " + where + " order by re_idx desc " + 
                    " limit " + ((cpage -1) * psize) + ", " + psize;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                re = new Report();
                
                adminReport.add(re);
            }

        } catch (Exception e) {
            System.out.println("AdminReportListDao 클래스의 getAdminReportList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);
            close(stmt);
        }
        
        return adminReport;
    }
}
