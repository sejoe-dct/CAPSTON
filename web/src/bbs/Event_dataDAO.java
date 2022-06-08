package bbs;

import java.sql.*;
import java.util.ArrayList;

public class Event_dataDAO {
    private Connection conn;	//db에 접근하는 객체
    private ResultSet rs;
    private ResultSet rs2;


    public Event_dataDAO() {
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

    public ArrayList<Event_data> getEventUserID(String userID) {
        String sql = "select * from event_data where user_id = ?";
        String sql2 = "select event_address from event where event_id = ?";
        ArrayList<Event_data> list = new ArrayList<Event_data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Event_data bbs = new Event_data();
                bbs.setuser_id(rs.getString(1));
                bbs.setevent_id(rs.getString(2));

                String id1 = rs.getString(1);
                String eventid= rs.getString(2);

                //이벤트 아이디 바로넣어서 주소 받아오기
                /*try {*/

                pstmt2.setString(1, eventid);
                rs2 = pstmt2.executeQuery();
                if (rs2.next()) {
                    bbs.setevent_address(rs2.getString(1));
                    String addr = rs2.getString(1);
                }
                list.add(bbs);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public ArrayList<Bbs> getEvent_data(String user_id) throws SQLException {
        String SQL = "SELECT * FROM event_data WHERE user_id = ?";
        ArrayList<Event_data> list = new ArrayList<Event_data>();
        ArrayList<Bbs> like_list = null;
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user_id);
            rs = pstmt.executeQuery();


            while (rs.next()) {
                Event_data event_data = new Event_data();

                event_data.setuser_id(rs.getString(1));
                event_data.setevent_id(rs.getString(2));
                list.add(event_data);
            }

            String like_eventid = null;
            String SQL2 = "SELECT * FROM event WHERE event_id = ?";
            like_list = new ArrayList<Bbs>();


            for (int i = 0; i < list.size(); i++) {
                like_eventid = list.get(i).getevent_id();

                PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
                pstmt2.setString(1, like_eventid);
                rs2 = pstmt2.executeQuery();

                while (rs2.next()) {
                    Bbs bbs2 = new Bbs();
                    bbs2.setEventID(rs2.getString(1));
                    bbs2.setUserID(rs2.getString(2));
                    bbs2.setEvent_Title(rs2.getString(3));
                    bbs2.setEvent_Preview(rs2.getString(4));
                    bbs2.setEvent_Picture(rs2.getString(5));
                    bbs2.setEvent_Address(rs2.getString(6));
                    bbs2.setEvent_Intro(rs2.getString(7));
                    bbs2.setEvent_Content(rs2.getString(8));
                    bbs2.setEvent_Phone(rs2.getString(9));
                    bbs2.setEvent_StartDate(rs2.getString(10));
                    bbs2.setEvent_EndDate(rs2.getString(11));
                    bbs2.setEvent_Like(rs2.getInt(12));
                    bbs2.setEvent_manager(rs2.getString(13));
                    bbs2.setEvent_type(rs2.getInt(14));
                    bbs2.setEvent_picName(rs2.getString(15));
                    like_list.add(bbs2);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return like_list;
    }


    public int write(String user_id, String event_id) throws SQLException {
        String sql = "INSERT INTO event_data VALUES(?, ?)";
        String sql2 = "update event set event_like= event_like+1 where event_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            pstmt.setString(2, event_id);
            pstmt.executeUpdate();

            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setString(1, event_id);
            pstmt2.executeUpdate();

            return 1;

        }catch(Exception e) {
            e.printStackTrace();
        }

        return -1; //데이터베이스 오류
    }


    public ArrayList<Bbs> getList(String userID,String eventID) {
        String SQL = "SELECT * FROM event WHERE event_id = (select event_id from event_data where user_id =?)order by event_id desc limit 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
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
    }


    public int delete(String user_id, String event_id) {
        String SQL = "DELETE FROM event_data WHERE user_id = ? AND event_id = ?";
        String sql2 = "update event set event_like= event_like-1 where event_id=?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, (user_id));
            pstmt.setString(2, event_id);
            pstmt.executeUpdate();

            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setString(1, event_id);
            pstmt2.executeUpdate();

            return 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public int check(String user_id, String event_id) throws SQLException {
        String sql = "select * from event_data where user_id=? and event_id=?";
        ArrayList<Event_data> list = new ArrayList<Event_data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            pstmt.setString(2, event_id);


            rs = pstmt.executeQuery();

            while(rs.next()) {
                return 2;
            }

        }catch(Exception e) {
            e.printStackTrace();
        }

        return -1; //데이터베이스 오류
    }



}
