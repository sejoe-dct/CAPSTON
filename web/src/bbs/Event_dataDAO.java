package bbs;

import java.sql.*;
import java.util.ArrayList;

public class Event_dataDAO {

    private Statement stmt;
    private Connection conn;
    private ResultSet rs;
    private ResultSet rs2;

    public Event_dataDAO() {
        try {
            String dbURL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul&useUnicode=true&characterEncoding=utf8";
            String dbID = "test";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
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


}
