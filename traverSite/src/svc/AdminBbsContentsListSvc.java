package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminBbsContentsListSvc {
    public ArrayList<GoodPost> getAdminBbsContentsList(String where, int cpage, int psize) {
        ArrayList<GoodPost> adminGoodPost = new ArrayList<GoodPost>();
        Connection conn = getConnection();
        AdminBbsContentsListDao adminBbsContentsListDao = AdminBbsContentsListDao.getInstance();
        adminBbsContentsListDao.setConnection(conn);
        
        adminGoodPost = adminBbsContentsListDao.getAdminBbsContentsList(where, cpage, psize);
        close(conn);
        
        return adminGoodPost;
    }

    public int getBbsConListCount(String where) {
        int rcnt = 0;
        Connection conn = getConnection();
        AdminBbsContentsListDao adminBbsContentsListDao = AdminBbsContentsListDao.getInstance();
        adminBbsContentsListDao.setConnection(conn);

        rcnt = adminBbsContentsListDao.getBbsConListCount(where);
        close(conn);
        
        return rcnt;
    }
}
