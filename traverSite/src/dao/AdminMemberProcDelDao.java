package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminMemberProcDelDao {
    private static AdminMemberProcDelDao adminMemberProcDelDao;
    private Connection conn;
    private AdminMemberProcDelDao() {}

    public static AdminMemberProcDelDao getInstance() {
        if (adminMemberProcDelDao == null)    adminMemberProcDelDao = new AdminMemberProcDelDao();
        return adminMemberProcDelDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public int adminMemberProcDel(String where) {
        Statement stmt = null;
        int result = 0;
        
        try {
            stmt = conn.createStatement();
            String sql = "update t_member_info set mi_status = 'c' " + where + " ";
            result = stmt.executeUpdate(sql);
            
        } catch(Exception e) {
            System.out.println("AdminMemberProcDelDao 클래스의 adminMemberProcDel() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }
        
        return result;
    }
}
