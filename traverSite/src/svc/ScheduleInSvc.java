package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ScheduleInSvc {
    public String scheduleInsert(String miid, String scheduleName, String imgPiid, ScheduleInfo scheduleInfo, ArrayList<ScheduleDay> scheduleDayList) {
        Connection conn = getConnection();
        ScheduleDao scheduleDao = ScheduleDao.getInstance();
        scheduleDao.setConnection(conn);
        
        String info = scheduleDao.scheduleInfoInsert(miid, scheduleName, imgPiid, scheduleInfo);
        String[] infoArr = info.split(":"); // siid랑 성공여부를 담은 레코드 수
        String dayIn = "";  // Day에 있어 성공했어야할 레코드수, 성공한 레코드수를 담을 변수
        
        String siid = infoArr[0]; // 일정 id (siid)
        int infoSuccess = Integer.parseInt(infoArr[1]);  // info 성공한 레코드 개수
        if (infoSuccess > 0) { // info 성공적으로 insert했으면
            dayIn = scheduleDao.scheduleDayInsert(siid, scheduleDayList);
            // day 저장 실행
            
            String[] dayArr = dayIn.split(":");   // 성공횟수:적용됐어야할 레코드 저장된 배열
            int daySuccess = Integer.parseInt(dayArr[0]); // Day 적용된 레코드 개수
            int dayTarget = Integer.parseInt(dayArr[1]);  // Day 적용되었어야 할 레코드 개수
            
            if(daySuccess == dayTarget) {
                commit(conn);
            } else {
                rollback(conn);
            }
        } else { // insert에 실패했으면
            rollback(conn);
        }
        close(conn);

        return info + ":" + dayIn;
    }
}
