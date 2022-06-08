package user;

import java.sql.*;
import java.util.ArrayList;

public class UserDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private ResultSet rs2;
    private ResultSet rs3;
    private ResultSet rs4;

    //	Class.forName() 을 이용해서 드라이버 로드
//	DriverManager.getConnection() 으로 연결 얻기
//	Connection 인스턴스를 이용해서 Statement 객체 생성
//	Statement 객체의 결과를 ResultSet 이나 int에 받기
    public UserDAO() {
        try {
            String dbURL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul";
            String dbID = "test";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver"); //드라이버 로드
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 연결 얻기
            //System.out.println("디비연결성공");
            // Type mismatch: cannot convert from java.sql.Connection to com.sun.corba.se.pept.transport.Connection
            // import 확인 하기

        } catch (Exception e) {
            // TODO: handle exception
        }
    }

    public int login(String userID, String userPassword) {
        System.out.println("로그인1 : " + userID + " " + userPassword);
        String SQL = "SELECT user_pswd FROM user WHERE user_id=?";
        try {
            pstmt = conn.prepareStatement(SQL); // SQL 실행 객체
            pstmt.setString(1, userID);  // SQL 객체의 첫 번째 물음표 값 지정
            rs = pstmt.executeQuery();
            //System.out.println("프린트 rs1 : "+rs.getString(1));
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    // System.out.println("프린트 rs2 : "+rs.getString(1));
                    return 1;
                } else {
                    return 0;
                }
            }
            return -1;
        } catch (Exception e) {
            // TODO: handle exception
        }
        return -2;
    }

    public ArrayList<User> getUserinfo(String user_id){
        StringBuffer query = new StringBuffer();
        query.append("Select * from user where user_id=?");

        ArrayList<User> list = new ArrayList<User>();

        try {
            PreparedStatement psmt=conn.prepareStatement(query.toString());
            psmt.setString(1, user_id); //"KSC5601"),"8859_1"//1트
            rs=psmt.executeQuery();

            while(rs.next()) {
                User user=new User();
                user.setUserID(rs.getString(1));
                user.setUserName(rs.getString(2));
                user.setUserPassword(rs.getString(3));
                user.setUserNickname(rs.getString(4));
                user.setUserEmail(rs.getString(5));
                user.setUserType(rs.getInt(6));
                user.setUserSex(rs.getString(7));
                user.setUserAge(rs.getInt(8));
                user.setUserFv1(rs.getString(9));
                user.setUserFv2(rs.getString(10));
                user.setUserFv3(rs.getString(11));

                list.add(user);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }


}

