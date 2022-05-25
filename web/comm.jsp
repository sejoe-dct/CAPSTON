<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="comm.CommDAO" %>
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
    String user_id = null;
    if (session.getAttribute("userID") != null) {
        user_id = (String) session.getAttribute("userID");
    }
    // 로그인을 한 사람만 글을 쓸 수 있도록 코드 수정
    if (user_id == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href='login.html'");
        script.println("</script>");
    } else {
        int size = 1024 * 1024 * 20; //20MB
        String path = request.getRealPath("uploadedFiles");
        String str, filename, original_filename;
        try {
            MultipartRequest multiRequest = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
            // 전송받은 데이터가 파일일 경우 getFilesystemName()으로 파일 이름을 받아올 수 있다.

            Enumeration files = multiRequest.getFileNames();
            str = (String)files.nextElement();
            filename = multiRequest.getFilesystemName(str);
            original_filename = multiRequest.getOriginalFileName(str);


            // 입력이 안 된 부분이 있는지 체크한다
            if ( multiRequest.getParameter("comm_title")== null || multiRequest.getParameter("comm_info") == null) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안 된 사항이 있습니다')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                // 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
                //PrintWriter script = response.getWriter();
                CommDAO commDAO = new CommDAO();

                int result = commDAO.write(user_id, multiRequest.getParameter("comm_title"),
                        multiRequest.getParameter("comm_preview"), path+"\\"+original_filename
                        , multiRequest.getParameter("comm_address"), multiRequest.getParameter("comm_info")
                        , Integer.parseInt(multiRequest.getParameter("comm_score")));
                // 데이터베이스 오류인 경우
                if (result == -1) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('글쓰기에 실패했습니다.')");
                    script.println("history.back()");
                    script.println("</script>");
                } else {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("location.href='main.html'");
                    script.println("</script>");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>