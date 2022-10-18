package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminMemberProcUpDao {
    private static AdminMemberProcUpDao adminMemberProcUpDao;
    private Connection conn;
    private AdminMemberProcUpDao() {}

    public static AdminMemberProcUpDao getInstance() {
        if (adminMemberProcUpDao == null)  adminMemberProcUpDao = new AdminMemberProcUpDao();
        return adminMemberProcUpDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public int AdminMemberProcUp(MemberInfo memberInfo) {
        Statement stmt = null;
        int result = 0;
        
        try {
            stmt = conn.createStatement();
            String sql = "Update t_member_info set " + 
            " mi_id =       '" + memberInfo.getMi_id()          + "', " + 
            " mi_name =     '" + memberInfo.getMi_name()        + "', " + 
            " mi_nickname = '" + memberInfo.getMi_nickname()    + "', " + 
            " mi_mail =     '" + memberInfo.getMi_mail()        + "', " + 
            " mi_pw =       '" + memberInfo.getMi_pw()          + "', " + 
            " mi_birth =    '" + memberInfo.getMi_birth()       + "', " + 
            " mi_mbti =     '" + memberInfo.getMi_mbti()        + "', " +
            " mi_status =   '" + memberInfo.getMi_status()      + "', " +
            " mi_join =     '" + memberInfo.getMi_join()        + "' " + 
            " where mi_id = '" + memberInfo.getMi_id()          + "'; ";
            result = stmt.executeUpdate(sql);
            
        } catch(Exception e) {
            System.out.println("AdminMemberProcUpDao 클래스의 AdminMemberProcUp() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }
        
        return result;
    }
}
