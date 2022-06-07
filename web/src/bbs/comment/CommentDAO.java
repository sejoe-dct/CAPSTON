package bbs.comment;

import java.sql.*;
import java.util.ArrayList;

public class CommentDAO {
    private Connection conn;
    private ResultSet rs;

    public CommentDAO() {
        try {
            String dbURL = "jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul&useUnicode=true&characterEncoding=utf8";
            String dbID = "test";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver"); //드라이버 로드
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 연결 얻기
            System.out.println("디비연결성공");

        } catch (Exception e) {
            // TODO: handle exception
        }
    }

    public int write(String comm_id, String user_id, String comment_content) {

        String SQL = "insert into comment values(?,?,?,?)";
        String commentID = String.valueOf(getNext());
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, commentID);
            pstmt.setString(2,comm_id);
            pstmt.setString(3, user_id);
            pstmt.setString(4, comment_content);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    //댓글 번호 부여 함수
    public int getNext() {
        //현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
        String sql = "select comment_id from comment order by comment_id desc";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1; //첫 번째 게시물인 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }

    public String getDate() {
        String sql = "select now()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ""; //데이터베이스 오류
    }

    public ArrayList<Comment> getList(String comm_id) {
        ArrayList<Comment> list = new ArrayList<Comment>();

        String sql = "select * from comment where comm_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, comm_id);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Comment comment = new Comment();
                comment.setComment_id(rs.getString(1));
                comment.setCommunity_id(rs.getString(2));
                comment.setUser_id(rs.getString(3));
                comment.setComment_content(rs.getString(4));
                list.add(comment);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //댓글 수정
    public int update(String comment_id, String user_id, String comment_content) {
        String sql = "update comment set comment_content= ? where comment_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, comment_content);
            pstmt.setString(2, comment_id);
            return pstmt.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }

    //댓글 삭제
    public int delete(String commentID) {
        int comment_id = Integer.parseInt(commentID);
        //실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으로 수정한다
        String sql = "delete from comment where comment_id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, comment_id);
            return pstmt.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }

    public Comment getCommentDetail(String commentID) {
        String sql = "select * from comment where comment_id = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, commentID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                Comment comment = new Comment();
                comment.setComment_id(rs.getString(1));
                comment.setCommunity_id(rs.getString(2));
                comment.setUser_id(rs.getString(3));
                comment.setComment_content(rs.getString(4));
                return comment;
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


}




