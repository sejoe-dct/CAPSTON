package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

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
            conn =DriverManager.getConnection(dbURL,dbID,dbPassword); // 연결 얻기
            System.out.println("디비연결성공");
            // Type mismatch: cannot convert from java.sql.Connection to com.sun.corba.se.pept.transport.Connection
            // import 확인 하기

        } catch (Exception e) {
            // TODO: handle exception
        }
    }

    public int login(String userID, String userPassword) {
        System.out.println("로그인1 : "+ userID+ " "+userPassword);
        String SQL="SELECT user_pswd FROM user WHERE user_id=?";
        try {
            pstmt=conn.prepareStatement(SQL); // SQL 실행 객체
            pstmt.setString(1, userID);  // SQL 객체의 첫 번째 물음표 값 지정
            rs=pstmt.executeQuery();
            //System.out.println("프린트 rs1 : "+rs.getString(1));
            if(rs.next()) {
                if(rs.getString(1).equals(userPassword)) {
                   // System.out.println("프린트 rs2 : "+rs.getString(1));
                    return 1;
                }else {
                    return 0;
                }
            }
            return -1;
        } catch (Exception e) {
            // TODO: handle exception
        }
        return -2;
    }

    public int join(User user) {
        String SQL="INSERT INTO user VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try {
            pstmt=conn.prepareStatement(SQL);
            pstmt.setString(1,user.getUserID());
            pstmt.setString(2,user.getUserName());
            pstmt.setString(3,user.getUserPassword());
            pstmt.setString(4,user.getUserNickname());
            pstmt.setString(5,user.getUserEmail());
            pstmt.setInt(6,user.getUserType());
            pstmt.setString(7,user.getUserSex());
            pstmt.setInt(8,user.getUserAge());
            pstmt.setString(9,user.getUserFv1());
            pstmt.setString(10,user.getUserFv2());
            pstmt.setString(11,user.getUserFv3());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("오류가 발생했습니다.");
            // TODO: handle exception
        }
        return -2;
    }

}
