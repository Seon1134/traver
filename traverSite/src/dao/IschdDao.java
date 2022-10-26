package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class IschdDao {
    private static IschdDao ischdDao; 
    private Connection conn;
    private IschdDao() {}
    
    public static IschdDao getInstance() {
        if (ischdDao == null)    ischdDao = new IschdDao();
        return ischdDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }
    
    public ArrayList<GoodInfo> getIschdList(String where, String orderBy) {
    // 관심일정의 목록을 구하여 ArrayList<GoodInfo>로 리턴하는 메소드
        Statement stmt = null;
        ResultSet rs = null;    
        ArrayList<GoodInfo> goodList = new ArrayList<GoodInfo>();
        // 관심일정들을 저장할 목록 객체
        GoodInfo gi = null;
        // goodList에 저장할 하나의  관심일정 정보를 담을 인스턴스
        
        try {   
            stmt = conn.createStatement();
            String sql = "select * from t_schedule_zzim a, t_good_info b "
            + where + orderBy;
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                gi = new GoodInfo();    // 하나의 관심일정을 저장할 인스턴스 생성
                gi.setGi_id(rs.getString("gi_id"));
                gi.setGi_dnum(rs.getInt("gi_dnum"));
                gi.setGi_date(rs.getString("gi_date"));
                gi.setGi_name(rs.getString("gi_name"));
                gi.setGi_img(rs.getString("gi_img"));
                goodList.add(gi);
                // 루프를 돌면서 rs에 들어있는 관심일정 정보들을 goodList에 저장 
            }
            
        } catch(Exception e) {
            System.out.println("IschdDao 클래스의 getIschdList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
        
        return goodList;
    }

    public GoodInfo getIschdDetail(String miid, String giid, String day) {
    // 받아온(지정한) 일정아이디에 해당하는 관심일정 디테일 정보들을 GoodInfo형 인스턴스로 저장하여 리턴하는 메소드
        Statement stmt = null;
        ResultSet rs = null;
        GoodInfo gi = null;
        
        try {
            String sql = "select * from t_good_info a, t_schedule_zzim b where b.mi_id = '" + miid + "' "
            + " and a.gi_id = b.gi_id and a.gi_id = '" + giid + "' ";
            
            stmt = conn.createStatement();
            //System.out.println(sql);
            rs = stmt.executeQuery(sql);
            if (rs.next()) { 
                gi = new GoodInfo();
                gi.setMi_id(miid);
                gi.setGi_id(giid);
                gi.setGi_nickname(rs.getString("gi_nickname"));
                gi.setGi_name(rs.getString("gi_name"));
                gi.setGi_dnum(rs.getInt("gi_dnum"));
                gi.setGoodDayList(getGoodDayList(giid, day)); // 현 관심일정의 일차 관련 목록을 ArrayList로 받아와 gi에 저장
            }
            
        } catch(Exception e) {
            System.out.println("IschdDao 클래스의 getIschdDetail() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
    
        return gi;
    }

    public ArrayList<GoodDay> getGoodDayList(String giid, String day) {
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<GoodDay> goodDayList = new ArrayList<GoodDay>();
        GoodDay gd = null;
        
        try {
            String sql = "select * from t_good_day a, t_schedule_zzim b where a.gi_id = b.gi_id and a.gi_id = '" + giid + "' and gd_dnum = '" + day + "'";
            
            stmt = conn.createStatement();
           // System.out.println(sql);
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {   // 하나의 관심일정에 해당하는 일차정보가 들어있는 rs
                gd = new GoodDay();
                gd.setGi_id(giid);
                gd.setGd_name(rs.getString("gd_name"));
                gd.setPi_id(rs.getInt("pi_id"));
                gd.setGd_dnum(rs.getInt("gd_dnum"));
                gd.setGd_coords(rs.getString("gd_coords"));
                gd.setGd_seq(rs.getInt("gd_seq"));
                goodDayList.add(gd);
            }
            
        } catch(Exception e) {
            System.out.println("IschdDao 클래스의 getGoodDayList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
    
        return goodDayList;
    }

    public int ischdDelete(String where) {
    // 지정한 조건에 맞는 관심일정을 하나 삭제하는 메소드
        Statement stmt = null;      
        int result = 0;         
        
        try {   
            stmt = conn.createStatement();
            String sql = "delete from t_schedule_zzim " + where;
            
            //System.out.println(sql);
            result = stmt.executeUpdate(sql);
            
        } catch(Exception e) {
            System.out.println("IschdDao 클래스의 ischdDelete() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }
        
        return result;
    }

    public GoodPost getGoodPost(String giid) {
        Statement stmt = null;
        ResultSet rs = null;
        GoodPost goodPost = new GoodPost();   
        
        try {
             stmt = conn.createStatement();
             String sql = "select * from t_good_post a, t_good_info b where a.gi_id = b.gi_id and a.gi_id = '" + giid + "' ";
             //System.out.println(sql);
             rs = stmt.executeQuery(sql);
             while (rs.next()) {
                 goodPost.setGp_id(rs.getString("gp_id"));
                 goodPost.setMi_nickname(rs.getString("mi_nickname"));
             }
        } catch (Exception e) {
             System.out.println("IschdDao 클래스의 getGoodPost() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return goodPost;
    }

    public GoodInfo getFullIschdDetail(String miid, String giid) {
     // 받아온(지정한) 일정아이디에 해당하는 관심일정 디테일 정보들을 GoodInfo형 인스턴스로 저장하여 리턴하는 메소드
        Statement stmt = null;
        ResultSet rs = null;
        GoodInfo fullgi = null;
        
        try {
            String sql = "select * from t_good_info a, t_schedule_zzim b where b.mi_id = '" + miid + "' "
            + " and a.gi_id = b.gi_id and a.gi_id = '" + giid + "' ";
            
            stmt = conn.createStatement();
            //System.out.println(sql);
            rs = stmt.executeQuery(sql);
            if (rs.next()) { 
                fullgi = new GoodInfo();
                fullgi.setMi_id(miid);
                fullgi.setGi_id(giid);
                fullgi.setGi_nickname(rs.getString("gi_nickname"));
                fullgi.setGi_name(rs.getString("gi_name"));
                fullgi.setGi_dnum(rs.getInt("gi_dnum"));
                fullgi.setGoodDayList(getGoodDayList(giid)); // 현 관심일정의 일차 관련 목록을 ArrayList로 받아와 gi에 저장
            }
            
        } catch(Exception e) {
            System.out.println("IschdDao 클래스의 getIschdDetail() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
    
        return fullgi;
    }

    private ArrayList<GoodDay> getGoodDayList(String giid) {
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<GoodDay> goodDayList = new ArrayList<GoodDay>();
        GoodDay gd = null;
        
        try {
            String sql = "select * from t_good_day a, t_schedule_zzim b where a.gi_id = b.gi_id and a.gi_id = '" + giid + "'";
            
            stmt = conn.createStatement();
           // System.out.println(sql);
            
            rs = stmt.executeQuery(sql);
            while (rs.next()) {   // 하나의 관심일정에 해당하는 일차정보가 들어있는 rs
                gd = new GoodDay();
                gd.setGi_id(giid);
                gd.setGd_name(rs.getString("gd_name"));
                gd.setPi_id(rs.getInt("pi_id"));
                gd.setGd_dnum(rs.getInt("gd_dnum"));
                gd.setGd_coords(rs.getString("gd_coords"));
                gd.setGd_seq(rs.getInt("gd_seq"));
                goodDayList.add(gd);
            }
            
        } catch(Exception e) {
            System.out.println("IschdDao 클래스의 getGoodDayList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
    
        return goodDayList;
    }
}
