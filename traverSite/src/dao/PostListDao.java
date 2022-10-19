package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import vo.GoodPost;

public class PostListDao {
    private static PostListDao postListDao;
    private Connection conn;
    private PostListDao() {}
    
    public static PostListDao getInstance() {
        if (postListDao == null)   postListDao = new PostListDao();
        return postListDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<GoodPost> getPostList(String where, String orderby) {
        ArrayList<GoodPost> postList = new ArrayList<GoodPost>();
       
        Statement stmt = null;
        ResultSet rs = null;
        GoodPost gp = null;   
        
        try {
             stmt = conn.createStatement();
             String sql = "select * from t_good_post "+ where + orderby;
             rs = stmt.executeQuery(sql);
             while (rs.next()) {
                 gp = new GoodPost();
                 gp.setGp_id(rs.getString("gp_id"));
                 gp.setGi_id(rs.getString("gi_id"));
                 gp.setMi_id(rs.getString("mi_id"));
                 gp.setMi_nickname(rs.getString("mi_nickname"));
                 gp.setGp_mbti(rs.getString("gp_mbti"));
                 gp.setGp_title(rs.getString("gp_title"));
                 gp.setGp_content(rs.getString("gp_content"));
                 gp.setGp_gcnt(rs.getInt("gp_gcnt"));
                 gp.setGp_date(rs.getString("gp_date"));
                 gp.setGp_last(rs.getString("gp_last"));
                 gp.setGp_ip(rs.getString("gp_ip"));
                 postList.add(gp);
             }
        } catch (Exception e) {
             System.out.println("PostListDao 클래스의 getPostList() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return postList;
    }
}
