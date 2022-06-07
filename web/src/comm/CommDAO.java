package comm;
import user.User;

import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class CommDAO {
    private Connection conn;
    private ResultSet rs;
    private ResultSet rs2;
    private ResultSet rs3;
    private ResultSet rs4;

    public CommDAO() {
        try {
            String dbURL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul&useUnicode=true&characterEncoding=utf8";
            String dbID = "test";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver"); //드라이버 로드
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 연결 얻기
            System.out.println("디비연결성공");
            // Type mismatch: cannot convert from java.sql.Connection to com.sun.corba.se.pept.transport.Connection
            // import 확인 하기

        } catch (Exception e) {
            // TODO: handle exception
        }
    }

    public int write(String user_id, String comm_title
            , String comm_preview, String comm_picture, String comm_picName
            , String comm_address, String comm_info , int comm_score
    ) {
        int comm_like = 0;

        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        // 포맷 적용
        String formatedNow = now.format(formatter);
        Date cDate=Date.valueOf(formatedNow);
        String SQL = "insert into community values(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, user_id);
            pstmt.setString(3, comm_title);
            pstmt.setString(4, comm_preview);
            pstmt.setString(5, comm_picture);
            pstmt.setString(6, comm_info);
            pstmt.setString(7, comm_address);
            pstmt.setInt(8, comm_like);
            pstmt.setDate(9, cDate);
            pstmt.setString(10, comm_picName);
            pstmt.setInt(11, comm_score);

            //rs = pstmt.executeQuery();
            //System.out.println(SQL);
            return pstmt.executeUpdate();
        }catch(Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public int modify(String comm_id, String comm_title, String comm_preview,String comm_picture, String comm_picName,
                      String comm_address, String comm_info , int comm_score
    ) {
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        // 포맷 적용
        String formatedNow = now.format(formatter);
        Date cDate=Date.valueOf(formatedNow);
        //String SQL = "insert into community values(?,?,?,?,?,?,?,?,?,?,?)";
        String SQL = "update community set comm_title =?, comm_preview=?, " +
                "comm_picture=?, comm_info=?, " +
                "comm_address=?, comm_picName=?, comm_score=? " +
                "where comm_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            //pstmt.setInt(1, getNext());
            //pstmt.setString(2, user_id);
            pstmt.setString(1, comm_title);
            pstmt.setString(2, comm_preview);
            pstmt.setString(3, comm_picture);
            pstmt.setString(4, comm_info);
            pstmt.setString(5, comm_address);
            //pstmt.setInt(8, comm_like);
            //pstmt.setDate(9, cDate);
            pstmt.setString(6, comm_picName);
            pstmt.setDouble(7, comm_score);

            pstmt.setString(8, comm_id);

            //rs = pstmt.executeQuery();
            System.out.println(pstmt);
            return pstmt.executeUpdate();
        }catch(Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    //게시글 번호 부여 함수
    public int getNext() {
        //현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
        String sql = "select comm_id from community ORDER BY LPAD(comm_id, 3,'0') desc";
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
    public String getDate() {
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

    public ArrayList<Comm> getList(String localName, String search) {
        if (localName.equals("전국")) {
            localName = "";
        }
        StringBuffer query = new StringBuffer();
        System.out.println("지역명 선택하고 쿼리문 어펜드하기전");
        query.append("SELECT * FROM community WHERE comm_address LIKE ? AND CONCAT(comm_title, comm_preview, comm_info) LIKE ?");
        //     String sql = "select * from event where event_address like %" +localName +"%";
        ArrayList<Comm> list = new ArrayList<Comm>();
        try {
            PreparedStatement psmt = conn.prepareStatement(query.toString());
            psmt.setString(1, "%" + localName + "%"); //"KSC5601"),"8859_1"//1트
            psmt.setString(2, "%" + search + "%");
            rs = psmt.executeQuery();
            while (rs.next()) {
                System.out.println("while문");
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
        return list;

        //  String SQL="SELECT * FROM BBS WHERE bbsID<? AND bbsAvailable=1 ORDER BY bbsID DESC LIMIT 10";

    }

    public ArrayList<Comm> getUserlist(String user_id){
        StringBuffer query = new StringBuffer();
        query.append("Select * from community where user_id=?");

        ArrayList<Comm> list = new ArrayList<Comm>();

        try {
            PreparedStatement psmt=conn.prepareStatement(query.toString());
            psmt.setString(1, user_id); //"KSC5601"),"8859_1"//1트
            rs=psmt.executeQuery();

            while(rs.next()) {
                System.out.println("while문");
                Comm user_comm=new Comm();
                user_comm.setcomm_id(rs.getString(1));
                user_comm.setuser_id(rs.getString(2));
                user_comm.setcomm_title(rs.getString(3));
                user_comm.setcomm_preview(rs.getString(4));
                user_comm.setcomm_picture(rs.getString(5));
                user_comm.setcomm_info(rs.getString(6));
                user_comm.setcomm_address(rs.getString(7));
                user_comm.setcomm_like(rs.getInt(8));
                user_comm.setcomm_date(rs.getString(9));
                user_comm.setcomm_picName(rs.getString(10));
                user_comm.setcomm_score(rs.getInt(11));

                list.add(user_comm);
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public ArrayList<Comm> getUserlist_detail(String comm_id){
        StringBuffer query = new StringBuffer();
        query.append("Select * from community where comm_id=?");

        ArrayList<Comm> list = new ArrayList<Comm>();

        try {
            PreparedStatement psmt=conn.prepareStatement(query.toString());
            psmt.setString(1, comm_id); //"KSC5601"),"8859_1"//1트
            rs=psmt.executeQuery();

            while(rs.next()) {
                System.out.println("while문");
                Comm user_comm=new Comm();
                user_comm.setcomm_id(rs.getString(1));
                user_comm.setuser_id(rs.getString(2));
                user_comm.setcomm_title(rs.getString(3));
                user_comm.setcomm_preview(rs.getString(4));
                user_comm.setcomm_picture(rs.getString(5));
                user_comm.setcomm_info(rs.getString(6));
                user_comm.setcomm_address(rs.getString(7));
                user_comm.setcomm_like(rs.getInt(8));
                user_comm.setcomm_date(rs.getString(9));
                user_comm.setcomm_picName(rs.getString(10));
                user_comm.setcomm_score(rs.getInt(11));

                list.add(user_comm);
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public Comm getCommDetail(int commID) {
        String sql = "select * from community where comm_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                Comm comm=new Comm();

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

                return comm;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int delete(String commID) {
        int comm_id = Integer.parseInt(commID);
        //실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으로 수정한다
        String sql = "delete from community where comm_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, comm_id);
            return pstmt.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }


    public ArrayList<Comm> getComm_recom(String user_id) {
        String sql = "select * from user where user_id = ? ";
        ArrayList<User> session_user_list = new ArrayList<User>();

        try{
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,user_id);
            //pstmt0.setString(1, user_id);
            rs=pstmt.executeQuery();
            while(rs.next()){
                User user=new User();
                //user.setUserID(rs.getString(1));
                //user.setUserName(rs.getString(2));
                //user.setUserPassword(rs.getString(3));
                //user.setUserNickname(rs.getString(4));
                //user.setUserEmail(rs.getString(5));
                //user.setUserType(rs.getInt(6));
                user.setUserSex(rs.getString(7));
                user.setUserAge(rs.getInt(8));
                user.setUserFv1(rs.getString(9));
                user.setUserFv2(rs.getString(10));
                user.setUserFv3(rs.getString(11));

                session_user_list.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String sql2 = "select user_id from user " +
                "where user_sex=? and user_fv1=? and user_fv2=? and user_fv3=? and user_id != ?";
        ArrayList<User> sm_user_list = new ArrayList<User>();

        try{
            PreparedStatement pstmt = conn.prepareStatement(sql2);

            pstmt.setString(1, String.valueOf(session_user_list.get(0).getUserSex()));
            pstmt.setString(2, String.valueOf(session_user_list.get(0).getUserFv1()));
            pstmt.setString(3, String.valueOf(session_user_list.get(0).getUserFv2()));
            pstmt.setString(4, String.valueOf(session_user_list.get(0).getUserFv3()));
            pstmt.setString(5, user_id);


            rs2=pstmt.executeQuery();
            while(rs2.next()){
                User sm_user = new User();
                sm_user.setUserID(rs2.getString(1));
                sm_user_list.add(sm_user);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String sql3 = "select comm_id from comm_data where user_id=?";
        ArrayList<Comm_data> sm_user_like_list = new ArrayList<Comm_data>();

        try{
            for(int i=0; i<sm_user_list.size(); i++) {
                PreparedStatement pstmt = conn.prepareStatement(sql3);
                pstmt.setString(1, String.valueOf(sm_user_list.get(i).getUserID()));

                rs3 = pstmt.executeQuery();
                while (rs3.next()) {
                    Comm_data rc_comm_id = new Comm_data();
                    rc_comm_id.setcomm_id(rs3.getString(1));
                    sm_user_like_list.add(rc_comm_id);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        String sql4 = "select * from community where comm_id=?";
        ArrayList<Comm> rc_comm_list = new ArrayList<Comm>();

        try{
            for(int i=0; i<sm_user_like_list.size(); i++) {
                PreparedStatement pstmt = conn.prepareStatement(sql4);
                pstmt.setString(1, String.valueOf(sm_user_like_list.get(i).getcomm_id()));

                rs4 = pstmt.executeQuery();
                while (rs4.next()) {
                    Comm rc_comm = new Comm();
                    rc_comm.setcomm_id(rs4.getString(1));
                    rc_comm.setuser_id(rs4.getString(2));
                    rc_comm.setcomm_title(rs4.getString(3));
                    rc_comm.setcomm_preview(rs4.getString(4));
                    rc_comm.setcomm_picture(rs4.getString(5));
                    rc_comm.setcomm_info(rs4.getString(6));
                    rc_comm.setcomm_address(rs4.getString(7));
                    rc_comm.setcomm_like(rs4.getInt(8));
                    rc_comm.setcomm_date(rs4.getString(9));
                    rc_comm.setcomm_picName(rs4.getString(10));
                    rc_comm.setcomm_score(rs4.getInt(11));

                    rc_comm_list.add(rc_comm);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rc_comm_list;
    }


}







