<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<% request.setCharacterEncoding("euc-kr"); %>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.BbsDAO"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="bbs.Event_dataDAO" %>


<!DOCTYPE html>
<html>
<head>
</head>
<body>

<%
    // ���� �������� �̵����� �� ���ǿ� ���� ����ִ��� üũ
    String userID = null;
    if(session.getAttribute("userID") != null){
        userID = (String)session.getAttribute("userID");
    }

    // eventID�� �ʱ�ȭ ��Ű��
    // 'eventID'��� �����Ͱ� �Ѿ�� ���� �����Ѵٸ� ĳ������ �Ͽ� ������ ��´�
    String eventID = null;
    if(request.getParameter("eventID") != null){
        eventID = (String)request.getParameter("eventID");
    }

    // ���� �Ѿ�� �����Ͱ� ���ٸ�
    if(eventID.equals("null")){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('��ȿ���� ���� ���Դϴ�')");
        script.println("location.href='event_main.jsp'");
        script.println("</script>");
    }

    Event_dataDAO event_data = new Event_dataDAO();
    int result = event_data.delete(userID, eventID);

    // �����ͺ��̽� ������ ���
    if(result==-1){
                    PrintWriter script= response.getWriter();
                    script.println("<script>");
                    script.println("alert('�����ҿ� �����߽��ϴ�..')");
                    script.println("history.back()");
                    script.println("</script>");
                }
    else{
                    PrintWriter script= response.getWriter();
                    script.println("<script>");
                    script.println("alert('��⸦ ����߽��ϴ�.')");
                    script.println("location.href='event_main.jsp'");
                    script.println("</script>");
                }

%>
</body>
</html>