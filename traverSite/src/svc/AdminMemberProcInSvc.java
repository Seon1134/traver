package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminMemberProcInSvc {

    public int memberInsert(String id, String name, String nickname, String mail, String pw, String birth, String mbti) {
        int result = 0;
        Connection conn = getConnection();
        AdminMemberProcInDao adminMemberProcInDao = AdminMemberProcInDao.getInstance();
        adminMemberProcInDao.setConnection(conn);
        
        result = adminMemberProcInDao.memberInsert(id, name, nickname, mail, pw, birth, mbti);
        if (result > 0) {
            commit(conn);
        } else {
            rollback(conn);
        }
        close(conn);
        
        return result;
    }
}
