<%@ page import="java.util.ArrayList" %>
<%@ page import="comm.Comm_data" %>
<%@ page import="comm.Comm" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>체크박스 리스트 테스트 페이지</title>
</head>
<body>
    <ul>
        <%
            //체크박스 값 배열로 저장
            String[] likelangs = request.getParameterValues("likeitem");

            //배열 to 리스트
            ArrayList<String> likelist = new ArrayList<String>(Arrays.asList(likelangs));
            System.out.println(likelist);

        %>
    </ul>
</body>
</html>
