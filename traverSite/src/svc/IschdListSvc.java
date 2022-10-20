package svc;

import static db.JdbcUtil.*;
import java.util.*; 
import java.sql.*;
import dao.*;
import vo.*;

public class IschdListSvc {
    public ArrayList<GoodInfo> getIschdList(String where, String orderBy) {
        ArrayList<GoodInfo> goodList = new ArrayList<GoodInfo>();
        Connection conn = getConnection();
        IschdDao ischdDao = IschdDao.getInstance();
        ischdDao.setConnection(conn);
        
        goodList = ischdDao.getIschdList(where, orderBy);
        close(conn);
        
        return goodList;
        
    }

}
