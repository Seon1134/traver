package vo;

public class ScheduleInfo {
// '내 일정'에서 하나의 일정 정보를 저장할 클래스 
    private int si_dnum; 
    private String si_id, mi_id, si_sdate, si_edate, si_date, si_last, si_name, si_isTake, si_img;
    
    public int getSi_dnum() {
        return si_dnum;
    }
    public void setSi_dnum(int si_dnum) {
        this.si_dnum = si_dnum;
    }
    public String getSi_id() {
        return si_id;
    }
    public void setSi_id(String si_id) {
        this.si_id = si_id;
    }
    public String getMi_id() {
        return mi_id;
    }
    public void setMi_id(String mi_id) {
        this.mi_id = mi_id;
    }
    public String getSi_sdate() {
        return si_sdate;
    }
    public void setSi_sdate(String si_sdate) {
        this.si_sdate = si_sdate;
    }
    public String getSi_edate() {
        return si_edate;
    }
    public void setSi_edate(String si_edate) {
        this.si_edate = si_edate;
    }
    public String getSi_date() {
        return si_date;
    }
    public void setSi_date(String si_date) {
        this.si_date = si_date;
    }
    public String getSi_last() {
        return si_last;
    }
    public void setSi_last(String si_last) {
        this.si_last = si_last;
    }
    public String getSi_name() {
        return si_name;
    }
    public void setSi_name(String si_name) {
        this.si_name = si_name;
    }
    public String getSi_isTake() {
        return si_isTake;
    }
    public void setSi_isTake(String si_isTake) {
        this.si_isTake = si_isTake;
    }
    public String getSi_img() {
        return si_img;
    }
    public void setSi_img(String si_img) {
        this.si_img = si_img;
    }

}
