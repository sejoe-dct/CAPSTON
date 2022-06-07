package bbs;

import user.User;

import java.sql.*;
import java.util.ArrayList;

public class BbsDAO {

    private Statement stmt;
    private Connection conn;
    private ResultSet rs;

    private ResultSet rs2;

    private ResultSet rs3;
    private ResultSet rs4;


    //기본 생성자
    public BbsDAO() {
        try {
            String dbURL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul&useUnicode=true&characterEncoding=utf8";
            String dbID = "test";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    //게시글 번호 부여 메소드
    public int getNext() {
        //현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
//        String sql = "select event_id from event order by event_id desc";
        String sql = "select event_id from event ORDER BY LPAD(event_id, 3,'0') desc";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1; //첫 번째 게시물인 경우
        }catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }

    //글쓰기 메소드
    public int write(String userID, String event_Title, String event_Preview, String event_Address, String event_Phone,
                     String event_Picture, String event_PicName, String event_StartDate, String event_EndDate,
                     String event_Intro,String event_manager,String event_Content, int event_type,String event_url) {


        int event_Like = 0;

        Date sDate = Date.valueOf(event_StartDate);//converting string into sql date
        Date eDate = Date.valueOf(event_EndDate);

        String sql = "insert into event values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, userID);
            pstmt.setString(3, event_Title);
            pstmt.setString(4, event_Preview);
            pstmt.setString(5, event_Picture);
            pstmt.setString(6, event_Address);
            pstmt.setString(7, event_Intro);
            pstmt.setString(8, event_Content);
            pstmt.setString(9, event_Phone);
            pstmt.setDate(10, sDate);
            pstmt.setDate(11, eDate);
            pstmt.setInt(12, event_Like);
            pstmt.setString(13, event_manager);
            pstmt.setInt(14, event_type);
            pstmt.setString(15, event_PicName);
            pstmt.setString(16, event_url);
            System.out.println("디비 삽입 값 : " + pstmt);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }



    public ArrayList<Bbs> getList(String localName, String search) {
        if (localName.equals("전국")) {
            System.out.println("getList 전국 if문 들어옴");
            localName = "";
        }
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        //      pstmt.setInt(1,getNext()-(pageNumber-1)*10);
        //기본 값이 아니라 지역명 선택했을 때
        //   String sql = String.format("SELECT * FROM event WHERE localname = " + localName);
        StringBuffer query = new StringBuffer();
        System.out.println("지역명 선택하고 쿼리문 어펜드하기전");
        query.append("SELECT * FROM event WHERE event_address LIKE ? AND CONCAT(event_title, event_preview, event_intro) LIKE ?");
        try {
            PreparedStatement psmt = conn.prepareStatement(query.toString());
            psmt.setString(1, "%" + localName + "%"); //"KSC5601"),"8859_1"//1트
            psmt.setString(2, "%" + search + "%");
            rs = psmt.executeQuery();
            while (rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setEventID(rs.getString(1));
                bbs.setUserID(rs.getString(2));
                bbs.setEvent_Title(rs.getString(3));
                bbs.setEvent_Preview(rs.getString(4));
                bbs.setEvent_Picture(rs.getString(5));
                bbs.setEvent_Address(rs.getString(6));
                bbs.setEvent_Intro(rs.getString(7));
                bbs.setEvent_Content(rs.getString(8));
                bbs.setEvent_Phone(rs.getString(9));
                bbs.setEvent_StartDate(rs.getString(10));
                bbs.setEvent_EndDate(rs.getString(11));
                bbs.setEvent_Like(rs.getInt(12));
                bbs.setEvent_manager(rs.getString(13));
                bbs.setEvent_type(rs.getInt(14));
                bbs.setEvent_picName(rs.getString(15));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;

        //  String SQL="SELECT * FROM BBS WHERE bbsID<? AND bbsAvailable=1 ORDER BY bbsID DESC LIMIT 10";
    }


    public int checkType(String id) {
        int type=0;
        String SQL = "SELECT user_type FROM user WHERE user_id='"+ id + "'";
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(SQL);
            if (rs.next()) { //rs.next()를 통해 다음행을 내려갈 수 있으면 true를 반환하고, 커서를 한칸 내린다. 다음행이 없으면 false를 반환한다.
                type = rs.getInt("user_type");

            }
            return type;
        } catch (Exception e) {
            // TODO: handle exception
        }

        return -2;

    }

    //페이징 처리 메소드
    public boolean nextPage(int pageNumber) {
        String sql = "select * from bbs where event < ? and bbsAvailable = 1";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return true;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //하나의 게시글을 보는 메소드
    public Bbs getEventDetail(int eventID) {
        String sql = "select * from event where event_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, eventID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                Bbs bbs=new Bbs();
                bbs.setEventID(rs.getString(1));
                bbs.setUserID(rs.getString(2));
                bbs.setEvent_Title(rs.getString(3));
                bbs.setEvent_Preview(rs.getString(4));
                bbs.setEvent_Picture(rs.getString(5));
                bbs.setEvent_Address(rs.getString(6));
                bbs.setEvent_Intro(rs.getString(7));
                bbs.setEvent_Content(rs.getString(8));
                bbs.setEvent_Phone(rs.getString(9));
                bbs.setEvent_StartDate(rs.getString(10));
                bbs.setEvent_EndDate(rs.getString(11));
                bbs.setEvent_Like(rs.getInt(12));
                bbs.setEvent_manager(rs.getString(13));
                bbs.setEvent_type(rs.getInt(14));
                bbs.setEvent_picName(rs.getString(15));

                return bbs;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public ArrayList<Bbs> getEvent_recom(String user_id) {
        String sql = "select * from user where user_id = ? ";
        ArrayList<User> session_user_list = new ArrayList<User>();

        try{
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,user_id);
            //pstmt0.setString(1, user_id);
            rs=pstmt.executeQuery();
            while(rs.next()){
                User user=new User();

                user.setUserSex(rs.getString(7));
                user.setUserAge(rs.getInt(8));
                user.setUserFv1(rs.getString(9));
                user.setUserFv2(rs.getString(10));
                user.setUserFv3(rs.getString(11));

                session_user_list.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String sql2 = "select user_id from user " +
                "where user_sex=? and user_fv1=? and user_fv2=? and user_fv3=? and user_id != ?";
        ArrayList<User> sm_user_list = new ArrayList<User>();

        try{
            PreparedStatement pstmt = conn.prepareStatement(sql2);

            pstmt.setString(1, String.valueOf(session_user_list.get(0).getUserSex()));
            pstmt.setString(2, String.valueOf(session_user_list.get(0).getUserFv1()));
            pstmt.setString(3, String.valueOf(session_user_list.get(0).getUserFv2()));
            pstmt.setString(4, String.valueOf(session_user_list.get(0).getUserFv3()));
            pstmt.setString(5, user_id);


            rs2=pstmt.executeQuery();
            while(rs2.next()){
                User sm_user = new User();
                sm_user.setUserID(rs2.getString(1));
                sm_user_list.add(sm_user);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String sql3 = "select event_id from event_data where user_id=?";
        ArrayList<Event_data> sm_user_like_list = new ArrayList<Event_data>();

        try{
            for(int i=0; i<sm_user_list.size(); i++) {
                PreparedStatement pstmt = conn.prepareStatement(sql3);
                pstmt.setString(1, String.valueOf(sm_user_list.get(i).getUserID()));

                rs3 = pstmt.executeQuery();
                while (rs3.next()) {
                    Event_data rc_event_id = new Event_data();
                    rc_event_id.setevent_id(rs3.getString(1));
                    sm_user_like_list.add(rc_event_id);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String sql4 = "select * from event where event_id=?";
        ArrayList<Bbs> rc_event_list = new ArrayList<Bbs>();

        try{
            for(int i=0; i<sm_user_like_list.size(); i++) {
                PreparedStatement pstmt = conn.prepareStatement(sql4);
                pstmt.setString(1, String.valueOf(sm_user_like_list.get(i).getevent_id()));

                rs4 = pstmt.executeQuery();
                while (rs4.next()) {
                    Bbs rc_event = new Bbs();
                    rc_event.setEventID(rs4.getString(1));
                    rc_event.setUserID(rs4.getString(2));
                    rc_event.setEvent_Title(rs4.getString(3));
                    rc_event.setEvent_Preview(rs4.getString(4));
                    rc_event.setEvent_Picture(rs4.getString(5));
                    rc_event.setEvent_Address(rs4.getString(6));
                    rc_event.setEvent_Intro(rs4.getString(7));
                    rc_event.setEvent_Content(rs4.getString(8));
                    rc_event.setEvent_Phone(rs4.getString(9));
                    rc_event.setEvent_StartDate(rs4.getString(10));
                    rc_event.setEvent_EndDate(rs4.getString(11));
                    rc_event.setEvent_Like(rs4.getInt(12));
                    rc_event.setEvent_manager(rs4.getString(13));
                    rc_event.setEvent_type(rs4.getInt(14));
                    rc_event.setEvent_picName(rs4.getString(15));

                    rc_event_list.add(rc_event);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rc_event_list;
    }

    public ArrayList<Bbs> getPreviewList() {

        String sql = String.format("SELECT * FROM event ORDER BY LPAD(event_id, 3,'0') DESC LIMIT 6");
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs = new Bbs();

                bbs.setEventID(rs.getString(1));

                bbs.setEvent_Title(rs.getString(3));

                bbs.setEvent_Preview(rs.getString(4));

                bbs.setEvent_Picture(rs.getString(5));

                bbs.setEvent_Intro(rs.getString(7));

                bbs.setEvent_picName(rs.getString(15));

                list.add(bbs);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



}