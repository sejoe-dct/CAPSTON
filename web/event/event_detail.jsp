<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="en">
<!DOCTYPE html>
<html lang="en">
<%
    // 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
    String userID = null;
    if(session.getAttribute("userID") != null){
        userID = (String)session.getAttribute("userID");
    }

    // eventID를 초기화 시키고
    // 'eventID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
    int eventID = 0;
    if(request.getParameter("eventID") != null){
        System.out.println("이벤트 아이디 : "+eventID);
        eventID = Integer.parseInt(request.getParameter("eventID"));
    }

    // 만약 넘어온 데이터가 없다면
    if(eventID == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href='event_main.jsp'");
        script.println("</script>");
    }

    // 유효한 글이라면 구체적인 정보를 'evnet'라는 인스턴스에 담는다
    Bbs event = new BbsDAO().getEventDetail(eventID);
%>

<head>
    <jsp:directive.include file="event_head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="event_nav.jsp"/>

<!-- 게시판 Start -->
<div class="container-xxl py-5">
    <div class="container">
        <div class="container-xxl py-5">
            <%
                Connection conn =null;
                Statement stmt =null;
                ResultSet rs =null;
            %>
            <div class="container">
                <div class="container bootstrap snippets bootdey" >
                    <div class="row" >
                        <div class="col-md-6">
                            <div class="pro-img-details" >
                                <%--                                <img src="<%=list.get(0).getEvent_Picture()%>" alt="<%=list.get(0).getEvent_Title()%>>">--%>
                            </div>
                        </div>
                        <div class="col-sm-6 push-bit" style="padding: 10px;">
                            <div class="clearfix" enctype="multipart/form-data" >
                                <span class="h4" >

                                    <h3  class="text-success"><%=event.getEvent_Title()%></h3><br />
                                </span>
                                <div class="text-end">
                                    <p><%=event.getEvent_Address()%></p>
                                </div>
                                <hr />
                                <h6><%=event.getEvent_Content()%></h6>
                            </div>
                        </div>
                    </div>
                    <!-- detail End -->

                    <hr/>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 게시판 End -->

<!-- Footer Start -->
<jsp:directive.include file="../fragment/footer.jsp"/>
<!-- Footer End -->

<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/wow/wow.min.js"></script>
<script src="..static/lib/easing/easing.min.js"></script>
<script src="../static/lib/waypoints/waypoints.min.js"></script>
<script src="../static/lib/counterup/counterup.min.js"></script>
<script src="../static/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="../static/lib/isotope/isotope.pkgd.min.js"></script>
<script src="../static/lib/lightbox/js/lightbox.min.js"></script>

<!-- Template Javascript -->
<script src="../static/js/main.js"></script>
</body>


</html>
</html>
