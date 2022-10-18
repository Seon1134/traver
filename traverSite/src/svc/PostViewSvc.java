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

    public void gcntUpdate(String gpid, String miid) {
        int result = 0;
        Connection conn = getConnection();
        PostViewDao postViewDao = PostViewDao.getInstance();
        postViewDao.setConnection(conn);
        
        result = postViewDao.gcntUpdate(gpid, miid);
        if (result > 0) commit(conn);
        else            rollback(conn);
        close(conn);
    }

    public boolean isGood(String gpid, String miid) {
        int result = 0;
        boolean result1 = false;
        Connection conn = getConnection();
        PostViewDao postViewDao = PostViewDao.getInstance();
        postViewDao.setConnection(conn);
        
        result = postViewDao.isGood(gpid, miid);
        if (result > 0) result1 = true;

        close(conn);
        
        return result1;
    }
    
    public void goodUpdate(String giid, String miid) {
        int result = 0;
        Connection conn = getConnection();
        PostViewDao postViewDao = PostViewDao.getInstance();
        postViewDao.setConnection(conn);
        
        result = postViewDao.goodUpdate(giid, miid);
        if (result > 0) commit(conn);
        else            rollback(conn);
        close(conn);
    }

    public boolean isInterest(String giid, String miid) {
        int result = 0;
        boolean result1 = false;
        Connection conn = getConnection();
        PostViewDao postViewDao = PostViewDao.getInstance();
        postViewDao.setConnection(conn);
        
        result = postViewDao.isInterest(giid, miid);
        if (result > 0) result1 = true;
        
        close(conn);
        
        return result1;
    }

    public GoodInfo getGoodInfo(String gi) {
        Connection conn = getConnection();
        GoodInfo goodInfo = null;
        PostViewDao postViewDao = PostViewDao.getInstance();
        postViewDao.setConnection(conn);
        
        goodInfo = postViewDao.getGoodInfo(gi);
        close(conn);
        
        return goodInfo;
    }

    public ArrayList<GoodDay> getGoodDayList(String gi) {
        Connection conn = getConnection();
        ArrayList<GoodDay> goodDayList = null;
        PostViewDao postViewDao = PostViewDao.getInstance();
        postViewDao.setConnection(conn);
        
        goodDayList = postViewDao.getGoodDayList(gi);
        close(conn);
        
        return goodDayList;
    }
}
