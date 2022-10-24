package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import java.time.LocalDate;

import vo.*;

public class PostProcInDao {

    private static PostProcInDao postProcInDao;
    private Connection conn;
    private PostProcInDao() {}

    public static PostProcInDao getInstance() {
        if (postProcInDao == null)   postProcInDao = new PostProcInDao();
        return postProcInDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }
    
    public String getGiid() {   // 새로운 추천 일정 아이디
            Statement stmt = null;
            ResultSet rs = null;
            String gi_id = null;

            try {
                stmt = conn.createStatement();

                String sql = "select right(gi_id, 4) from t_good_info order by gi_date desc limit 0,1;";
                
                rs = stmt.executeQuery(sql);
                if (rs.next()) {    
                    int num = Integer.parseInt(rs.getString(1)) + 1;
                    gi_id = "GI" + num;
                } else {   
                    gi_id = "GI1001";
                }

            } catch(Exception e) {
                System.out.println("OrderDao 클래스의 getGiid() 메소드 오류");
                e.printStackTrace();
            } finally {
                close(rs);  close(stmt);
            }

            return gi_id;
        }
    
    public String getGpid() {   // 새로운 추천 일정 아이디
        Statement stmt = null;
        ResultSet rs = null;
        String gp_id = null;

        try {
            stmt = conn.createStatement();

            String sql = "select right(gp_id, 4) from t_good_post order by gp_date desc limit 0,1";
            
            rs = stmt.executeQuery(sql);
            if (rs.next()) {    
                int num = Integer.parseInt(rs.getString(1)) + 1;
                gp_id = "GP" + num;
            } else {   
                gp_id = "GP1001";
            }

        } catch(Exception e) {
            System.out.println("OrderDao 클래스의 getGpid() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);  close(stmt);
        }

        return gp_id;
    }
    

    public String goodInsert(String[] si, String[] sd) { // goodInfo와 goodDay에 insert
        Statement stmt = null; 
        ResultSet rs = null;
        String gi_id = getGiid();
        String gigd = "";
        
        try {
             stmt = conn.createStatement();
             String sql = "insert into t_good_info values " +
             "('" + gi_id + "', '" + si[0] + "', '" + si[1] + "', '" + si[2] + "', now() , '" + si[3] + "', '" + si[4] + "' )";
             gigd += gi_id + "/" ;
             stmt.executeUpdate(sql);
             
             for ( int i = 0; i < sd.length / 6; i++ ) { 
                 sql = "insert into t_good_day (gi_id, pi_id, gd_dnum, gd_seq, gd_name, gd_coords, gd_date) values " +
                 "('" + gi_id + "', '" + sd[6 * i] + "', '" + sd[6 * i + 1] + 
                 "', '" + sd[ 6 * i + 2] + "', '" + sd[ 6 * i + 3]+ "', '" + sd[ 6 * i + 4] + "', '" + sd[ 6 * i + 5] + "')";
                 stmt.executeUpdate(sql);
             }
             
             sql = "select gd_id from t_good_day where gi_id = '" + gi_id + "'";
             rs = stmt.executeQuery(sql);
             while(rs.next()) {
                 gigd += rs.getString("gd_id") + ",";
             }
           
             
        } catch (Exception e) {
             System.out.println("PostProcInDao 클래스의 goodInsert() 메소드 오류");
             e.printStackTrace();
          } finally {
             close(rs); close(stmt);
          }
        
        return gigd;
        
    }

    public String goodPostInsert(GoodPost goodPost) {
        Statement stmt = null; 
        String gpgi = "";
        String gp_id = getGpid();
        
        try {
            stmt = conn.createStatement();
            String sql = "insert into t_good_post values ('" + gp_id + "', '" 
            + goodPost.getGi_id() + "', '" + goodPost.getMi_id() + "', '"
            + goodPost.getMi_nickname() + "', '" + goodPost.getGp_mbti() + "', '" 
            + goodPost.getGp_title() + "', '" + goodPost.getGp_list() + "', '" 
            + goodPost.getGp_content() + "', '" + goodPost.getGp_img() + "', 0, now(), null, '" 
            + goodPost.getGp_ip() + "')"; 
            stmt.executeUpdate(sql);
            gpgi = gp_id + "," + goodPost.getGi_id();
            
          
       } catch (Exception e) {
            System.out.println("PostProcInDao 클래스의 goodPostInsert() 메소드 오류");
            e.printStackTrace();
         } finally {
            close(stmt);
         }
        
        return gpgi;
    }
}
