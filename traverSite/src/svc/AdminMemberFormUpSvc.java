package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminMemberFormUpSvc {
    public MemberInfo getAdminMemberFormUp(String miid) {
        MemberInfo memberInfo = null;
        Connection conn = getConnection();
        AdminMemberFormUpDao adminMemberFormUpDao = AdminMemberFormUpDao.getInstance();
        adminMemberFormUpDao.setConnection(conn);

        memberInfo = adminMemberFormUpDao.getAdminMemberFormUp(miid);
        close(conn);
        
        return memberInfo;
    }
}
