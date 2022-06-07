<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.UserDAO" %>
<%@ page import="comm.bbs.BbsDAO" %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<html>
<head>

</head>
<body>

<%

        BbsDAO bbsDAO = new BbsDAO();

        // 현재 세션 상태를 체크한다
        String userID = null;
        int usertype=-1;
        if(session.getAttribute("userID") != null){
            userID = (String)session.getAttribute("userID");
            usertype =bbsDAO.checkType(userID);
        }

        // 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
            if(userID == null){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('로그인을 하세요')");
                script.println("location.href='../login.jsp'");
                script.println("</script>");
            }else if(usertype == 2 || usertype==1){
                response.sendRedirect("event_register.jsp");
            }else{
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('권한이 없습니다.')");
                script.println("location.href='event_main.jsp'");
                script.println("</script>");
            }
%>
</body>
</html>
