<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<% request.setCharacterEncoding("euc-kr"); %>
<%@page import="java.io.PrintWriter"%>
<%@page import="comm.bbs.BbsDAO"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="comm.bbs.Event_dataDAO" %>
<%@ page import="comm.Comm_dataDAO" %>


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
    String commID = null;
    if(request.getParameter("commID") != null){
        System.out.println("�̺�Ʈ ���̵� : "+commID);
        commID = (String)request.getParameter("commID");
    }

    // ���� �Ѿ�� �����Ͱ� ���ٸ�
    if(commID.equals("null")){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('��ȿ���� ���� ���Դϴ�')");
        script.println("location.href='comm_main.jsp'");
        script.println("</script>");
    }

    Comm_dataDAO comm_data = new Comm_dataDAO();
    int result = comm_data.write(userID, commID);

    // �����ͺ��̽� ������ ���
    if(result==-1){
        PrintWriter script= response.getWriter();
        script.println("<script>");
        script.println("alert('��⿡ �����߽��ϴ�..')");
        script.println("history.back()");
        script.println("</script>");
    }
    else{
                    PrintWriter script= response.getWriter();
                    script.println("<script>");
                    script.println("alert('��ҽ��ϴ�.')");
                    script.println("location.href='comm_main.jsp'");
                    script.println("</script>");
                }

%>
</body>
</html>