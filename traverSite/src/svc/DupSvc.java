package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class DupSvc {
	public int chkDup(String kind, String input) {
		int result = 0;
		Connection conn = getConnection();
		DupDao dupDao = DupDao.getInstance();
		dupDao.setConnection(conn);
		result = dupDao.chkDup(kind, input);
		close(conn);

		return result;
	}

    public int chkPw(String id, String pw) {
        int result = 0;
        Connection conn = getConnection();
        DupDao dupDao = DupDao.getInstance();
        dupDao.setConnection(conn);
        result = dupDao.chkPw(id, pw);
        close(conn);

        return result;
    }
}
