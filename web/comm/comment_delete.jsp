comment_delete.jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.Comment" %>


<%

    // 현재 세션 상태를 체크한다
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    // 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href='../login.jsp'");
        script.println("</script>");
    }

    String commID = null;
    if (request.getParameter("commentID") != null) {
        commID = request.getParameter("commID");
        System.out.println("딜리트 ㅋ댓글컴 아이디 : " + commID);

    }
    String commentID = null;
    if (request.getParameter("commentID") != null) {
        commentID = request.getParameter("commentID");
        System.out.println("코멘트 아이디 : " + commentID);

    }

    if (commentID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href='comm_main.jsp'");
        script.println("</script>");
    }
    //해당 'commentID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다
    Comment comment = new CommentDAO().getCommentDetail(commentID);


    if (!userID.equals(comment.getUser_id())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다')");
        script.println("location.href='comment_detail.jsp'");
        script.println("</script>");
    } else {
        // 글 삭제 로직을 수행한다
        CommentDAO commentDAO = new CommentDAO();
        int result = commentDAO.delete(commentID);
        // 데이터베이스 오류인 경우
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('댓글 수정 실패')");

            script.println("history.back()");
            script.println("</script>");
            // 글 삭제가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
        } else {
            //커뮤니티 세션
            //session.setAttribute("commID", commID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            System.out.println("댁글 삭제성공 스크립트");
            script.println("alert('댓글 삭제하기 성공')");
            script.println("location.href='comm_main.jsp'");
            //script.println("history.go(0)");
            //script.println("location.href='comm_detail.jsp?commID='"+commID);
            script.println("</script>");
        }
    }

%>