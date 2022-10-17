package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminMemberProcInDao {
    private static AdminMemberProcInDao adminMemberProcInDao; 
    private Connection conn;
    private AdminMemberProcInDao() {}
    
    public static AdminMemberProcInDao getInstance() {
        if (adminMemberProcInDao == null) {
            adminMemberProcInDao = new AdminMemberProcInDao();
        }
        return adminMemberProcInDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public int memberInsert(String id, String name, String nickname, String mail, String pw, String birth, String mbti) {
        PreparedStatement pstmt = null;
        int result = 0;
        
        try {
            String sql = "insert into t_member_info (mi_id, mi_name, mi_nickname, mi_mail, " + 
                 " mi_pw, mi_birth, mi_mbti) values (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, name);
            pstmt.setString(3, nickname);
            pstmt.setString(4, mail);
            pstmt.setString(5, pw);
            pstmt.setString(6, birth);
            pstmt.setString(7, mbti);
            result = pstmt.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("AdminMemberProcInDao 클래스의 memberInsert() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        
        return result;
    }
}
