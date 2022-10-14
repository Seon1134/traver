package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PostViewSvc {
    public GoodPost getGoodPost(String gpid) {
        GoodPost goodPost = new GoodPost();
        Connection conn = getConnection();
        PostViewDao postViewDao = PostViewDao.getInstance();
        postViewDao.setConnection(conn);
        
        goodPost = postViewDao.getGoodPost(gpid);
        close(conn);
        
        return goodPost;
    }

    public int gcntUpdate(String gpid, String miid) {
        int result = 0;
        Connection conn = getConnection();
        PostViewDao postViewDao = PostViewDao.getInstance();
        postViewDao.setConnection(conn);
        
        result = postViewDao.gcntUpdate(gpid, miid);
        if (result > 0) commit(conn);
        else            rollback(conn);
        close(conn);
        
        return result;
    }

    public int isGood(String gpid, String miid) {
        int result = 0;
        Connection conn = getConnection();
        PostViewDao postViewDao = PostViewDao.getInstance();
        postViewDao.setConnection(conn);
        
        result = postViewDao.isGood(gpid, miid);
        if (result > 0) commit(conn);
        else            rollback(conn);
        close(conn);
        
        return result;
    }
}
