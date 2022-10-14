package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AdminPlaceListDao {
    private static AdminPlaceListDao adminPlaceListDao; 
    private Connection conn;
    private AdminPlaceListDao() {}
    
    public static AdminPlaceListDao getInstance() {
        if (adminPlaceListDao == null) {
            adminPlaceListDao = new AdminPlaceListDao();
        }
        return adminPlaceListDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }

    public ArrayList<PlaceInfo> getAdminPlaceList(String where, int cpage, int psize) {
    // 게시판 목록에서 검색한 게시글들의 목록을 ArrayList<FreeList>형 인스턴스로 리턴하는 메소드
            Statement stmt = null;
            ResultSet rs = null;
            ArrayList<PlaceInfo> placeInfo = new ArrayList<PlaceInfo>(); // 게시글들을 저장할 목록 객체
            PlaceInfo pl = null;    // placeList에 저장할 하나의 게시글 정보를 담을 인스턴스
        
            try {
                stmt = conn.createStatement();
                String sql = "select pi_id, pi_name, pi_phone, pi_ctgr, pi_date, pi_isview, pi_addr1 " + 
                        " from t_place_info " + where + " order by pi_id desc " + 
                        " limit " + ((cpage -1) * psize) + ", " + psize;
                rs = stmt.executeQuery(sql);
                while (rs.next()) {
                    pl = new PlaceInfo();
                    pl.setPi_id(rs.getString("pi_id"));
                    pl.setPi_name(rs.getString("pi_name"));
                    pl.setPi_phone(rs.getString("pi_phone"));
                    pl.setPi_ctgr(rs.getString("pi_ctgr"));
                    pl.setPi_date(rs.getString("pi_date"));
                    pl.setPi_isview(rs.getString("pi_isview"));
                    pl.setPi_addr1(rs.getString("pi_addr1"));
                    placeInfo.add(pl);
                }

            } catch (Exception e) {
                System.out.println("AdminPlaceListDao 클래스의 getAdminPlaceList() 메소드 오류");
                e.printStackTrace();
            } finally {
                close(rs);
                close(stmt);
            }
            
        return placeInfo;
    }

    public int getPlaceListCount(String where) {
     // 게시판 목록에서 사용할 레코드(게시글) 총 개수를 리턴하는 메소드
        Statement stmt = null;  // 쿼리를 DB로 보낼 객체 선언
        ResultSet rs = null;    // 쿼리(select)의 결과를 저장할 객체 선언
        int rcnt = 0;           // 현 메소드의 결과를 저장할 변수로 리턴할 값이기도 함

        try {
            stmt = conn.createStatement();
            String sql = "select count(*) cnt from t_place_info " + where;
            rs = stmt.executeQuery(sql);
            if (rs.next())  rcnt = rs.getInt("cnt");

        } catch(Exception e) {
            System.out.println("AdminPlaceListDao 클래스의 getPlaceListCount() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);  close(stmt);
        }

        return rcnt;
    }
}
