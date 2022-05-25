package bbs;

import java.sql.*;


public class BbsDAO {

    private Connection conn;
    private ResultSet rs;

    //기본 생성자
    public BbsDAO() {
        try {
            String dbURL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul";
            String dbID = "test";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    //작성일자 메소드
   /* public String getDate() {
        String sql = "select now()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getString(1);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return ""; //데이터베이스 오류
    }
*/
    //게시글 번호 부여 메소드
    public int getNext() {
        //현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
        String sql = "select event_id from event order by event_id desc";
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
    public int write( String userID,String event_Title, String event_Preview, String event_Address, String event_Phone,
                     String event_Picture, String event_StartDate, String event_EndDate,
                     String event_Intro, String event_Content) {
        System.out.println("write 함수 테스트1 : "+ event_Title);
        //bbs.Bbs bbs = new bbs.Bbs();
        //String userID = bbs.getUserID();

        int event_Like = 0;
        String event_manager = "manager";//elect문..아이디로 user에서 정보 가져와서
        int event_type = 1;//bbs.getEvent_type();// html 수정

        Date sDate=Date.valueOf(event_StartDate);//converting string into sql date
        Date eDate=Date.valueOf(event_EndDate);

        String sql = "insert into event values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

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

            System.out.println("디비 삽입 값 : "+ pstmt);

            return pstmt.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }



}