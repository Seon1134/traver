package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class PostFormInDao {
    private static PostFormInDao postFormInDao;
    private Connection conn;
    private PostFormInDao() {}
    
    public static PostFormInDao getInstance() {
        if (postFormInDao == null)   postFormInDao = new PostFormInDao();
        return postFormInDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<ScheduleInfo> getScheduleList(String miid) {
        ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
        Statement stmt = null;
        ResultSet rs = null;
        ScheduleInfo si = null;   
        
        try {
             stmt = conn.createStatement();
             String sql = "select * from t_schedule_info where mi_id = '" + miid + "' and si_isTake = 'n' order by si_last desc";
             rs = stmt.executeQuery(sql);
             while (rs.next()) {
                 si = new ScheduleInfo(); 
                 si.setSi_id(rs.getString("si_id"));
                 si.setMi_id(rs.getString("mi_id"));
                 si.setSi_sdate(rs.getString("si_sdate"));
                 si.setSi_edate(rs.getString("si_edate"));
                 si.setSi_dnum(rs.getInt("si_dnum"));
                 si.setSi_date(rs.getString("si_date"));
                 si.setSi_last(rs.getString("si_last"));
                 si.setSi_name(rs.getString("si_name"));
                 si.setSi_isTake(rs.getString("si_isTake"));
                 si.setSi_img(rs.getString("si_img"));
                 scheduleList.add(si);
             }
        } catch (Exception e) {
             System.out.println("PostFormInDao 클래스의 getScheduleList() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return scheduleList;
    }
}
