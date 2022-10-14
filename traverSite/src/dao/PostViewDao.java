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
                 goodPost.setGp_mbti(rs.getString("gp_mbti"));
                 goodPost.setGp_title(rs.getString("gp_title"));
                 goodPost.setGp_content(rs.getString("gp_content"));
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
             System.out.println(sql);
             result = stmt.executeUpdate(sql);
             if (result > 0) {
                 sql = "update t_good_post set gp_gcnt = gp_gcnt + 1 where gp_id = '" + gpid + "'";
                 System.out.println(sql);
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
             System.out.println(sql);
             rs = stmt.executeQuery(sql);
             
             rs.next();
             isGood = rs.getInt(1);
             
        } catch (Exception e) {
             System.out.println("PostViewDao 클래스의 gcntUpdate() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return isGood;
    }
}
