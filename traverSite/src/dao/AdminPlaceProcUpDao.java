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

    public PlaceInfo getAdminPlaceInfo(String piid) {
        Statement stmt = null;
        ResultSet rs = null;
        PlaceInfo placeInfo = null;
        
        try {
            stmt = conn.createStatement();
            String sql = "select * from t_place_info where pi_id = " + piid;
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
                placeInfo.setPi_id(piid);
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

    public int AdminPlaceProcUp(PlaceInfo placeInfo) {
        Statement stmt = null;
        int result = 0;
           
        try {
            stmt = conn.createStatement();
            String sql = "update t_place_info set " + 
            " pi_name = '"      + placeInfo.getPi_name()    + "', " + 
            " pi_phone = '"     + placeInfo.getPi_phone()   + "', " + 
            " pi_link = '"      + placeInfo.getPi_link()    + "', " + 
            " pi_ctgr = '"      + placeInfo.getPi_ctgr()    + "', " + 
            " pi_zip = '"       + placeInfo.getPi_zip()     + "', " + 
            " pi_coords = '"    + placeInfo.getPi_coords()  + "', " + 
            " pi_addr1 = '"     + placeInfo.getPi_addr1()   + "', " + 
            " pi_addr2 = '"     + placeInfo.getPi_addr2()   + "', " + 
            " pi_isview = '"    + placeInfo.getPi_isview()  + "', " + 
            " pi_desc = '"      + placeInfo.getPi_desc()    + "', " + 
            " pi_img1 = '"      + placeInfo.getPi_img1()    + "', " + 
            " pi_img2 = '"      + placeInfo.getPi_img2()    + "', " + 
            " pi_img3 = '"      + placeInfo.getPi_img3()    + "', " + 
            " pi_img4 = '"      + placeInfo.getPi_img4()    + "', " + 
            " pi_img5 = '"      + placeInfo.getPi_img5()    + "' " + 
            " where pi_id = "   + placeInfo.getPi_id(); 
            result = stmt.executeUpdate(sql);
            System.out.println(sql);
        } catch(Exception e) {
            System.out.println("AdminPlaceProcUpDao 클래스의 AdminPlaceProcUp() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }

        return result;
    }
}
