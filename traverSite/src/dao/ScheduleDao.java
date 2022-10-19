package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.time.*;
import java.sql.*;
import vo.*;

public class ScheduleDao {
    private static ScheduleDao scheduleDao;
    private Connection conn;
    private ScheduleDao() {}

    public static ScheduleDao getInstance() {
        if (scheduleDao == null)   scheduleDao = new ScheduleDao();
        return scheduleDao;
    }

    public void setConnection(Connection conn) {
        this.conn = conn;
    }
    
    public String getScheduleInfoId() {
    // 새로운 주문번호(일련번호(SI + 3자리로 1001))를 생성하여 리턴하는 메소드
        Statement stmt = null;
        ResultSet rs = null;
        String si_id = null;

        try {
            stmt = conn.createStatement();
            String sql = "select right(si_id, 4) num from t_schedule_info order by si_date desc limit 0, 1";
            // 가장 최근 등록된 일정의 숫자를 가져오는 쿼리
            rs = stmt.executeQuery(sql);
            if (rs.next()) {    // 검색된 일정이 존재하면
                int num = Integer.parseInt(rs.getString(1)) + 1;
                si_id = "SI" + num;
            } else {    // 오늘 첫 구매일 경우
                si_id = "SI1001";
            }
        } catch(Exception e) {
            System.out.println("ScheduleDao 클래스의 getScheduleInfoId() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);  close(stmt);
        }

        return si_id;
    }
    
    public String getPlaceImg(String imgPiid) {
        Statement stmt = null;
        ResultSet rs = null;
        String img = null;
        
        try {
            stmt = conn.createStatement();
            String sql = "select pi_img1 from t_place_info where pi_id = " + imgPiid;
            rs = stmt.executeQuery(sql);
            if (rs.next()) {    // 검색된 장소 이미지가 존재하면
                img = rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println("ScheduleDao 클래스의 getPlaceImg() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(rs);  close(stmt);
        }
        return img;
    }

    
    public String scheduleInfoInsert(String miid, String scheduleName, String imgPiid, ScheduleInfo scheduleInfo) {
        Statement stmt = null;
        int success = 0;
        String siid = getScheduleInfoId();
        String img = getPlaceImg(imgPiid);
        
        try {
            stmt = conn.createStatement();
            String sql = "insert into t_schedule_info (si_id, mi_id, si_sdate, si_edate, si_name, si_dnum,  si_img) " + 
                    " values ('" + siid + "', '"+ miid +"', '"+ scheduleInfo.getSi_sdate() + "', '"+
                    scheduleInfo.getSi_edate() + "', '" + scheduleName + "', '" + scheduleInfo.getSi_dnum()  + "', '"+ img + "')";
            success = stmt.executeUpdate(sql);
        } catch (Exception e) {
            System.out.println("ScheduleDao 클래스의 scheduleInfoInsert() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }
        return siid + ":" + success;
    }

    
    public String scheduleDayInsert(String siid, ArrayList<ScheduleDay> scheduleDayList) {
        Statement stmt = null;
        ResultSet rs = null;
        int success = 0, target = 0;
        
        try {
            stmt = conn.createStatement();
            for(int i = 0; i < scheduleDayList.size(); i++) {
                ScheduleDay sd = scheduleDayList.get(i);
                String sql = "insert into t_schedule_day (si_id, pi_id, pi_name, sd_dnum, sd_date, sd_seq, sd_coords) " + 
                        " values ('" + siid + "', '" + sd.getPi_id() + "', '" +  sd.getPi_name() +"', '" +
                        sd.getSd_dnum()+ "', '"+ sd.getSd_date() +"', '" + i +"', '" + sd.getSd_coords() + "') ";
                System.out.println(sql);
                success += stmt.executeUpdate(sql); target++;
            }
        } catch (Exception e) {
            System.out.println("ScheduleDao 클래스의 scheduleDayInsert() 메소드 오류");
            e.printStackTrace();
        } finally {
            close(stmt);
        }
        return success + ":" + target;
    }

}
