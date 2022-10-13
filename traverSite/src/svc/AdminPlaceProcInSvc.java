package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminPlaceProcInSvc {
    public int placeInsert(String name, String phone, String link, String ctgr, String zip, String coords, String addr1,
            String addr2, String isview, String desc, String img1, String img2, String img3, String img4, String img5) {
        int result = 0;
        Connection conn = getConnection();
        AdminPlaceProcInDao placeProcInDao = AdminPlaceProcInDao.getInstance();
        placeProcInDao.setConnection(conn);
        
        result = placeProcInDao.placeInsert(name, phone, link, ctgr, zip, coords, addr1, addr2, isview, desc, img1, img2, img3, img4, img5);
        if (result > 0) {
            commit(conn);
        } else {
            rollback(conn);
        }
        close(conn);
        
        return result;
    }

}
