package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminScheduleProcDelDao {
    private static AdminScheduleProcDelDao adminScheduleProcDelDao;
    private Connection conn;
    private AdminScheduleProcDelDao() {}

    public static AdminScheduleProcDelDao getInstance() {
        if (adminScheduleProcDelDao == null)    adminScheduleProcDelDao = new AdminScheduleProcDelDao();
        return adminScheduleProcDelDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public int adminScheduleProcDel(String where) {
        Statement stmt = null;
        int result = 0;
        
        try {
            stmt = conn.createStatement();
            String sql = "";
            result = stmt.executeUpdate(sql);
            
        } catch(Exception e) {
            System.out.println("AdminScheduleProcDelDao 클래스의 adminScheduleProcDel() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }
        
        return result;
    }
}
