package comm.bbs;

public class Event_data {
    private String user_id;
    private String event_id;
    private String event_address;


    public String getuser_id() {
        return user_id;
    }

    public void setuser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getevent_id() {
        return event_id;
    }
    public void setevent_id(String event_id) {
        this.event_id = event_id;
    }


    public String getevent_address() {
        return event_address;
    }

    public void setevent_address(String event_address) {
        this.event_address = event_address;
    }
}