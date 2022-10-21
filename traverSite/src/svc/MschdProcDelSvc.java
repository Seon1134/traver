package svc;

import static db.JdbcUtil.*;
import java.util.*; 
import java.sql.*;
import dao.*;
import vo.*;

public class MschdProcDelSvc {
    public int mschdDelete(String where) {
        int result = 0;
        Connection conn = getConnection();
        MschdDao mschdDao = MschdDao.getInstance();
        mschdDao.setConnection(conn);
        
        result = mschdDao.mschdDelete(where); 
        if (result >= 1)    commit(conn);   
        else                rollback(conn);
        close(conn);
        
        return result;
    }

}
