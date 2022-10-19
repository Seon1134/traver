package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class PostProcUpDao {
    private static PostProcUpDao postProcUpDao;
    private Connection conn;
    private PostProcUpDao() {}
    
    public static PostProcUpDao getInstance() {
        if (postProcUpDao == null)   postProcUpDao = new PostProcUpDao();
        return postProcUpDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public int postUpdate(String title, String content, String gpid) {
        Statement stmt = null;
        int result = 0;

        try {
            stmt = conn.createStatement();
            String sql = "update t_good_post set gp_title = '" + title + "' , gp_content = '" + content + "' where gp_id = '" + gpid + "'";
            result = stmt.executeUpdate(sql);

        } catch(Exception e) {
            System.out.println("PostProcDelDao 클래스의 postUpdate() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }

        return result;
    }

}
