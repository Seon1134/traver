package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PostProcInSvc {
    public String goodInsert(String[] si, String[] sd) {
        Connection conn = getConnection();
        PostProcInDao postProcInDao = PostProcInDao.getInstance();
        postProcInDao.setConnection(conn);
        
        String gigd = postProcInDao.goodInsert(si, sd);
        if (gigd.contains(","))     commit(conn);
        else                        rollback(conn);
        close(conn);
        
        return gigd;
    }

    public String goodPostInsert(GoodPost goodPost) {
        Connection conn = getConnection();
        PostProcInDao postProcInDao = PostProcInDao.getInstance();
        postProcInDao.setConnection(conn);
        String gpgi = "";
        
        gpgi = postProcInDao.goodPostInsert(goodPost);
        if (gpgi.contains(","))     commit(conn);
        else                rollback(conn);
        close(conn);
        
        return gpgi;
    }
}
