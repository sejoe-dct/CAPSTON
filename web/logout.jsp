<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html" pageEncoding="utf-8" %>
<%
    session.invalidate();
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('로그아웃 하였습니다.')");
    script.println("location.href='index.jsp'");
    script.println("</script>");
%>
