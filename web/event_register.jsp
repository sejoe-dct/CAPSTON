<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.BbsDAO"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property ="event_Title"/>
<jsp:setProperty name="bbs" property ="event_Preview"/>
<jsp:setProperty name="bbs" property ="event_Address"/>
<jsp:setProperty name="bbs" property ="event_Phone"/>
<jsp:setProperty name="bbs" property ="event_Picture"/>
<jsp:setProperty name="bbs" property ="event_StartDate"/>
<jsp:setProperty name="bbs" property ="event_EndDate"/>
<jsp:setProperty name="bbs" property ="event_Intro"/>
<jsp:setProperty name="bbs" property ="event_Content"/>


<!DOCTYPE html>
<html>
<head>
</head>
<body>

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
        script.println("location.href='login.html'");
        script.println("</script>");
    }else{
        // 입력이 안 된 부분이 있는지 체크한다
        if( bbs.getEvent_Title() == null|| bbs.getEvent_Content() == null){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다')");
            script.println("history.back()");
            script.println("</script>");
        }else{
            // 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
            //PrintWriter script = response.getWriter();
            BbsDAO bbsDAO = new BbsDAO();


            int result = bbsDAO.write(userID,bbs.getEvent_Title(), bbs.getEvent_Preview(),bbs.getEvent_Address(),bbs.getEvent_Phone()
                    ,"", bbs.getEvent_StartDate(), bbs.getEvent_EndDate(),bbs.getEvent_Intro(), bbs.getEvent_Content());


            // 데이터베이스 오류인 경우
            if(result==-1){
                PrintWriter script= response.getWriter();
                script.println("<script>");
                script.println("alert('글쓰기에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }
            else{
                PrintWriter script= response.getWriter();
                script.println("<script>");
                script.println("location.href='main.html'");
                script.println("</script>");
            }
        }
    }

%>
</body>
</html>