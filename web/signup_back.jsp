<%@ page contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<html>
<%

    request.setCharacterEncoding("utf-8");

    String uid = request.getParameter("id");
    String uemail = request.getParameter("email");
    String uage = request.getParameter("age");
    String upswd = request.getParameter("ps");
    String uname = request.getParameter("name");
    String unickname = request.getParameter("nickname");

    String usertype = request.getParameter("TypeRadioOptions");
    int utype=-1;
    if(usertype.equals("ceo")){
        utype=2;
    }else{
        utype=3;
    }
    String ugender = request.getParameter("GenderRadioOptions");

    String ufv1 = request.getParameter("fv1");
    String ufv2 = request.getParameter("fv2");
    String ufv3 = request.getParameter("fv3");

    String sql = "INSERT INTO user(user_id, user_name, user_pswd, user_nickname, user_email, " +
            "user_type, user_sex, user_age, user_fv1, user_fv2, user_fv3) VALUES";
    //sql += "('" + uemail + "', '" + uid + "', '" + uname + "', '" + upswd + "', '" + unickname + "')";

    sql += "('"  + uid + "', '" + uname + "', '" + upswd + "', '" + unickname + "', '" + uemail + "', '"
            + utype + "', '" + ugender + "', '" + uage + "', '" + ufv1 + "', '" + ufv2 + "', '" + ufv3 + "')";

    out.println(sql);

    Class.forName("com.mysql.cj.jdbc.Driver");


    Connection conn = DriverManager.getConnection("jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul&useUnicode=true&characterEncoding=utf8", "test", "1234");
    Statement stmt = conn.createStatement();

    int count = stmt.executeUpdate(sql);
    if (count == 1) {
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입이 완료되었습니다.')");
        script.println("location.href='login.html'");
        script.println("</script>");
    }
    else {
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입에 실패하였습니다.')");
        script.println("location.href='signup.html'");
        script.println("</script>");
    }
    stmt.close(); conn.close();
%>
</html>