package comm;

import user.User;

import java.sql.*;
import java.util.ArrayList;

public class Comm_dataDAO {

    private Connection conn;//db에 접근하는 객체
    private ResultSet rs;
    private ResultSet rs2;



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

    public ArrayList<Comm_data> getCommUserID(String userID) {
        String sql = "select * from comm_data where user_id = ?";
        String sql2 = "select comm_address from community where comm_id = ?";
        ArrayList<Comm_data> list = new ArrayList<Comm_data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Comm_data bbs = new Comm_data();
                bbs.setuser_id(rs.getString(1));
                bbs.setcomm_id(rs.getString(2));

                String id1 = rs.getString(1);
                String commid= rs.getString(2);

                //이벤트 아이디 바로넣어서 주소 받아오기
                /*try {*/

                pstmt2.setString(1, commid);
                rs2 = pstmt2.executeQuery();
                if (rs2.next()) {
                    bbs.setcomm_address(rs2.getString(1));
                    String addr = rs2.getString(1);
                }
                list.add(bbs);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
        //  return null;
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

        public ArrayList<Comm> getComm_data(String user_id) throws SQLException {
            String SQL = "SELECT * FROM comm_data WHERE user_id = ?";
            ArrayList<Comm_data> list = new ArrayList<Comm_data>();
            ArrayList<Comm> like_list = null;
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, user_id);
                rs = pstmt.executeQuery();



                while (rs.next()) {
                    Comm_data comm_data = new Comm_data();

                    comm_data.setuser_id(rs.getString(1));
                    comm_data.setcomm_id(rs.getString(2));
                    list.add(comm_data);
                }

                String like_commid = null;
                String SQL2 = "SELECT * FROM community WHERE comm_id = ?";
                like_list = new ArrayList<Comm>();


                for (int i = 0; i < list.size(); i++) {
                    like_commid = list.get(i).getcomm_id();

                    PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
                    pstmt2.setString(1, like_commid);
                    rs2 = pstmt2.executeQuery();

                    while (rs2.next()) {
                        Comm comm2 = new Comm();
                        comm2.setcomm_id(rs2.getString(1));
                        comm2.setcomm_title(rs2.getString(3));
                        comm2.setcomm_preview(rs2.getString(4));
                        comm2.setcomm_picture(rs2.getString(5));
                        comm2.setcomm_info(rs2.getString(6));
                        comm2.setcomm_address(rs2.getString(7));
                        comm2.setcomm_like(rs2.getInt(8));
                        comm2.setcomm_date(rs2.getString(9));
                        comm2.setcomm_picName(rs2.getString(10));
                        comm2.setcomm_score(rs2.getInt(11));

                        like_list.add(comm2);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return like_list;
        }

    public int delete(String user_id,String comm_id) {
        String SQL = "DELETE FROM comm_data WHERE user_id = ? AND comm_id = ?";
        String sql2 = "update community set comm_like= comm_like-1 where comm_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user_id);
            pstmt.setString(2, comm_id);
            pstmt.executeUpdate();

            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setString(1, comm_id);
            pstmt2.executeUpdate();

            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public int check(String user_id, String comm_id) throws SQLException {
        String sql = "select * from comm_data where user_id=? and comm_id=?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            pstmt.setString(2, comm_id);


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