package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MypageListDao {
    private static MypageListDao mypageListDao;
    private Connection conn;
    private MypageListDao() {}

    public static MypageListDao getInstance() {
        if (mypageListDao == null)   mypageListDao = new MypageListDao();
        return mypageListDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<GoodPost> getGoodPostList(String miid) {
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<GoodPost> goodPostList = new ArrayList<GoodPost>(); 
        GoodPost gp = null;   
        
        try {
             stmt = conn.createStatement();
             String sql = "select gp_id, gp_title, gi_id, mi_id from t_good_post where mi_id = '" + miid + "'";
             rs = stmt.executeQuery(sql);
             while (rs.next()) {
                gp = new GoodPost();
                gp.setGp_id(rs.getString("gp_id"));
                gp.setGp_title(rs.getString("gp_title"));
                gp.setGi_id(rs.getString("gi_id"));
                gp.setMi_id(rs.getString("mi_id"));
                
                goodPostList.add(gp);
             }
        } catch (Exception e) {
             System.out.println("MypageListDaos 클래스의 getGoodPostList() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs);
             close(stmt);
          }
        
        return goodPostList;
    }
}
