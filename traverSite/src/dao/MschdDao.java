package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MschdDao {
    private static MschdDao mschdDao; 
    private Connection conn;
    private MschdDao() {}
    
    public static MschdDao getInstance() {
        if (mschdDao == null)    mschdDao = new MschdDao();
        return mschdDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }
    
   public ArrayList<ScheduleInfo> getMschdList(String where, String orderBy) {
    // 일정의 목록을 구하여 ArrayList<ScheduleInfo>로 리턴하는 메소드
        Statement stmt = null;
        ResultSet rs = null;    
        ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
        // 일정들을 저장할 목록 객체
        ScheduleInfo si = null;
        // scheduleList에 저장할 하나의  일정 정보를 담을 인스턴스
        
        try {   
            stmt = conn.createStatement();
            String sql = "select mi_id, si_id, left(si_sdate, 4) schYear, " 
            + "si_sdate, si_edate, si_dnum, si_date, si_name, si_img from t_schedule_info "
            + where + orderBy;
            //System.out.println(sql);
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                si = new ScheduleInfo();    // 하나의 일정을 저장할 인스턴스 생성
                si.setMi_id(rs.getString("mi_id"));
                si.setSi_id(rs.getString("si_id"));
                si.setSchYear(rs.getString("schYear"));
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
            System.out.println("MschdDao 클래스의 getMschdList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
        
        return scheduleList;
    }

    public ScheduleInfo getMschdDetail(String miid, String siid, String day) {
    // 받아온(지정한) 일정아이디에 해당하는 일정 디테일 정보들을 ScheduleInfo형 인스턴스로 저장하여 리턴하는 메소드
        Statement stmt = null;
        ResultSet rs = null;
        ScheduleInfo si = null;
        
        try {
            String sql = "select * from t_schedule_info where mi_id = '" + miid + "' and si_id = '" + siid + "'";
            
            stmt = conn.createStatement();
            //System.out.println(sql);
            rs = stmt.executeQuery(sql);
            if (rs.next()) { 
                si = new ScheduleInfo();
                si.setMi_id(miid);
                si.setSi_id(siid);
                si.setSi_name(rs.getString("si_name"));
                si.setSi_dnum(rs.getInt("si_dnum"));
                si.setSchdDayList(getSchdDayList(siid, day)); // 현 일정의 일차 관련 목록을 ArrayList로 받아와 si에 저장
            }
            
        } catch(Exception e) {
            System.out.println("MschdDao 클래스의 getMschdDetail() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
    
        return si;
    }
    
    public ArrayList<ScheduleDay> getSchdDayList(String siid, String day) {
    // 받아온(지정한) 일정아이디에 해당하는 일차 정보들을 ArrayList<ScheduleDay>형 인스턴스로 저장하여 리턴하는 메소드
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<ScheduleDay> schdDayList = new ArrayList<ScheduleDay>();
        ScheduleDay sd = null;
        
        try {
            String sql = "select * from t_schedule_day where si_id = '" + siid + "' and sd_dnum = '" + day + "'";
            stmt = conn.createStatement();
            
            //System.out.println(sql);
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {   // 하나의 일정에 해당하는 일차정보가 들어있는 rs
                sd = new ScheduleDay();
                sd.setSi_id(siid);
                sd.setSd_id(rs.getString("sd_id"));
                sd.setPi_name(rs.getString("pi_name"));
                sd.setPi_id(rs.getString("pi_id"));
                sd.setSd_dnum(rs.getInt("sd_dnum"));
                sd.setSd_coords(rs.getString("sd_coords"));
                sd.setSd_date(rs.getString("sd_date"));
                sd.setSd_seq(rs.getInt("sd_seq"));
                schdDayList.add(sd);
            }
            
        } catch(Exception e) {
            System.out.println("MschdDao 클래스의 getSchdDayList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
    
        return schdDayList;
    }

    public int mschdDelete(String where) {
    // 지정한 조건에 맞는 일정을 하나 삭제하는 메소드
        Statement stmt = null;      
        int result = 0;         
        
        try {   
            stmt = conn.createStatement();
            String sql = "delete from t_schedule_info " + where;
            
            System.out.println(sql);
            result = stmt.executeUpdate(sql);
            
        } catch(Exception e) {
            System.out.println("MschdDao 클래스의 mschdDelete() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }
        
        return result;
    }

    public ArrayList<ScheduleInfo> getFullMschdList(String mi_id) {
        Statement stmt = null;
        ResultSet rs = null;    
        ArrayList<ScheduleInfo> fullScheduleList = new ArrayList<ScheduleInfo>();
        ScheduleInfo si = null;
        
        try {   
            stmt = conn.createStatement();
            String sql = "select left(si_sdate, 4) schYear from t_schedule_info where mi_id = '" + mi_id + "' order by si_sdate asc";
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                si = new ScheduleInfo();    // 하나의 일정을 저장할 인스턴스 생성
                si.setSchYear(rs.getString("schYear"));
                fullScheduleList.add(si);
                // 루프를 돌면서 rs에 들어있는 일정 정보들을 scheduleList에 저장 
            }
            
        } catch(Exception e) {
            System.out.println("MschdDao 클래스의 getFullMschdList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
        
        return fullScheduleList;
    }

    public ScheduleInfo getFullmschdDetail(String miid, String siid) {
        Statement stmt = null;
        ResultSet rs = null;
        ScheduleInfo fullsi = null;
        
        try {
            String sql = "select * from t_schedule_info where mi_id = '" + miid + "' and si_id = '" + siid + "'";
            
            stmt = conn.createStatement();
            //System.out.println(sql);
            rs = stmt.executeQuery(sql);
            if (rs.next()) { 
                fullsi = new ScheduleInfo();
                fullsi.setMi_id(miid);
                fullsi.setSi_id(siid);
                fullsi.setSi_name(rs.getString("si_name"));
                fullsi.setSi_dnum(rs.getInt("si_dnum"));
                fullsi.setSchdDayList(getFullSchdDayList(siid)); // 현 일정의 일차 관련 목록을 ArrayList로 받아와 si에 저장
            }
            
        } catch(Exception e) {
            System.out.println("MschdDao 클래스의 getMschdDetail() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
    
        return fullsi;
    }

    private ArrayList<ScheduleDay> getFullSchdDayList(String siid) {
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<ScheduleDay> schdDayList = new ArrayList<ScheduleDay>();
        ScheduleDay sd = null;
        
        try {
            String sql = "select * from t_schedule_day where si_id = '" + siid + "'";
            stmt = conn.createStatement();
            
            //System.out.println(sql);
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {   // 하나의 일정에 해당하는 일차정보가 들어있는 rs
                sd = new ScheduleDay();
                sd.setSi_id(siid);
                sd.setSd_id(rs.getString("sd_id"));
                sd.setPi_name(rs.getString("pi_name"));
                sd.setPi_id(rs.getString("pi_id"));
                sd.setSd_dnum(rs.getInt("sd_dnum"));
                sd.setSd_coords(rs.getString("sd_coords"));
                sd.setSd_date(rs.getString("sd_date"));
                sd.setSd_seq(rs.getInt("sd_seq"));
                schdDayList.add(sd);
            }
            
        } catch(Exception e) {
            System.out.println("MschdDao 클래스의 getSchdDayList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
    
        return schdDayList;
    }
}
