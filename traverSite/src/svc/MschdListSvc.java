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
        MschdDao mschdDao = MschdDao.getInstance();
        mschdDao.setConnection(conn);
        
        scheduleList = mschdDao.getMschdList(where, orderBy);
        close(conn);
        
        return scheduleList;
        
    }

    public ArrayList<ScheduleInfo> getfullMschdList(String mi_id) {
        ArrayList<ScheduleInfo> fullScheduleList = new ArrayList<ScheduleInfo>();
        Connection conn = getConnection();
        MschdDao mschdDao = MschdDao.getInstance();
        mschdDao.setConnection(conn);
        
        fullScheduleList = mschdDao.getFullMschdList(mi_id);
        close(conn);
        
        return fullScheduleList;
    }
   
}
