package vo;

public class ScheduleDay {
// 스케줄의 일차, 선택한 장소 하나가 모두 저장될 클래스
    private String sd_id, si_id, pi_id, pi_name, sd_coords, sd_date;
    private int sd_seq, sd_dnum;

    public String getSd_id() {
        return sd_id;
    }

    public void setSd_id(String sd_id) {
        this.sd_id = sd_id;
    }

    public String getSi_id() {
        return si_id;
    }

    public void setSi_id(String si_id) {
        this.si_id = si_id;
    }

    public String getPi_id() {
        return pi_id;
    }

    public void setPi_id(String pi_id) {
        this.pi_id = pi_id;
    }

    public String getPi_name() {
        return pi_name;
    }

    public void setPi_name(String pi_name) {
        this.pi_name = pi_name;
    }
    
    public String getSd_coords() {
        return sd_coords;
    }

    public void setSd_coords(String sd_coords) {
        this.sd_coords = sd_coords;
    }
    
    public int getSd_seq() {
        return sd_seq;
    }

    public void setSd_seq(int sd_seq) {
        this.sd_seq = sd_seq;
    }
    
    public String getSd_date() {
        return sd_date;
    }

    public void setSd_date(String sd_date) {
        this.sd_date = sd_date;
    }

    public int getSd_dnum() {
        return sd_dnum;
    }

    public void setSd_dnum(int sd_dnum) {
        this.sd_dnum = sd_dnum;
    }
    
}
