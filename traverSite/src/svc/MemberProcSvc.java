package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberProcSvc { // traverSite
	public int memberProc(String kind, MemberInfo memberInfo) {
		Connection conn = getConnection();
		MemberProcDao memberProcDao = MemberProcDao.getInstance();
		memberProcDao.setConnection(conn);
		
		int result = 0;
		if (kind.equals("in")) {
			result = memberProcDao.memberInsert(memberInfo);
		} else if (kind.equals("up")) {
			result = memberProcDao.memberUpdate(memberInfo);
		} else if (kind.equals("del")) {
//			result = memberProcDao.memberDelete(memberInfo);
		} else if (kind.equals("mbti1") || kind.equals("mbti2") ) {
		    result = memberProcDao.mbtiUpdate(memberInfo);
		}
		
		if (result == 1)	commit(conn);
		else				rollback(conn);
		// 사용한 쿼리가 insert, update, delete 들이면 반드시 트랜잭션을 완료해야 함
		close(conn);

		return result;
	}
}
