<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="comm.CommDAO" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>

<!DOCTYPE html>
<html>
<head>
    <jsp:directive.include file="mypage_head.jsp"/>

</head>
<body>
<%
    //선택한 게시물 ID 받아오기
    String commID = null;
    if(request.getParameter("commID") != null){
        System.out.println("이벤트 아이디 : "+commID);
        commID = (request.getParameter("commID"));
    }

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
        if ( multiRequest.getParameter("comm_title")== null || multiRequest.getParameter("mp_comm_address") == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            // 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
            //PrintWriter script = response.getWriter();
            CommDAO commDAO = new CommDAO();


            // 만약 넘어온 데이터가 없다면
            if(commID.equals(null)){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('유효하지 않은 글입니다')");
                script.println("location.href='event_main.jsp'");
                script.println("</script");

                // 유효한 글이라면 구체적인 정보를 'evnet'라는 인스턴스에 담는다
                //Bbs event = new BbsDAO().getEventDetail(eventID);
            }

            String comm_id = commID;
            System.out.println(comm_id);

            int result = commDAO.modify(comm_id, multiRequest.getParameter("comm_title"), multiRequest.getParameter("comm_preview"),
                    path+"\\"+original_filename,original_filename,
                    multiRequest.getParameter("mp_comm_address") + " " + multiRequest.getParameter("mp_comm_detailAddress"),
                    multiRequest.getParameter("comm_info"), (int) Double.parseDouble(multiRequest.getParameter("comm_score")));



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
                script.println("location.href='mypage_list.jsp'");
                script.println("</script>");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>