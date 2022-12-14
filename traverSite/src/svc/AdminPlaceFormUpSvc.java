package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminPlaceFormUpSvc {
    public PlaceInfo getAdminPlaceInfo(String piid) {
        PlaceInfo placeInfo = null;
        Connection conn = getConnection();
        AdminPlaceProcUpDao adminPlaceProcUpDao = AdminPlaceProcUpDao.getInstance();
        adminPlaceProcUpDao.setConnection(conn);

        placeInfo = adminPlaceProcUpDao.getAdminPlaceInfo(piid);
        close(conn);
        
        return placeInfo;
    }
}
