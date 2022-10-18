package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminScheduleListSvc {
    public ArrayList<AdminSchList> getAdminScheduleList(String where, int cpage, int psize) {
        ArrayList<AdminSchList> adminSchList = new ArrayList<AdminSchList>();
        Connection conn = getConnection();
        AdminScheduleListDao adminScheduleListDao = AdminScheduleListDao.getInstance();
        adminScheduleListDao.setConnection(conn);
        
        adminSchList = adminScheduleListDao.getAdminScheduleList(where, cpage, psize);
        close(conn);
        
        return adminSchList;
    }

    public int getSchListCount(String where) {
        int rcnt = 0;
        Connection conn = getConnection();
        AdminScheduleListDao adminScheduleListDao = AdminScheduleListDao.getInstance();
        adminScheduleListDao.setConnection(conn);

        rcnt = adminScheduleListDao.getSchListCount(where);
        close(conn);
        
        return 0;
    }
}
