package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;


public class PostProcUpSvc {

    public void postUpdate(String title, String content, String gpid) {
        GoodPost goodPost = new GoodPost();
        Connection conn = getConnection();
        PostProcUpDao postProcUpDao = PostProcUpDao.getInstance();
        postProcUpDao.setConnection(conn);
        int result = 0;
        
        result = postProcUpDao.postUpdate(title, content, gpid);
        if ( result > 0 )   commit(conn);
        else                rollback(conn);
        close(conn);
       
    }
}
