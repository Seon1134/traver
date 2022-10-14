package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;


public class PostMainSvc {
    public ArrayList<GoodPost> getMBTIPostList(String mbti) {
        ArrayList<GoodPost>  mbtiPostList = new ArrayList<GoodPost>();
        Connection conn = getConnection();
        PostMainDao postMainDao = PostMainDao.getInstance();
        postMainDao.setConnection(conn);
        
        mbtiPostList = postMainDao.getMBTIPostList(mbti);
        close(conn);
        
        return mbtiPostList;
    }

    public ArrayList<GoodPost> getPopPostList() {
        ArrayList<GoodPost>  popPostList = new ArrayList<GoodPost>();
        Connection conn = getConnection();
        PostMainDao postMainDao = PostMainDao.getInstance();
        postMainDao.setConnection(conn);
        
        popPostList = postMainDao.getPopPostList();
        close(conn);
        
        return popPostList;
    }
}
