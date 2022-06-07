comment_write.jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.comment.CommentDAO" %>


<%

    // 현재 세션 상태를 체크한다
    String userID = null;
    String commID = null;
    if(session.getAttribute("userID") != null){
        userID = (String)session.getAttribute("userID");
    }
    // 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
    if(userID == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href='../login.jsp'");
        script.println("</script>");
    }else {
        if (request.getParameter("commID") != null) {
            commID =request.getParameter("commID");
            System.out.println("댓글쓰기 1 "+commID);
        }
        //
        if (commID == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글입니다')");
            script.println("location.href='comm_main.jsp'");
            script.println("</script>");
        } else {
            try {
                if (request.getParameter("comment_content") == null) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('댓글을 입력해주세요')");
                    script.println("history.back()");
                    script.println("</script>");
                } else {
                    // 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
                    System.out.println("댓글쓰기 2 "+commID);

                    CommentDAO commentDAO = new CommentDAO();
                    int result = commentDAO.write(commID, userID, request.getParameter("comment_content"));
                    // 데이터베이스 오류인 경우
                    if (result == -1) {
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('댓글쓰기에 실패했습니다.')");
                        script.println("history.back()");
                        script.println("</script>");
                    } else {
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        //comm_detail.jsp?commID=
                        script.println("location.href='comm_main.jsp'");
                        //script.println("history.back()");
                        script.println("</script>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            // 입력이 안 된 부분이 있는지 체크한다

        }
    }
%>