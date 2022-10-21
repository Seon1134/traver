package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminScheduleListDao {
    private static AdminScheduleListDao adminScheduleListDao; 
    private Connection conn;
    private AdminScheduleListDao() {}
    
    public static AdminScheduleListDao getInstance() {
        if (adminScheduleListDao == null) {
            adminScheduleListDao = new AdminScheduleListDao();
        }
        return adminScheduleListDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<AdminSchList> getAdminScheduleList(String where, int cpage, int psize) {
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<AdminSchList> adminSchList = new ArrayList<AdminSchList>(); 
        AdminSchList as = null;
    
        try {
            stmt = conn.createStatement();
            String sql = "select a.si_id, a.mi_id, b.mi_nickname, b.mi_name, a.si_dnum, a.si_name, a.si_date " +
                    " from t_schedule_info a, t_member_info b " + where + " group by a.si_id order by a.si_date desc " + 
                    " limit " + ((cpage -1) * psize) + ", " + psize;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                as = new AdminSchList();
                as.setSi_id(rs.getString("si_id"));
                as.setMi_id(rs.getString("mi_id"));
                as.setMi_nickname(rs.getString("mi_nickname"));
                as.setMi_name(rs.getString("mi_name"));
                as.setSi_dnum(rs.getInt("si_dnum"));
                as.setSi_name(rs.getString("si_name"));
                as.setSi_date(rs.getString("si_date"));
                adminSchList.add(as);
            }

        } catch (Exception e) {
            System.out.println("AdminScheduleListDao 클래스의 getAdminScheduleList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);
            close(stmt);
        }
        
        return adminSchList;
    }

    public int getSchListCount(String where) {
        Statement stmt = null;  // 쿼리를 DB로 보낼 객체 선언
        ResultSet rs = null;    // 쿼리(select)의 결과를 저장할 객체 선언
        int rcnt = 0;           // 현 메소드의 결과를 저장할 변수로 리턴할 값이기도 함

        try {
            stmt = conn.createStatement();
            String sql = "select count(*) cnt from t_schedule_info a, t_member_info b " + where;
            rs = stmt.executeQuery(sql);
            if (rs.next())  rcnt = rs.getInt("cnt");

        } catch(Exception e) {
            System.out.println("AdminScheduleListDao 클래스의 getSchListCount() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);  close(stmt);
        }
        
        return rcnt;
    }
}
