package svc;

import static db.JdbcUtil.*;
import java.util.*; 
import java.sql.*;
import dao.*;
import vo.*;

public class MschdDetailSvc {
    public ScheduleInfo getMschdDetail(String miid, String siid) {
        ScheduleInfo si = null;
        Connection conn = getConnection();
        MschdDao mschdDao = MschdDao.getInstance();
        mschdDao.setConnection(conn);
        
        si = mschdDao.getMschdDetail(miid, siid);
        close(conn);
        
        return si;
    }

}
