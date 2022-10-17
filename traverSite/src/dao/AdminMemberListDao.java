package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminMemberListDao {
    private static AdminMemberListDao adminMemberListDao; 
    private Connection conn;
    private AdminMemberListDao() {}
    
    public static AdminMemberListDao getInstance() {
        if (adminMemberListDao == null) {
            adminMemberListDao = new AdminMemberListDao();
        }
        return adminMemberListDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<MemberInfo> getAdminMemberList(String where, int cpage, int psize) {
        Statement stmt = null;
        ResultSet rs = null;
        ArrayList<MemberInfo> memberInfo = new ArrayList<MemberInfo>(); 
        MemberInfo mi = null;
    
        try {
            stmt = conn.createStatement();
            String sql = "select mi_id, mi_nickname, mi_name, mi_mail, mi_status, mi_join " + 
                    " from t_member_info " + where + " order by mi_id desc " + 
                    " limit " + ((cpage -1) * psize) + ", " + psize;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                mi = new MemberInfo();
                mi.setMi_id(rs.getString("mi_id"));
                mi.setMi_nickname(rs.getString("mi_nickname"));
                mi.setMi_name(rs.getString("mi_name"));
                mi.setMi_mail(rs.getString("mi_mail"));
                mi.setMi_status(rs.getString("mi_status"));
                mi.setMi_join(rs.getString("mi_join"));
                memberInfo.add(mi);
            }

        } catch (Exception e) {
            System.out.println("AdminMemberListDao 클래스의 getAdminMemberList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);
            close(stmt);
        }
        
        return memberInfo;
    }

    public int getMemberListCount(String where) {
        Statement stmt = null;  // 쿼리를 DB로 보낼 객체 선언
        ResultSet rs = null;    // 쿼리(select)의 결과를 저장할 객체 선언
        int rcnt = 0;           // 현 메소드의 결과를 저장할 변수로 리턴할 값이기도 함

        try {
            stmt = conn.createStatement();
            String sql = "select count(*) cnt from t_member_info " + where;
            rs = stmt.executeQuery(sql);
            if (rs.next())  rcnt = rs.getInt("cnt");

        } catch(Exception e) {
            System.out.println("AdminMemberListDao 클래스의 getMemberListCount() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);  close(stmt);
        }

        return rcnt;
    }
}
