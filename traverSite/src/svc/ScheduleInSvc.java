package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ScheduleInSvc {
    public String scheduleInfoInsert(String miid, String scheduleName, String imgPiid, ScheduleInfo scheduleInfo) {
        Connection conn = getConnection();
        ScheduleDao scheduleDao = ScheduleDao.getInstance();
        scheduleDao.setConnection(conn);

        String result = scheduleDao.scheduleInfoInsert(miid, scheduleName, imgPiid, scheduleInfo);
        String[] arr = result.split(":"); // siid랑 성공여부를 담은 레코드 수
        String siid = arr[0];             // 일정 id (siid)
        int success = Integer.parseInt(arr[1]);  // 성공한 레코드 개수
        if (success > 0) { // 성공적으로 insert했으면
            commit(conn);
        } else { // insert에 실패했으면
            rollback(conn);
        }
        close(conn);

        return result;
    }

    public String scheduleDayInsert(String siid, ArrayList<ScheduleDay> scheduleDayList) {
        String result = null;
        Connection conn = getConnection();
        ScheduleDao scheduleDao = ScheduleDao.getInstance();
        scheduleDao.setConnection(conn);

        result = scheduleDao.scheduleDayInsert(siid, scheduleDayList);
        String[] arr = result.split(":");
        int success = Integer.parseInt(arr[0]);  // 실제 적용된 레코드 개수
        int target = Integer.parseInt(arr[1]);  // 적용되었어야 할 레코드 개수
        if (success == target)   commit(conn);
        else                    rollback(conn);
        close(conn);

        return result;
    }
}
