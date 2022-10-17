package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminMemberFormUpDao {
    private static AdminMemberFormUpDao adminMemberFormUpDao;
    private Connection conn;
    private AdminMemberFormUpDao() {}

    public static AdminMemberFormUpDao getInstance() {
        if (adminMemberFormUpDao == null)  adminMemberFormUpDao = new AdminMemberFormUpDao();
        return adminMemberFormUpDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public MemberInfo getAdminMemberFormUp(String miid) {
        Statement stmt = null;
        ResultSet rs = null;
        MemberInfo memberInfo = null;
        try {
            stmt = conn.createStatement();
            String sql = "select * from t_member_info where mi_id = '" + miid +"' ";
            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            if (rs.next()) {
                memberInfo = new MemberInfo();
                memberInfo.setMi_name(rs.getString("mi_name"));
                memberInfo.setMi_nickname(rs.getString("mi_nickname"));
                memberInfo.setMi_mail(rs.getString("mi_mail"));
                memberInfo.setMi_pw(rs.getString("mi_pw"));
                memberInfo.setMi_birth(rs.getString("mi_birth"));
                memberInfo.setMi_mbti(rs.getString("mi_mbti"));
                memberInfo.setMi_join(rs.getString("mi_join"));
                memberInfo.setMi_status(rs.getString("mi_status"));
                memberInfo.setMi_id(miid);
            }
            System.out.println(sql + 1);
            
        } catch(Exception e) {
            System.out.println("AdminMemberFormUpDao 클래스의 getAdminMemberFormUp() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);  
            close(stmt);
        }
        
        return memberInfo;
    }
}
