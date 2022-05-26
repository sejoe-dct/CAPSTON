import java.sql.*;

/* Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn =null;
  Statement stmt =null;
  ResultSet rs =null;
  try {

    String jdbcDriver ="jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=UTC";
    String dbUser ="test"; //mysql id
    String dbPass ="1234"; //mysql password
    String query ="select * from User";//query
    // Create DB Connection
    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
    // Create Statement
    stmt = conn.createStatement();
    // Run Qeury
    rs = stmt.executeQuery(query);
 */
public class DBConnector {
    /*    private final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver"; //드라이버
        //private final String DB_URL = "jdbc:mysql://localhost:13192/hms?serverTimezone=Asia/Seoul&useSSL=false"; //접속할 DB 서버
        private final String DB_URL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=UTC"; //접속할 DB 서버

        private final String USER_NAME = "test"; //DB에 접속할 사용자 이름을 상수로 정의
        //private final String PASSWORD = "wjddms0922!"; //사용자의 비밀번호를 상수로 정의
        private final String PASSWORD = "1234"; //사용자의 비밀번호를 상수로 정의

        Connection conn = null;
        Statement state = null;

        public DBConnector() { // DB 연동
            try {
                Class.forName(JDBC_DRIVER);
                conn = DriverManager.getConnection(DB_URL, USER_NAME, PASSWORD);
                state = conn.createStatement();

                String sql = "USE cap";
                ResultSet rs = state.executeQuery(sql);

                rs.close();
            }
            catch(Exception e ) {
                e.printStackTrace();
            }
        }*/
    }
