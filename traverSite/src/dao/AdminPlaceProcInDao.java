package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminPlaceProcInDao {
    private static AdminPlaceProcInDao placeProcInDao; 
    private Connection conn;
    private AdminPlaceProcInDao() {}
    
    public static AdminPlaceProcInDao getInstance() {
        if (placeProcInDao == null) {
            placeProcInDao = new AdminPlaceProcInDao();
        }
        return placeProcInDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public int placeInsert(String name, String phone, String link, String ctgr, String zip, String coords, String addr1,
            String addr2, String isview, String desc, String img1, String img2, String img3, String img4, String img5) {
        PreparedStatement pstmt = null;
        int result = 0;
        
        try {
            String sql = "insert into t_place_info (pi_name, pi_phone, pi_link, pi_coords, " +
                " pi_addr1, pi_addr2, pi_zip, pi_img1, pi_img2, pi_img3, pi_img4, pi_img5, " + 
                " pi_desc, pi_ctgr, pi_isview) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, phone);
            pstmt.setString(3, link);
            pstmt.setString(4, coords);
            pstmt.setString(5, addr1);
            pstmt.setString(6, addr2);
            pstmt.setString(7, zip);
            pstmt.setString(8, img1);
            pstmt.setString(9, img2);
            pstmt.setString(10, img3);
            pstmt.setString(11, img4);
            pstmt.setString(12, img5);
            pstmt.setString(13, desc);
            pstmt.setString(14, ctgr);
            pstmt.setString(15, isview);
            result = pstmt.executeUpdate();
            
        } catch (Exception e) {
            System.out.println("PlaceProcInDao 클래스의 placeInsert() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(pstmt);
        }
        
        return result;
    }
}
