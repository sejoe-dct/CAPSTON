package bbs;

import comm.Comm_data;

import java.sql.*;
import java.util.ArrayList;

public class Comm_dataDAO {

    private Statement stmt;
    private Connection conn;
    private ResultSet rs;
    private ResultSet rs2;

    public Comm_dataDAO() {
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

    public ArrayList<Comm_data> getCommUserID(String userID) {
        System.out.println("getCommUserID 함수" );
        String sql = "select * from comm_data where user_id = ?";
        String sql2 = "select comm_address from community where comm_id = ?";
        ArrayList<Comm_data> list = new ArrayList<Comm_data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt.setString(1, userID);
            System.out.println("comm- pstmt.setString(1, userID); :" + userID );
            rs = pstmt.executeQuery();
            while (rs.next()) {
                System.out.println("comm- if (rs.next()) {" );
                Comm_data bbs = new Comm_data();
                bbs.setuser_id(rs.getString(1));
                bbs.setcomm_id(rs.getString(2));

                String id1 = rs.getString(1);
                String commid= rs.getString(2);
                System.out.println("rs.getInt(1); id1:  " +id1);
                System.out.println("rs.getInt(2); commid:  " +commid);
                //이벤트 아이디 바로넣어서 주소 받아오기
                /*try {*/

                pstmt2.setString(1, commid);
                rs2 = pstmt2.executeQuery();
                if (rs2.next()) {
                    System.out.println("comm- if (rs2.next()) {" );
                    bbs.setcomm_address(rs2.getString(1));
                    String addr = rs2.getString(1);
                    System.out.println("comm- if (rs2.next()) {" + addr);


                }
                list.add(bbs);
                System.out.println("comm- list.add(bbs); ");
                /*} catch (Exception e2) {
                    e2.printStackTrace();
                }*/

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("comm- return list: "+list);
        return list;
        //  return null;
    }


}
