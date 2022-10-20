package svc;

import static db.JdbcUtil.*;
import java.util.*; 
import java.sql.*;
import dao.*;
import vo.*;

public class MypageListSvc {

    public ArrayList<GoodPost> getGoodPostList(String miid) {
        ArrayList<GoodPost> goodPostList = null;
        Connection conn = getConnection();
        MypageListDao mypageListDao = MypageListDao.getInstance();
        mypageListDao.setConnection(conn);
        
        goodPostList = mypageListDao.getGoodPostList(miid);
        close(conn);
        
        return goodPostList;
    }

}
