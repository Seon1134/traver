package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PostFormInSvc {
    public ArrayList<ScheduleInfo> getScheduleList(String miid) {
        ArrayList<ScheduleInfo> scheduleInfoList = new ArrayList<ScheduleInfo>();
        Connection conn = getConnection();
        PostFormInDao postFormInDao = PostFormInDao.getInstance();
        postFormInDao.setConnection(conn);
        
        scheduleInfoList = postFormInDao.getScheduleList(miid);
        close(conn);
        
        return scheduleInfoList;
    }

    public ArrayList<ScheduleDay> getScheduleDayList(String siid) {
        ArrayList<ScheduleDay> scheduleDayList = new ArrayList<ScheduleDay>();
        Connection conn = getConnection();
        PostFormInDao postFormInDao = PostFormInDao.getInstance();
        postFormInDao.setConnection(conn);
        
        scheduleDayList = postFormInDao.getScheduleDayList(siid);
        close(conn);
        
        return scheduleDayList;
    }
}
