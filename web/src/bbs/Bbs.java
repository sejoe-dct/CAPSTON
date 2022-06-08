package bbs;

public class Bbs {

    private String eventID;
    private String userID;
    private String event_Title;
    private String event_Preview;
    private String event_Picture;
    private String event_Address;
    private int event_score;
    private String event_Intro;
    private String event_Content;
    private String event_Phone;
    private String event_StartDate;
    private String event_EndDate;
    private int event_Like;
    private String event_manager;
    private int event_type;

    public String getEvent_url() {
        return event_url;
    }

    public void setEvent_url(String event_url) {
        this.event_url = event_url;
    }

    private String event_url;
    public String getEvent_picName() {
        return event_picName;
    }

    public void setEvent_picName(String event_picName) {
        this.event_picName = event_picName;
    }

    private String event_picName;
    public String getEvent_Title() {
        return event_Title;
    }

    public void setEvent_Title(String event_Title) {
        this.event_Title = event_Title;
    }

    public String getEvent_Preview() {
        return event_Preview;
    }

    public void setEvent_Preview(String event_Preview) {
        this.event_Preview = event_Preview;
    }

    public String getEvent_Picture() {
        return event_Picture;
    }

    public void setEvent_Picture(String event_Picture) {
        this.event_Picture = event_Picture;
    }

    public String getEvent_Address() {
        return event_Address;
    }

    public void setEvent_Address(String event_Address) {
        this.event_Address = event_Address;
    }

    public int getEvent_score() {
        return event_score;
    }

    public void setEvent_score(int event_score) {
        this.event_score = event_score;
    }

    public String getEvent_manager() {
        return event_manager;
    }

    public void setEvent_manager(String event_manager) {
        this.event_manager = event_manager;
    }

    public int getEvent_type() {
        return event_type;
    }

    public void setEvent_type(int event_type) {
        this.event_type = event_type;
    }



    public String getEventID() {
        return eventID;
    }
    public void setEventID(String eventID) {
        this.eventID = eventID;
    }
    public String getUserID() {
        return userID;
    }
    public void setUserID(String userID) {
        this.userID = userID;
    }
    public String getEvent_Intro() {
        return event_Intro;
    }
    public void setEvent_Intro(String event_Intro) {
        this.event_Intro = event_Intro;
    }
    public String getEvent_Content() {
        return event_Content;
    }
    public void setEvent_Content(String event_Content) {
        this.event_Content = event_Content;
    }
    public String getEvent_Phone() {
        return event_Phone;
    }
    public void setEvent_Phone(String event_Phone) {
        this.event_Phone = event_Phone;
    }
    public String getEvent_StartDate() {
        return event_StartDate;
    }
    public void setEvent_StartDate(String event_StartDate) {this.event_StartDate = event_StartDate;}
    public String getEvent_EndDate() {
        return event_EndDate;
    }
    public void setEvent_EndDate(String event_EndDate) {this.event_EndDate = event_EndDate;}
    public int getEvent_Like() {
        return event_Like;
    }
    public void setEvent_Like(int event_Like) {
        this.event_Like = event_Like;
    }

}