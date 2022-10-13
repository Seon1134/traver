package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminPlaceProcUpSvc {
    public int AdminPlaceProcUp(PlaceInfo placeInfo) {
        int result = 0;
        Connection conn = getConnection();
        AdminPlaceProcUpDao adminPlaceProcUpDao = AdminPlaceProcUpDao.getInstance();
        adminPlaceProcUpDao.setConnection(conn);

        result = adminPlaceProcUpDao.AdminPlaceProcUp(placeInfo);
        if (result == 1)    commit(conn);
        else                rollback(conn);
        close(conn);

        return result;
    }
}
