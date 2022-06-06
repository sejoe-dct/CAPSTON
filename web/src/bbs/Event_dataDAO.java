package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Event_dataDAO {
    private Connection conn;   //db에 접근하는 객체
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
        System.out.println("getEventUserID 함수" );
        String sql = "select * from event_data where user_id = ?";
        String sql2 = "select event_address from event where event_id = ?";
        ArrayList<Event_data> list = new ArrayList<Event_data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt.setString(1, userID);
            System.out.println(" pstmt.setString(1, userID); :" + userID );
            rs = pstmt.executeQuery();
            while (rs.next()) {
                System.out.println(" if (rs.next()) {" );
                Event_data bbs = new Event_data();
                bbs.setuser_id(rs.getString(1));
                bbs.setevent_id(rs.getString(2));

                String id1 = rs.getString(1);
                String eventid= rs.getString(2);
                System.out.println("rs.getInt(2); id1:  " +id1);
                System.out.println("rs.getInt(2); eventid:  " +eventid);
                //이벤트 아이디 바로넣어서 주소 받아오기
                /*try {*/

                pstmt2.setString(1, eventid);
                rs2 = pstmt2.executeQuery();
                if (rs2.next()) {
                    System.out.println("if (rs2.next()) {" );
                    bbs.setevent_address(rs2.getString(1));
                    String addr = rs2.getString(1);
                    System.out.println("if (rs2.next()) {" + addr);


                }
                list.add(bbs);
                System.out.println("list.add(bbs); ");
                /*} catch (Exception e2) {
                    e2.printStackTrace();
                }*/

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("return list: "+list);
        return list;
        //  return null;
    }

    public ArrayList<Event_data> getEvent_data(String user_id, String event_id) {
        String SQL = "SELECT * FROM event_data WHERE user_id = ? AND event_id = ?";
        ArrayList<Event_data> list = new ArrayList<Event_data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,  user_id);
            pstmt.setString(2,  event_id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Event_data event_data = new Event_data();
                event_data.setuser_id(rs.getString(1));
                event_data.setevent_id(rs.getString(2));
                list.add(event_data);
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public int write(String user_id, String event_id) {
        String sql = "INSERT INTO event_data VALUES(?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            pstmt.setString(2, event_id);
            pstmt.executeUpdate();
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


    public int delete(String user_id,String event_id) {
        String SQL = "DELETE FROM event_data WHERE user_id = ? AND event_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(user_id));
            pstmt.setString(2, event_id);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }



}