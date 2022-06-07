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
        script.println("location.href='login.jsp'");
        script.println("</script>");
    }else{
        int size = 1024 * 1024 * 20; //20MB
        String path = request.getRealPath("uploadedFiles");
        System.out.println("인트인트인트 : "+size);
        String str, filename, original_filename;
        try{
            MultipartRequest multiRequest = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
            // 전송받은 데이터가 파일일 경우 getFilesystemName()으로 파일 이름을 받아올 수 있다.
            Enumeration files = multiRequest.getFileNames();
            str = (String)files.nextElement();
            filename = multiRequest.getFilesystemName(str);
            original_filename = multiRequest.getOriginalFileName(str);

            if (multiRequest.getParameter("event_Title") == null || multiRequest.getParameter("event_Content") == null) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안 된 사항이 있습니다')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                // 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
                BbsDAO bbsDAO = new BbsDAO();
                int e_type=-1;

                String event_type = multiRequest.getParameter("E_TypeRadioOptions");
                if (event_type.equals("fetivaltype")){
                    e_type=1;
                }else {
                    e_type = 2;
                }


                int result = bbsDAO.write(userID, multiRequest.getParameter("event_Title"), multiRequest.getParameter("event_Preview"),
                        multiRequest.getParameter("event_Address") + " " + multiRequest.getParameter("event_detailAddress")
                        , multiRequest.getParameter("event_Phone"), path + "\\" + original_filename , original_filename
                        , multiRequest.getParameter("event_StartDate"), multiRequest.getParameter("event_EndDate"), multiRequest.getParameter("event_Intro")
                        , multiRequest.getParameter("event_manager"), multiRequest.getParameter("event_Content"),e_type,multiRequest.getParameter("event_url"));


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
                    script.println("location.href='event_main.jsp'");
                    script.println("</script>");
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        // 입력이 안 된 부분이 있는지 체크한다

    }

%>
</body>
</html>