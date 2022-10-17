package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class ReportProcSvc {
    public int reportInsert(Report report) {
        int result = 0;
        Connection conn = getConnection();
        ReportProcDao reportProcDao = ReportProcDao.getInstance();
        reportProcDao.setConnection(conn);

        result = reportProcDao.reportInsert(report);
        if (result == 1)    commit(conn);
        else                rollback(conn);
        close(conn);

        return result;
    }
}
