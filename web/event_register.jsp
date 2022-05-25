<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("euc-kr"); %>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.BbsDAO"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>


<!DOCTYPE html>
<html>
<head>
</head>
<body>

<%

    // ���� ���� ���¸� üũ�Ѵ�
    String userID = null;
    if(session.getAttribute("userID") != null){
        userID = (String)session.getAttribute("userID");
    }
    // �α����� �� ����� ���� �� �� �ֵ��� �ڵ带 �����Ѵ�
    if(userID == null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('�α����� �ϼ���')");
        script.println("location.href='login.html'");
        script.println("</script>");
    }else{
        int size = 1024 * 1024 * 20; //20MB
        String path = request.getRealPath("uploadedFiles");
        System.out.println("��Ʈ��Ʈ��Ʈ : "+size);
        String str, filename, original_filename;
        try{
            MultipartRequest multiRequest = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
            // ���۹��� �����Ͱ� ������ ��� getFilesystemName()���� ���� �̸��� �޾ƿ� �� �ִ�.
            //filename = bbs.getEvent_Picture();
            // ���ε��� ������ ��ü ��θ� DB�� �����ϱ� ����
            Enumeration files = multiRequest.getFileNames();
            str = (String)files.nextElement();

            if( multiRequest.getParameter("event_Title") == null|| multiRequest.getParameter("event_Content") == null){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('�Է��� �� �� ������ �ֽ��ϴ�')");
                script.println("history.back()");
                script.println("</script>");
            }else{
                // ���������� �Է��� �Ǿ��ٸ� �۾��� ������ �����Ѵ�
                BbsDAO bbsDAO = new BbsDAO();

                int result = bbsDAO.write(userID,multiRequest.getParameter("event_Title"), multiRequest.getParameter("event_Preview"),
                        multiRequest.getParameter("event_Address"),multiRequest.getParameter("event_Phone"),path
                        , multiRequest.getParameter("event_StartDate"), multiRequest.getParameter("event_EndDate"),multiRequest.getParameter("event_Intro")
                        , multiRequest.getParameter("event_Content"));

                // �����ͺ��̽� ������ ���
                if(result==-1){
                    PrintWriter script= response.getWriter();
                    script.println("<script>");
                    script.println("alert('�۾��⿡ �����߽��ϴ�.')");
                    script.println("history.back()");
                    script.println("</script>");
                }
                else{
                    PrintWriter script= response.getWriter();
                    script.println("<script>");
                    script.println("location.href='event_main.jsp'");
                    script.println("</script>");
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        // �Է��� �� �� �κ��� �ִ��� üũ�Ѵ�

    }

%>
</body>
</html>