<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<% request.setCharacterEncoding("euc-kr"); %>
<%@page import="java.io.PrintWriter"%>

<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="comm.Comm_dataDAO" %>


<!DOCTYPE html>
<html>
<head>
</head>
<body>

<%
    // 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
    String userID = null;
    if(session.getAttribute("userID") != null){
        userID = (String)session.getAttribute("userID");
    }

    // eventID를 초기화 시키고
    // 'eventID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
    String commID = null;
    if(request.getParameter("commID") != null){
        commID = (String)request.getParameter("commID");
    }

    // 만약 넘어온 데이터가 없다면
    if(commID.equals("null")){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href='event_main.jsp'");
        script.println("</script>");
    }

    Comm_dataDAO event_data = new Comm_dataDAO();
    int result = event_data.delete(userID, commID);

    // 데이터베이스 오류인 경우
    if(result==-1){
        PrintWriter script= response.getWriter();
        script.println("<script>");
        script.println("alert('담기취소에 실패했습니다..')");
        script.println("history.back()");
        script.println("</script>");
    }
    else{
        PrintWriter script= response.getWriter();
        script.println("<script>");
        script.println("alert('담기를 취소했습니다.')");
        script.println("location.href='event_main.jsp'");
        script.println("</script>");
    }

%>
</body>
</html>