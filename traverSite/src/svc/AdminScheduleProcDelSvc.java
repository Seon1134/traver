package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminScheduleProcDelSvc {
    public int adminScheduleProcDel(String where) {
        int result = 0;
        Connection conn = getConnection();
        AdminScheduleProcDelDao adminScheduleProcDelDao = AdminScheduleProcDelDao.getInstance();
        adminScheduleProcDelDao.setConnection(conn);

        result = adminScheduleProcDelDao.adminScheduleProcDel(where);
        if (result >= 1) {
            commit(conn);   // 여러 상품 삭제시에는 result가 1이상일 수 있음
        } else {
            rollback(conn);
        }
        close(conn);
        
        return result;
    }
}
