package vo;

import java.util.ArrayList;

public class GoodInfo {

    private String gi_id, mi_id, gi_nickname, gi_date, gi_name, gi_img; 
    private int gi_dnum;
    private ArrayList<GoodDay> goodDayList;
    
    public String getGi_id() {
        return gi_id;
    }
    public void setGi_id(String gi_id) {
        this.gi_id = gi_id;
    }    
    public String getMi_id() {
        return mi_id;
    }
    public void setMi_id(String mi_id) {
        this.mi_id = mi_id;
    }
    public String getGi_nickname() {
        return gi_nickname;
    }
    public void setGi_nickname(String gi_nickname) {
        this.gi_nickname = gi_nickname;
    }
    public String getGi_date() {
        return gi_date;
    }
    public void setGi_date(String gi_date) {
        this.gi_date = gi_date;
    }
    public String getGi_name() {
        return gi_name;
    }
    public void setGi_name(String gi_name) {
        this.gi_name = gi_name;
    }
    public String getGi_img() {
        return gi_img;
    }
    public void setGi_img(String gi_img) {
        this.gi_img = gi_img;
    }
    public int getGi_dnum() {
        return gi_dnum;
    }
    public void setGi_dnum(int gi_dnum) {
        this.gi_dnum = gi_dnum;
    }
    public ArrayList<GoodDay> getGoodDayList() {
        return goodDayList;
    }
    public void setGoodDayList(ArrayList<GoodDay> goodDayList) {
        this.goodDayList = goodDayList;
    }
    
}
