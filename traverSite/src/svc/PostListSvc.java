package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PostListSvc {
    public ArrayList<GoodPost> getPostList(String where, String orderby) {
        ArrayList<GoodPost>  postList = new ArrayList<GoodPost>();
        Connection conn = getConnection();
        PostListDao postListDao = PostListDao.getInstance();
        postListDao.setConnection(conn);
        
        postList = postListDao.getPostList(where, orderby);
        close(conn);
        
        return postList;
    }
}
