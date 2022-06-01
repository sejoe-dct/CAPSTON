package comm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Comm_dataDAO {

    private Connection conn;	//db에 접근하는 객체
    private ResultSet rs;


   public Comm_dataDAO(){
       try{
        String dbURL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul&useUnicode=true&characterEncoding=utf8";
        String dbID = "test";
        String dbPassword = "1234";
        Class.forName("com.mysql.cj.jdbc.Driver"); //드라이버 로드
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 연결 얻기
    }catch (Exception e) {
       e.printStackTrace();
       }
   }

    public ArrayList<Comm> getList( String user_id,String comm_id) {

            String sql = "SELECT * FROM community where comm_id in(select comm_id from comm_data where user_id =?)order by comm_id desc limit 10";
            ArrayList<Comm> list = new ArrayList<Comm>();
            try {
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1,user_id);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    Comm comm = new Comm();
                    comm.setcomm_id(rs.getString(1));
                    comm.setuser_id(rs.getString(2));
                    comm.setcomm_title(rs.getString(3));
                    comm.setcomm_preview(rs.getString(4));
                    comm.setcomm_picture(rs.getString(5));
                    comm.setcomm_info(rs.getString(6));
                    comm.setcomm_address(rs.getString(7));
                    comm.setcomm_like(rs.getInt(8));
                    comm.setcomm_date(rs.getString(9));
                    comm.setcomm_picName(rs.getString(10));
                    comm.setcomm_score(rs.getInt(11));

                    list.add(comm);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list; //db오류
        }




        public int write(String user_id, String comm_id){
            String SQL = "INSERT INTO comm_data VALUES(?, ?)";
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, user_id);
                pstmt.setString(2, comm_id);
                pstmt.executeUpdate();
                return 1;
            } catch (Exception e) {
                e.printStackTrace();
            }
            return -1; //데이터베이스 오류
        }

        public ArrayList<Comm_data> getComm_data(String user_id, String comm_id) {
            String SQL = "SELECT * FROM comm_data WHERE user_id = ? AND comm_id = ?";
            ArrayList<Comm_data> list = new ArrayList<Comm_data>();
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1,  user_id);
                pstmt.setString(2,  comm_id);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    Comm_data comm_data = new Comm_data();
                    comm_data.setuser_id(rs.getString(1));
                    comm_data.setcomm_id(rs.getString(2));
                    list.add(comm_data);
                }
            }catch(Exception e) {
                e.printStackTrace();
            }
            return list;
        }

    public int delete(String user_id,String comm_id) {
        String SQL = "DELETE FROM comm_data WHERE user_id = ? AND comm_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(user_id));
            pstmt.setString(2, comm_id);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    }