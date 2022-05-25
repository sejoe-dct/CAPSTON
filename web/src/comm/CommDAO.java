package comm;


import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class CommDAO {
    private Connection conn;
    private ResultSet rs;

    public CommDAO() {
        try {
            String dbURL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul";
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
            , String comm_preview, String comm_picture
            , String comm_address, String comm_info
            , int comm_score) {
        int comm_like = 0;
        /*String sDdate= getDate();
        Date cDate=Date.valueOf(sDdate);//converting string into sql date*/
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        // 포맷 적용
        String formatedNow = now.format(formatter);
        //String sDdate= getDate();
        Date cDate=Date.valueOf(formatedNow);
        String SQL = "insert into community values(?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, user_id);
            pstmt.setString(3, comm_title);
            pstmt.setString(4, comm_preview);
            pstmt.setString(5, comm_picture);
            pstmt.setString(6, comm_address);
            pstmt.setString(7, comm_info);
            pstmt.setInt(8, comm_score);
            pstmt.setInt(9, comm_like);
            pstmt.setDate(10, cDate);

            //rs = pstmt.executeQuery();
            //System.out.println(SQL);
            return pstmt.executeUpdate();
        }catch(Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    //게시글 번호 부여 함수
    public int getNext() {
        //현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
        String sql = "select comm_id from community order by comm_id desc";
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

    public ArrayList<Comm> getList(String localName){
        if (localName == "전국") {
            String sql = String.format("SELECT * FROM community");
            ArrayList<Comm> list =new ArrayList<Comm>();
            try {
                PreparedStatement pstmt=conn.prepareStatement(sql);

                rs=pstmt.executeQuery();
                while(rs.next()) {
                    Comm comm=new Comm();
                    comm.setcomm_id(rs.getString(1));
                    comm.setuser_id(rs.getString(2));
                    comm.setcomm_title(rs.getString(3));
                    comm.setcomm_preview(rs.getString(4));
                    comm.setcomm_picture(rs.getString(5));
                    comm.setcomm_info(rs.getString(6));
                    comm.setcomm_address(rs.getString(7));
                    comm.setcomm_score(rs.getInt(8));
                    comm.setcomm_like(rs.getInt(9));
                    comm.setcomm_date(rs.getString(10));

                    list.add(comm);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list;
        }else{ //기본 값이 아니라 지역명 선택했을 때
            //   String sql = String.format("SELECT * FROM event WHERE localname = " + localName);
            StringBuffer query = new StringBuffer();
            System.out.println("지역명 선택하고 쿼리문 어펜드하기전");
            query.append("SELECT * FROM community WHERE comm_address LIKE ?");


            //     String sql = "select * from event where event_address like %" +localName +"%";
            ArrayList<Comm> list =new ArrayList<Comm>();
            try {
                System.out.println("try문 들어옴");
                PreparedStatement psmt=conn.prepareStatement(query.toString());
                //     PreparedStatement psmt=  conn.prepareStatement(new String(query.toString().getBytes("KSC5601"), "8859_1")+"%");
                System.out.println("try문 들어옴 local name = "+localName);
                psmt.setString(1, "%"+localName+"%"); //"KSC5601"),"8859_1"//1트
                //psmt.setString(1, "%"+new String(localName.getBytes("8859_1"), "euc-kr")+"%");
                //         String ppssmmtt=new String( psmt.setString(1, "%"+localName+"%").getBytes("8859_1"), "euc-kr")+"%");
                System.out.println("try문 들어옴");
                //      pstmt.setInt(1,getNext()-(pageNumber-1)*10);
                rs=psmt.executeQuery();
                System.out.println("try문 들어옴");
                while(rs.next()) {
                    System.out.println("while문");
                    Comm comm=new Comm();
                    comm.setcomm_id(rs.getString(1));
                    comm.setuser_id(rs.getString(2));
                    comm.setcomm_title(rs.getString(3));
                    comm.setcomm_preview(rs.getString(4));
                    comm.setcomm_picture(rs.getString(5));
                    comm.setcomm_info(rs.getString(6));
                    comm.setcomm_address(rs.getString(7));
                    comm.setcomm_score(rs.getInt(8));
                    comm.setcomm_like(rs.getInt(9));
                    comm.setcomm_date(rs.getString(10));
                    list.add(comm);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list;
        }
        //  String SQL="SELECT * FROM BBS WHERE bbsID<? AND bbsAvailable=1 ORDER BY bbsID DESC LIMIT 10";

    }

}