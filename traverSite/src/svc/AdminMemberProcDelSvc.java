package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;


public class AdminMemberProcDelSvc {
    public int adminMemberProcDel(String where) {
        int result = 0;
        Connection conn = getConnection();
        AdminMemberProcDelDao adminMemberProcDelDao = AdminMemberProcDelDao.getInstance();
        adminMemberProcDelDao.setConnection(conn);

        result = adminMemberProcDelDao.adminMemberProcDel(where);
        if (result >= 1) {
            commit(conn);   // 여러 상품 삭제시에는 result가 1이상일 수 있음
        } else {
            rollback(conn);
        }
        close(conn);
        return result;
    }
}
