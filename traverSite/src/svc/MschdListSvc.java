package svc;

import static db.JdbcUtil.*;
import java.util.*; 
import java.sql.*;
import dao.*;
import vo.*;

public class MschdListSvc {
   public ArrayList<ScheduleInfo> getMschdList(String where, String orderBy) {
        ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
        Connection conn = getConnection();
        MschdListDao mschdListDao = MschdListDao.getInstance();
        mschdListDao.setConnection(conn);
        
        scheduleList = mschdListDao.getMschdList(where, orderBy);
        close(conn);
        
        return scheduleList;
        
    }
}
