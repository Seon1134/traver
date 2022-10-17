package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PostFormInSvc {
    public ArrayList<ScheduleInfo> getScheduleList(String miid) {
        ArrayList<ScheduleInfo> scheduleList = new ArrayList<ScheduleInfo>();
        Connection conn = getConnection();
        PostFormInDao postFormInDao = PostFormInDao.getInstance();
        postFormInDao.setConnection(conn);
        
        scheduleList = postFormInDao.getScheduleList(miid);
        close(conn);
        
        return scheduleList;
    }
}
