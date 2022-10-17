package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PostProcDelSvc {
    public int postDelete(String gpid) {
        int result = 0;
        Connection conn = getConnection();
        PostProcDelDao postProcDelDao = PostProcDelDao.getInstance();
        postProcDelDao.setConnection(conn);

        result = postProcDelDao.postDelete(gpid);
        if (result == 1)    commit(conn);
        else                rollback(conn);
        close(conn);

        return result;
    }
}
