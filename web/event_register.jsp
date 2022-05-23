<%@ page contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<html>
<%

    request.setCharacterEncoding("utf-8");

    String path = request.getRealPath("uploadedFiles");
    int size = 1024 * 1024 * 20; //20MB
    String str, filename, original_filename;
    ;
    try{
        MultipartRequest multiRequest = new MultipartRequest(request, path, size, "EUC-KR", new DefaultFileRenamePolicy());

        Enumeration files = multiRequest.getFileNames();
        str = (String)files.nextElement();
        filename = multiRequest.getFilesystemName(str);
        original_filename = multiRequest.getOriginalFileName(str);

        //System.out.println("str : "+str);
        //System.out.println("filename : "+filename);
        //System.out.println("original_filename : "+original_filename);


    String etitle = request.getParameter("eventtitle");
    String epreview = request.getParameter("eventpreview");
    String eaddress = request.getParameter("eventaddress");
    String ephone = request.getParameter("eventphone");
    String epicture = request.getParameter("eventpicture");
    String estartdate = request.getParameter("eventstartdate");
    String eenddate = request.getParameter("eventenddate");
    String eintro = request.getParameter("eventintro");
    String econtent = request.getParameter("eventcontent");

    String eid = "e1";
    String uid = "qq";

    String sql = "INSERT INTO Event(user_id, event_title, event_preview, event_address, event_phone, event_picture, " +
            "event_intro, event_content) VALUES";


    sql += "('"  + eid + "', '" + uid + "', '" + etitle + "', '" + epreview + "', '" + eaddress + "', '" + ephone + "', '" + path + "', '"
            + estartdate + "', '" + eenddate + "', '" + eintro + "', '" + econtent +  "')";

    out.println(sql);

    Class.forName("com.mysql.cj.jdbc.Driver");


    Connection conn = DriverManager.getConnection("jdbc:mysql://101.101.209.72:3306/cap?serverTimezone=Asia/Seoul", "test", "1234");
    Statement stmt = conn.createStatement();

    int count = stmt.executeUpdate(sql);
    if (count == 1) {
        out.println("이벤트 등록이 완료되었습니다.");
    }
    else {
        out.println("이벤트 등록 중 오류가 발생하었습니다.");
    }
    stmt.close(); conn.close();

    } catch (Exception e){
        e.printStackTrace();
    }
%>
</html>