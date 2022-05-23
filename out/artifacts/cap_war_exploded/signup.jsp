<%@ page contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<%

    request.setCharacterEncoding("utf-8");

    String uid = request.getParameter("id");
    String uemail = request.getParameter("email");
    String upswd = request.getParameter("ps");
    String uname = request.getParameter("name");
    String unickname = request.getParameter("nickname");
    int utype = 3;
    String usex = "F";
    int uage = 24;
    String ufv1 = "친구";
    String ufv2 = "조용한";
    String ufv3 = "자연친화적인";


    String sql = "INSERT INTO User(user_id, user_name, user_pswd, user_nickname, user_email, " +
            "user_type, user_sex, user_age, user_fv1, user_fv2, user_fv3) VALUES";
    //sql += "('" + uemail + "', '" + uid + "', '" + uname + "', '" + upswd + "', '" + unickname + "')";

    sql += "('"  + uid + "', '" + uname + "', '" + upswd + "', '" + unickname + "', '" + uemail + "', '"
            + utype + "', '" + usex + "', '" + uage + "', '" + ufv1 + "', '" + ufv2 + "', '" + ufv3 + "')";

    out.println(sql);

    Class.forName("com.mysql.cj.jdbc.Driver");


    Connection conn = DriverManager.getConnection("jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul", "test", "1234");
    Statement stmt = conn.createStatement();

    int count = stmt.executeUpdate(sql);
    if (count == 1) {
        out.println("회원 가입이 완료되었습니다.");
    }
    else {
        out.println("회원 가입 중 오류가 발생하었습니다.");
    }
    stmt.close(); conn.close();
%>
</html>