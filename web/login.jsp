<%@ page contentType="text/html" pageEncoding="utf-8" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>

<% // MySQL JDBC Driver Loading
  String uid = request.getParameter("id");
  String upwd = request.getParameter("ps");

  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn =null;
  Statement stmt =null;
  ResultSet rs =null;
  try {

    String jdbcDriver ="jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=UTC";
    String dbUser ="test"; //mysql id
    String dbPass ="1234"; //mysql password
    String query ="select * from User";//query
    // Create DB Connection
    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
    // Create Statement
    stmt = conn.createStatement();
    // Run Qeury
    rs = stmt.executeQuery(query);
    // Print Result (Run by Query)

    while(rs.next()) {
      String user_email = rs.getString("user_email");
      String user_pswd = rs.getString("user_pswd");

      if (uid.equals(user_email)&&upwd.equals(user_pswd)) {
        //session.setAttribute("id", uid);
        response.sendRedirect("main.html");
        //out.print("로그인 되었습니다.");
        //out.print("메인 페이지입니다.");
      }
      else {
        out.print("로그인 정보가 없습니다.");
      }
    }
  } catch(SQLException ex) {
    out.println(ex.getMessage());
    ex.printStackTrace();
  } finally {
    // Close Statement
    if (rs !=null) try { rs.close(); } catch(SQLException ex) {}
    if (stmt !=null) try { stmt.close(); } catch(SQLException ex) {}
    // Close Connection
    if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
  }
%>
