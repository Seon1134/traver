package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberProcDao { //traverSite
	private static MemberProcDao memberProcDao;
	private Connection conn;
	private MemberProcDao() {}
	
	public static MemberProcDao getInstance() {
		if (memberProcDao == null)	memberProcDao = new MemberProcDao();
		return memberProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int memberInsert(MemberInfo memberInfo) {
	// 사용자가 입력한 데이터들로 회원 가입을 하는 메소드
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			String sql = "insert into t_member_info values " + 
				"(?, ?, ?, ?, ?, ?, ?, now(), now(), 'a')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberInfo.getMi_id());
			pstmt.setString(2, memberInfo.getMi_nickname());
            pstmt.setString(3, memberInfo.getMi_pw());
			pstmt.setString(4, memberInfo.getMi_mbti());
			pstmt.setString(5, memberInfo.getMi_name());
			pstmt.setString(6, memberInfo.getMi_mail());
			pstmt.setString(7, memberInfo.getMi_birth());
			result = pstmt.executeUpdate();
			

		} catch(Exception e) {
			System.out.println("MemberProcDao 클래스의 memberInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int memberUpdate(MemberInfo memberInfo) {
	// 사용자가 입력한 데이터들로 회원 정보를 수정하는 메소드
		Statement stmt = null;
		int result = 0;

		try {
			String sql = "update t_member_info set " + 
				"mi_nickname = '"		+ memberInfo.getMi_nickname() + "', " + 
				"mi_mbti = '"		+ memberInfo.getMi_mbti()	+ "', " +
				"mi_mail = '"       + memberInfo.getMi_mail()   + "' " + 
				" where mi_id = '"	+ memberInfo.getMi_id()		+ "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);

		} catch(Exception e) {
			System.out.println("MemberProcDao 클래스의 memberUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}

		return result;
	}

    public int mbtiUpdate(MemberInfo memberInfo) {
        Statement stmt = null;
        int result = 0;

        try {
            String sql = "update t_member_info set mi_mbti = '" + memberInfo.getMi_mbti()  
            + "' where mi_id = '" + memberInfo.getMi_id() + "'";
            stmt = conn.createStatement();
            result = stmt.executeUpdate(sql);

        } catch(Exception e) {
            System.out.println("MemberProcDao 클래스의 mbtiUpdate() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }

        return result;
    }
}
