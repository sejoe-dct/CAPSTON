package bbs;

import java.awt.datatransfer.DataFlavor;
import java.sql.*;
import java.util.ArrayList;



public class BbsDAO {

    private Connection conn;
    //private Statement stmt;
    private ResultSet rs;

    //기본 생성자
    public BbsDAO() {
        try {
            String dbURL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul&useUnicode=true&characterEncoding=utf8";
            String dbID = "test";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
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
    public int checkType(String id) {
        int type=0;
        String SQL = "SELECT user_type FROM user WHERE user_id='"+ id + "'";
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery(SQL);
            if (rs.next()) { //rs.next()를 통해 다음행을 내려갈 수 있으면 true를 반환하고, 커서를 한칸 내린다. 다음행이 없으면 false를 반환한다.
                type = rs.getInt("user_type");

            }
            return type;
        } catch (Exception e) {
            // TODO: handle exception
        }

        return -2;

    }


    //글쓰기 메소드
    public int write(  String userID,String event_type, String event_Title, String event_Preview, String event_Address, String event_Phone,
                      String event_Picture,String event_PicName, String event_StartDate, String event_EndDate,
                      String event_Intro, String event_Content) {
        System.out.println("write 함수 테스트1 : "+ event_Title);
        //bbs.Bbs bbs = new bbs.Bbs();
        //String userID = bbs.getUserID();

        int event_Like = 0;
        int event_manager = checkType(userID);//


        Date sDate=Date.valueOf(event_StartDate);//converting string into sql date
        Date eDate=Date.valueOf(event_EndDate);

        String sql = "insert into event values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

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
            pstmt.setInt(13, event_manager);
            pstmt.setString(14, event_type);
            pstmt.setString(15, event_PicName);

            System.out.println("디비 삽입 값 : "+ pstmt);

            return pstmt.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }


    public ArrayList<Bbs> getList(String localName){
        if (localName == "전국") {
            String sql = String.format("SELECT * FROM event");
            ArrayList<Bbs> list =new ArrayList<Bbs>();
            try {
                PreparedStatement pstmt=conn.prepareStatement(sql);
                //      pstmt.setInt(1,getNext()-(pageNumber-1)*10);
                rs=pstmt.executeQuery();
                while(rs.next()) {
                    Bbs bbs=new Bbs();
                    bbs.setEventID(rs.getString(1));
                    bbs.setUserID(rs.getString(2));
                    bbs.setEvent_Title(rs.getString(3));
                    bbs.setEvent_Preview(rs.getString(4));
                    bbs.setEvent_Picture(rs.getString(5));
                    bbs.setEvent_Address(rs.getString(6));
                    bbs.setEvent_Intro(rs.getString(7));
                    bbs.setEvent_Content(rs.getString(8));
                    bbs.setEvent_Phone(rs.getString(9));
                    bbs.setEvent_StartDate(rs.getString(10));
                    bbs.setEvent_EndDate(rs.getString(11));
                    bbs.setEvent_Like(rs.getInt(12));
                    bbs.setEvent_manager(rs.getString(13));
                    bbs.setEvent_type(String.valueOf(rs.getInt(14)));
                    bbs.setEvent_picName(rs.getString(15));
                    list.add(bbs);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list;
        }else{ //기본 값이 아니라 지역명 선택했을 때
            //   String sql = String.format("SELECT * FROM event WHERE localname = " + localName);
            StringBuffer query = new StringBuffer();
            System.out.println("지역명 선택하고 쿼리문 어펜드하기전");
            query.append("SELECT * FROM event WHERE event_address LIKE ?");


            //     String sql = "select * from event where event_address like %" +localName +"%";
            ArrayList<Bbs> list =new ArrayList<Bbs>();
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
                    Bbs bbs=new Bbs();
                    bbs.setEventID(rs.getString(1));
                    bbs.setUserID(rs.getString(2));
                    bbs.setEvent_Title(rs.getString(3));
                    bbs.setEvent_Preview(rs.getString(4));
                    bbs.setEvent_Picture(rs.getString(5));
                    bbs.setEvent_Address(rs.getString(6));
                    bbs.setEvent_Intro(rs.getString(7));
                    bbs.setEvent_Content(rs.getString(8));
                    bbs.setEvent_Phone(rs.getString(9));
                    bbs.setEvent_StartDate(rs.getString(10));
                    bbs.setEvent_EndDate(rs.getString(11));
                    bbs.setEvent_Like(rs.getInt(12));
                    bbs.setEvent_manager(rs.getString(13));
                    bbs.setEvent_type(String.valueOf(rs.getInt(14)));
                    bbs.setEvent_picName(rs.getString(15));
                    list.add(bbs);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list;
        }
        //  String SQL="SELECT * FROM BBS WHERE bbsID<? AND bbsAvailable=1 ORDER BY bbsID DESC LIMIT 10";

    }
}