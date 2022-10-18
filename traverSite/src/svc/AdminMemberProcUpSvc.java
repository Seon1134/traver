package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminMemberProcUpSvc {
    public int AdminMemberProcUp(MemberInfo memberInfo) {
        int result = 0;
        Connection conn = getConnection();
        AdminMemberProcUpDao adminMemberProcUpDao = AdminMemberProcUpDao.getInstance();
        adminMemberProcUpDao.setConnection(conn);

        result = adminMemberProcUpDao.AdminMemberProcUp(memberInfo);
        if (result == 1)    commit(conn);
        else                rollback(conn);
        close(conn);
        
        return result;
    }
}
