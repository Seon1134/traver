package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class PostMainDao {
    private static PostMainDao postMainDao;
    private Connection conn;
    private PostMainDao() {}
    
    public static PostMainDao getInstance() {
        if (postMainDao == null)   postMainDao = new PostMainDao();
        return postMainDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<GoodPost> getMBTIPostList(String mbti) { // 회원 MBTI의 좋아요가 높은 게시글
        ArrayList<GoodPost> mbtiPostList = new ArrayList<GoodPost>();
        
        Statement stmt = null;
        ResultSet rs = null;
        GoodPost gp = null;   
        
        try {
             stmt = conn.createStatement();
             String sql = "select * from t_good_post where gp_mbti = '" + mbti + 
                     "' order by gp_gcnt desc limit 10";
             rs = stmt.executeQuery(sql);
             while (rs.next()) {
                 gp = new GoodPost();
                 gp.setGp_id(rs.getString("gp_id"));
                 gp.setGi_id(rs.getString("gi_id"));
                 gp.setMi_id(rs.getString("mi_id"));
                 gp.setGp_mbti(rs.getString("gp_mbti"));
                 gp.setGp_title(rs.getString("gp_title"));
                 gp.setGp_content(rs.getString("gp_content"));
                 gp.setGp_gcnt(rs.getInt("gp_gcnt"));
                 gp.setGp_date(rs.getString("gp_date"));
                 gp.setGp_last(rs.getString("gp_last"));
                 gp.setGp_ip(rs.getString("gp_ip"));
                 mbtiPostList.add(gp);
             }
        } catch (Exception e) {
             System.out.println("PostMainDao 클래스의 getMBTIPostList() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return mbtiPostList;
    }

    public ArrayList<GoodPost> getPopPostList() { // MBTI 무관 인기 게시글
        ArrayList<GoodPost> popPostList = new ArrayList<GoodPost>();
        
        Statement stmt = null;
        ResultSet rs = null;
        GoodPost gp = null;   
        
        try {
             stmt = conn.createStatement();
             String sql = "select * from t_good_post order by gp_gcnt desc limit 10;";
             rs = stmt.executeQuery(sql);
             while (rs.next()) {
                gp = new GoodPost();
                gp.setGp_id(rs.getString("gp_id"));
                gp.setGi_id(rs.getString("gi_id"));
                gp.setMi_id(rs.getString("mi_id"));
                gp.setGp_mbti(rs.getString("gp_mbti"));
                gp.setGp_title(rs.getString("gp_title"));
                gp.setGp_content(rs.getString("gp_content"));
                gp.setGp_gcnt(rs.getInt("gp_gcnt"));
                gp.setGp_date(rs.getString("gp_date"));
                gp.setGp_last(rs.getString("gp_last"));
                gp.setGp_ip(rs.getString("gp_ip"));
                popPostList.add(gp);
             }
        } catch (Exception e) {
             System.out.println("PostMainDao 클래스의 getPopPostList() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return popPostList;
    }
}
