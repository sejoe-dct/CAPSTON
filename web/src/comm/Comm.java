package comm;

public class Comm {
    private String comm_id;
    private String user_id;
    private String comm_title;

    private String comm_preview;
    private String comm_picture;
    private String comm_address;
    private String comm_info;
    private int comm_score;
    private int comm_like;
    private String comm_date;


    public String getcomm_id() {
        return comm_id;
    }
    public void setcomm_id(String comm_id) {
        this.comm_id = comm_id;
    }
    public String getuser_id() {
        return user_id;
    }
    public void setuser_id(String user_id) {
        this.user_id = user_id;
    }
    public String getcomm_title() {
        return comm_title;
    }
    public void setcomm_title(String comm_title) {
        this.comm_title = comm_title;
    }
    public String getcomm_preview() {
        return comm_preview;
    }
    public void setcomm_preview(String comm_preview) {
        this.comm_preview = comm_preview;
    }
    public String getcomm_picture() {
        return comm_picture;
    }
    public void setcomm_picture(String comm_picture) {
        this.comm_picture = comm_picture;
    }
    public String getcomm_info() {
        return comm_info;
    }
    public void setcomm_info(String comm_info) {
        this.comm_info = comm_info;
    }
    public String getcomm_address(){return comm_address;}
    public void setcomm_address(String comm_address){this.comm_address=comm_address;}
    public int getcomm_score() {
        return comm_score;
    }
    public void setcomm_score(int comm_score) {
        this.comm_score = comm_score;
    }
    public int getcomm_like() {
        return comm_like;
    }
    public void setcomm_like(int comm_like) {
        this.comm_like = comm_like;
    }
    public String getcomm_date() {
        return comm_date;
    }
    public void setcomm_date(String comm_date) {
        this.comm_date = comm_date;
    }

}