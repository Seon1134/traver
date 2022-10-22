package svc;

import static db.JdbcUtil.*;
import java.util.*; 
import java.sql.*;
import dao.*;
import vo.*;

public class IschdProcDelSvc {
    public int ischdDelete(String where) {
        int result = 0;
        Connection conn = getConnection();
        IschdDao ischdDao = IschdDao.getInstance();
        ischdDao.setConnection(conn);
        
        result = ischdDao.ischdDelete(where); 
        if (result >= 1)    commit(conn);   
        else                rollback(conn);
        close(conn);
        
        return result;
    }
}
