package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class IschdDao {
    private static IschdDao ischdDao; 
    private Connection conn;
    private IschdDao() {}
    
    public static IschdDao getInstance() {
        if (ischdDao == null)    ischdDao = new IschdDao();
        return ischdDao;
    }
    
    public void setConnection(Connection conn) {
        this.conn = conn;
    }
    
    public ArrayList<GoodInfo> getIschdList(String where, String orderBy) {
    // 관심일정의 목록을 구하여 ArrayList<GoodInfo>로 리턴하는 메소드
        Statement stmt = null;
        ResultSet rs = null;    
        ArrayList<GoodInfo> goodList = new ArrayList<GoodInfo>();
        // 관심일정들을 저장할 목록 객체
        GoodInfo gi = null;
        // goodList에 저장할 하나의  관심일정 정보를 담을 인스턴스
        
        try {   
            stmt = conn.createStatement();
            String sql = "select * from t_schedule_zzim a, t_good_info b "
            + where + orderBy;
            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                gi = new GoodInfo();    // 하나의 관심일정을 저장할 인스턴스 생성
                gi.setGi_id(rs.getString("gi_id"));
                gi.setGi_dnum(rs.getInt("gi_dnum"));
                gi.setGi_date(rs.getString("gi_date"));
                gi.setGi_name(rs.getString("gi_name"));
                gi.setGi_img(rs.getString("gi_img"));
                goodList.add(gi);
                // 루프를 돌면서 rs에 들어있는 관심일정 정보들을 goodList에 저장 
            }
            
        } catch(Exception e) {
            System.out.println("IschdDao 클래스의 getIschdList() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs); close(stmt);
        }
        
        return goodList;
    }

}
