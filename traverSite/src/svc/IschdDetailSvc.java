package svc;

import static db.JdbcUtil.*;
import java.util.*; 
import java.sql.*;
import dao.*;
import vo.*;

public class IschdDetailSvc {
    public GoodInfo getIschdDetail(String miid, String giid) {
        GoodInfo gi = null;
        Connection conn = getConnection();
        IschdDao ischdDao = IschdDao.getInstance();
        ischdDao.setConnection(conn);
        
        gi = ischdDao.getIschdDetail(miid, giid);
        close(conn);
        
        return gi;
    }

    public GoodPost getGoodPost(String giid) {
        GoodPost goodPost = new GoodPost();
        Connection conn = getConnection();
        IschdDao ischdDao = IschdDao.getInstance();
        ischdDao.setConnection(conn);
        
        goodPost = ischdDao.getGoodPost(giid);
        close(conn);
        
        return goodPost;
    }

}
