package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class PostViewDao {
    private static PostViewDao postViewDao;
    private Connection conn;
    private PostViewDao() {}
    
    public static PostViewDao getInstance() {
        if (postViewDao == null)   postViewDao = new PostViewDao();
        return postViewDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public GoodPost getGoodPost(String gpid) {
        Statement stmt = null;
        ResultSet rs = null;
        GoodPost goodPost = new GoodPost();   
        
        try {
             stmt = conn.createStatement();
             String sql = "select * from t_good_post where gp_id = '" + gpid + "'";
             rs = stmt.executeQuery(sql);
             while (rs.next()) {
                 goodPost.setGp_id(rs.getString("gp_id"));
                 goodPost.setGi_id(rs.getString("gi_id"));
                 goodPost.setMi_id(rs.getString("mi_id"));
                 goodPost.setMi_nickname(rs.getString("mi_nickname"));
                 goodPost.setGp_mbti(rs.getString("gp_mbti"));
                 goodPost.setGp_title(rs.getString("gp_title"));
                 goodPost.setGp_list(rs.getString("gp_list"));
                 goodPost.setGp_content(rs.getString("gp_content"));
                 goodPost.setGp_img(rs.getString("gp_img"));
                 goodPost.setGp_gcnt(rs.getInt("gp_gcnt"));
                 goodPost.setGp_date(rs.getString("gp_date"));
                 goodPost.setGp_last(rs.getString("gp_last"));
                 goodPost.setGp_ip(rs.getString("gp_ip"));
             }
        } catch (Exception e) {
             System.out.println("PostViewDao 클래스의 getGoodPost() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return goodPost;
    }

    public int gcntUpdate(String gpid, String miid) {
        Statement stmt = null;
        int result = 0;
        
        try {
             stmt = conn.createStatement();
             String sql = "insert into t_review_good (gp_id, mi_id, rg_date) values ('" + gpid + "', '" + miid + "', now())";
             result = stmt.executeUpdate(sql);
             if (result > 0) {
                 sql = "update t_good_post set gp_gcnt = gp_gcnt + 1 where gp_id = '" + gpid + "'";
                 result = stmt.executeUpdate(sql);
             }
        } catch (Exception e) {
             System.out.println("PostViewDao 클래스의 gcntUpdate() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(stmt);
          }
        
        return result;
    }

    public int isGood(String gpid, String miid) {
        Statement stmt = null;
        int isGood = 0;
        ResultSet rs = null;
        
        try {
             stmt = conn.createStatement();
             String sql = "select count(*) from t_review_good where mi_id = '" + miid + "' and gp_id='" + gpid + "'";
             rs = stmt.executeQuery(sql);
             
             rs.next();
             isGood = rs.getInt(1);
             
        } catch (Exception e) {
             System.out.println("PostViewDao 클래스의 isGood() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return isGood;
    }
    
    public int goodUpdate(String giid, String miid) {
        Statement stmt = null;
        int result = 0;
        
        try {
             stmt = conn.createStatement();
             String sql = "insert into t_schedule_zzim (gi_id, mi_id) values ('" + giid + "', '" + miid + "')";
             result = stmt.executeUpdate(sql);
        } catch (Exception e) {
             System.out.println("PostViewDao 클래스의 gcntUpdate() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(stmt);
          }
        
        return result;
    }
    

    public int isInterest(String giid, String miid) {
        Statement stmt = null;
        int isInterest = 0;
        ResultSet rs = null;
        
        try {
             stmt = conn.createStatement();
             String sql = "select count(*) from t_schedule_zzim where mi_id = '" + miid + "' and gi_id='" + giid + "'";
             rs = stmt.executeQuery(sql);
             
             rs.next();
             isInterest = rs.getInt(1);
             
        } catch (Exception e) {
             System.out.println("PostViewDao 클래스의 isInterest() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return isInterest;
    }
    
    public GoodInfo getGoodInfo(String gi) {
        Statement stmt = null; 
        ResultSet rs = null;
        GoodInfo goodInfo = new GoodInfo();
        
        try {
             stmt = conn.createStatement();
             String sql = "select * from t_good_info where gi_id = '" + gi + "'";
             rs = stmt.executeQuery(sql);
             
             while(rs.next()) {
                 goodInfo.setGi_id(rs.getString("gi_id"));
                 goodInfo.setMi_id(rs.getString("mi_id"));
                 goodInfo.setGi_nickname(rs.getString("gi_nickname"));
                 goodInfo.setGi_dnum(rs.getInt("gi_dnum"));
                 goodInfo.setGi_date(rs.getString("gi_date"));
                 goodInfo.setGi_name(rs.getString("gi_name"));
                 goodInfo.setGi_img (rs.getString("gi_img"));
             }
           
        } catch (Exception e) {
             System.out.println("PostViewDao 클래스의 getGoodInfo() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs); close(stmt);
          }
        
        return goodInfo;
    }

    public ArrayList<GoodDay> getFullGoodDayList(String giid) {
        Statement stmt = null; 
        ResultSet rs = null;
        ArrayList<GoodDay> fullGoodDayList = new ArrayList<GoodDay>();
        GoodDay gd = null;
        
        try {
             stmt = conn.createStatement();
             String sql = "select * from t_good_day where gi_id = '" + giid + "'";
             rs = stmt.executeQuery(sql);
                 
             while(rs.next()) {
                 gd = new GoodDay();
                 gd.setGi_id(rs.getString("gi_id"));
                 gd.setPi_id(rs.getInt("pi_id"));
                 gd.setGd_dnum(rs.getInt("gd_dnum"));
                 gd.setGd_seq(rs.getInt("gd_seq"));
                 gd.setGd_name(rs.getString("gd_name"));
                 gd.setGd_coords(rs.getString("gd_coords"));
                 gd.setGd_date(rs.getString("gd_date"));
                 fullGoodDayList.add(gd);
             }
           
        } catch (Exception e) {
             System.out.println("PostViewDao 클래스의 getGoodDayList() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs); close(stmt);
          }
        
        return fullGoodDayList;
    }
    
    public ArrayList<GoodDay> getGoodDayList(String giid, String day) {
        Statement stmt = null; 
        ResultSet rs = null;
        ArrayList<GoodDay> goodDayList = new ArrayList<GoodDay>();
        GoodDay gd = null;
        
        try {
             stmt = conn.createStatement();
             String sql = "select * from t_good_day where gi_id = '" + giid + "' and gd_dnum = '" + day + "'";
             rs = stmt.executeQuery(sql);
                 
             while(rs.next()) {
                 gd = new GoodDay();
                 gd.setGi_id(rs.getString("gi_id"));
                 gd.setPi_id(rs.getInt("pi_id"));
                 gd.setGd_dnum(rs.getInt("gd_dnum"));
                 gd.setGd_seq(rs.getInt("gd_seq"));
                 gd.setGd_name(rs.getString("gd_name"));
                 gd.setGd_coords(rs.getString("gd_coords"));
                 gd.setGd_date(rs.getString("gd_date"));
                 goodDayList.add(gd);
             }
           
        } catch (Exception e) {
             System.out.println("PostViewDao 클래스의 getGoodDayList() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs); close(stmt);
          }
        
        return goodDayList;
    }
}
