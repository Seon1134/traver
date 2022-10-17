package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ReportProcDao {
    private static ReportProcDao reportProcDao;
    private Connection conn;
    private ReportProcDao() {}

    public static ReportProcDao getInstance() {
        if (reportProcDao == null) reportProcDao = new ReportProcDao();
        return reportProcDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }
    
    public int reportInsert(Report report) {
        Statement stmt = null;
        int result = 0;

        try {
            stmt = conn.createStatement();
            String sql = "insert into t_report (mi_id, rl_idx, gp_id, re_rop, re_why, re_ip, re_date) values " +
                        "('"+ report.getMi_id() + "', null , '" + report.getGp_id() + "', 'p', '" + 
                        report.getRe_why() + "', '" + report.getRe_ip() + "', now())";
            System.out.println(sql);
            result = stmt.executeUpdate(sql);

        } catch(Exception e) {
            System.out.println("ReportProcDao 클래스의 reportInsert() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }

        return result;
    }
}
