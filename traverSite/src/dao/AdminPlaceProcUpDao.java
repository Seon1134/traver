package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminPlaceProcUpDao {
    private static AdminPlaceProcUpDao adminPlaceProcUpDao;
    private Connection conn;
    private AdminPlaceProcUpDao() {}

    public static AdminPlaceProcUpDao getInstance() {
        if (adminPlaceProcUpDao == null)  adminPlaceProcUpDao = new AdminPlaceProcUpDao();
        return adminPlaceProcUpDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public PlaceInfo getAdminPlaceInfo(String where) {
        Statement stmt = null;
        ResultSet rs = null;
        PlaceInfo placeInfo = null;
        
        try {
            stmt = conn.createStatement();
            String sql = "select * from t_place_info " + where;
            rs = stmt.executeQuery(sql);
            if (rs.next()) {
                placeInfo = new PlaceInfo();
                placeInfo.setPi_name(rs.getString("pi_name"));
                placeInfo.setPi_phone(rs.getString("pi_phone"));
                placeInfo.setPi_link(rs.getString("pi_link"));
                placeInfo.setPi_ctgr(rs.getString("pi_ctgr"));
                placeInfo.setPi_zip(rs.getString("pi_zip"));
                placeInfo.setPi_addr1(rs.getString("pi_addr1"));
                placeInfo.setPi_addr2(rs.getString("pi_addr2"));
                placeInfo.setPi_isview(rs.getString("pi_isview"));
                placeInfo.setPi_desc(rs.getString("pi_desc"));
                placeInfo.setPi_img1(rs.getString("pi_img1"));
                placeInfo.setPi_img2(rs.getString("pi_img2"));
                placeInfo.setPi_img3(rs.getString("pi_img3"));
                placeInfo.setPi_img4(rs.getString("pi_img4"));
                placeInfo.setPi_img5(rs.getString("pi_img5"));
            }
        } catch(Exception e) {
            System.out.println("AdminPlaceProcUpDao 클래스의 getAdminPlaceInfo() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);  
            close(stmt);
        }
        
        return placeInfo;
    }
}
