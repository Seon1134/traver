package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MschdListDao {
    private static MschdListDao mschdListDao; 
    private Connection conn;
    private MschdListDao() {}
    
    public static MschdListDao getInstance() {
        if (mschdListDao == null)    mschdListDao = new MschdListDao();
        return mschdListDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<ScheduleInfo> getMschdList(String where) {
    // 일정의 목록을 구하여 ArrayList<ScheduleInfo>로 리턴하는 메소드
        Statement stmt = null;
        ResultSet rs = null;    
        ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
        // 일정들을 저장할 목록 객체
        ScheduleInfo si = null;
        // scheduleList에 저장할 하나의  일정 정보를 담을 인스턴스
        
        try {   
            stmt = conn.createStatement();
            String sql = "select mi_id, si_id, si_sdate, si_edate, si_dnum, si_date, si_name, si_img from t_schedule_info "
            + where + " order by si_date desc ";
            // System.out.println(sql);
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                si = new ScheduleInfo();    // 하나의 일정을 저장할 인스턴스 생성
                si.setMi_id(rs.getString("mi_id"));
                si.setSi_id(rs.getString("si_id"));
                si.setSi_sdate(rs.getString("si_sdate"));
                si.setSi_edate(rs.getString("si_edate"));
                si.setSi_dnum(rs.getInt("si_dnum"));
                si.setSi_date(rs.getString("si_date"));
                si.setSi_name(rs.getString("si_name"));
                si.setSi_img(rs.getString("si_img"));
                scheduleList.add(si);
                // 루프를 돌면서 rs에 들어있는 일정 정보들을 scheduleList에 저장 
            }
            
        } catch(Exception e) {
            System.out.println("MschdListDao 클래스의 getMschdList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
        
        return scheduleList;

    }
}
