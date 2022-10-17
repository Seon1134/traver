package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class PostProcDelDao {
    private static PostProcDelDao postProcDelDao;
    private Connection conn;
    private PostProcDelDao() {}

    public static PostProcDelDao getInstance() {
        if (postProcDelDao == null) postProcDelDao = new PostProcDelDao();
        return postProcDelDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public int postDelete(String gpid) {
        Statement stmt = null;
        int result = 0;

        try {
            stmt = conn.createStatement();
            String sql = "delete from t_good_post where gp_id = '" + gpid + "'";
            System.out.println(sql);
            result = stmt.executeUpdate(sql);

        } catch(Exception e) {
            System.out.println("PostProcDelDao 클래스의 postDelete() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }

        return result;
    }
}
