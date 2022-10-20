package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminBbsReviewListSvc {
    public ArrayList<AdminReviewList> getAdminBbsReviewList(String where, int cpage, int psize) {
        ArrayList<AdminReviewList> adminReviewList = new ArrayList<AdminReviewList>();
        Connection conn = getConnection();
        AdminBbsReviewListDao adminBbsReviewListDao = AdminBbsReviewListDao.getInstance();
        adminBbsReviewListDao.setConnection(conn);
        
        adminReviewList = adminBbsReviewListDao.getAdminBbsReviewList(where, cpage, psize);
        close(conn);
        
        return adminReviewList;
    }

    public int getBbsReVListCount(String where) {
        int rcnt = 0;
        Connection conn = getConnection();
        AdminBbsReviewListDao adminBbsReviewListDao = AdminBbsReviewListDao.getInstance();
        adminBbsReviewListDao.setConnection(conn);

        rcnt = adminBbsReviewListDao.getBbsReVListCount(where);
        close(conn);
        
        return rcnt;
    }
}
