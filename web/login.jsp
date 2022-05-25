<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!--property의 값을 login.jsp의 값과 동일하게 써주면 login.jsp 페이지의 데이터를 가져온다.-->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width" initial-scale="1">

</head>
<body>

<%
  String userID=null;
  if(session.getAttribute("userID")!=null){
    userID=(String)session.getAttribute("userID");
  }
  if(userID!=null){
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('이미 로그인 되어있습니다.')");
    script.println("location.href='main.html'");
    script.println("</script>");
  }
  UserDAO userDAO = new UserDAO();
  int result =userDAO.login(user.getUserID(),user.getUserPassword());
  System.out.println("로그인2 : "+ user.getUserID()+ " "+user.getUserPassword());
  if(result==1){
    session.setAttribute("userID", user.getUserID());
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("location.href='main.html'");
    script.println("</script>");
  }
  else if(result==0){
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('비밀번호가 틀립니다.')");
    script.println("history.back()");
    script.println("</script>");
  }
  else if(result==-1){
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('존재하지 않는 아이디입니다.')");
    script.println("history.back()");
    script.println("</script>");
  }
  else if(result==-2){
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('데이터베이스 오류가 발생했습니다.')");
    script.println("history.back()");
    script.println("</script>");
  }
%>

</body>
</html>