<%@ page import="java.io.PrintWriter" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%

    // 현재 세션 상태를 체크한다
    String userID = null;
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
    }else{
        response.sendRedirect("recommend.jsp");
    }
%>
</html>
