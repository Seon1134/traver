package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminBbsContentsListDao {
    private static AdminBbsContentsListDao adminBbsContentsListDao; 
    private Connection conn;
    private AdminBbsContentsListDao() {}
    
    public static AdminBbsContentsListDao getInstance() {
        if (adminBbsContentsListDao == null) {
            adminBbsContentsListDao = new AdminBbsContentsListDao();
        }
        return adminBbsContentsListDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<GoodPost> getAdminBbsContentsList(String where, int cpage, int psize) {
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<GoodPost> adminGoodPost = new ArrayList<GoodPost>(); 
        GoodPost gp = null;
    
        try {
            stmt = conn.createStatement();
            String sql = "select gp_id, mi_nickname, mi_id, gp_mbti, gp_date, gp_ip, gp_gcnt " + 
                    " from t_good_post " + where + " order by gp_date desc " + 
                    " limit " + ((cpage -1) * psize) + ", " + psize;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                gp = new GoodPost();
                gp.setGp_id(rs.getString("gp_id"));
                gp.setMi_nickname(rs.getString("mi_nickname"));
                gp.setMi_id(rs.getString("mi_id"));
                gp.setGp_mbti(rs.getString("gp_mbti"));
                gp.setGp_date(rs.getString("gp_date"));
                gp.setGp_ip(rs.getString("gp_ip"));
                gp.setGp_gcnt(rs.getInt("gp_gcnt"));
                adminGoodPost.add(gp);
            }

        } catch (Exception e) {
            System.out.println("AdminBbsContentsListDao 클래스의 getAdminBbsContentsList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);
            close(stmt);
        }
        
        return adminGoodPost;
    }

    public int getBbsConListCount(String where) {
        Statement stmt = null;  // 쿼리를 DB로 보낼 객체 선언
        ResultSet rs = null;    // 쿼리(select)의 결과를 저장할 객체 선언
        int rcnt = 0;           // 현 메소드의 결과를 저장할 변수로 리턴할 값이기도 함

        try {
            stmt = conn.createStatement();
            String sql = "select count(*) cnt from t_good_post " + where;
            rs = stmt.executeQuery(sql);
            if (rs.next())  rcnt = rs.getInt("cnt");

        } catch(Exception e) {
            System.out.println("AdminBbsContentsListDao 클래스의 getBbsConListCount() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);  close(stmt);
        }

        return rcnt;
    }
}
