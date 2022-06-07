<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@page import="comm.Comm" %>
<%@page import="comm.CommDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="comm.Comm_dataDAO" %>
<%@ page import="bbs.Event_dataDAO" %>
<%@ page import="bbs.BbsDAO" %>

<html lang="en">
<head>
    <jsp:directive.include file="recommend_head.jsp"/>

    <!-- Font Awesome Icon Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .checked {
            color: orange;
        }

        .img-fluidd {
            weight:400px;
            height: 270px;
        }
    </style>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="recommend_nav.jsp"/>

<%
    String session_id=String.valueOf(session.getAttribute("userID"));

    Connection conn =null;
    Statement stmt =null;
    ResultSet rs =null;

    CommDAO commDAO=new CommDAO();
    BbsDAO eventdataDAO = new BbsDAO();

    ArrayList<Comm> comm_list = commDAO.getComm_recom(session_id);
    ArrayList<Bbs> eventlist = eventdataDAO.getEvent_recom(session_id);
%>

<!-- 게시판 Start -->
<div class="container-xxl py-5">
    <div class="container">
        <!-- 제목 / 소제목 -->
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">여행지 추천</h6>
            <h2 class="mb-4">비슷한 사용자가 좋아요 누른 여행지를 추천드립니당~!</h2>
        </div>
       <!-- 여행지 추천 게시판 Start -->
        <div class="row g-4">
            <%
                for (int i = comm_list.size() - 1; i >= 0; i--) {
            %>
            <div class="col-md-6 col-lg-4 wow fadeInUp" data-wow-delay="0.1s">
                <div class="service-item rounded overflow-hidden">
                    <img class="img-fluidd" width="400px" height="270px" src="<%="http://localhost:8888//uploadedFiles/"+comm_list.get(i).getComm_picName()%>" alt="">
<%--                    <img src="<%="http://localhost:8888//uploadedFiles/"+list.get(i).getComm_picName()%>"--%>
<%--                         alt="<%=list.get(i).getcomm_title()%>">--%>
                    <div class="position-relative p-4 pt-0">
                        <div class="service-icon">
                            <i class="bi bi-hand-thumbs-up"></i>
                        </div>
                        <h4 class="mb-3"><%=comm_list.get(i).getcomm_title()%></h4>
                        <p><%=comm_list.get(i).getcomm_preview()%></p>
                        <a class="small fw-medium" href="">더보기><i class="fa fa-arrow-right ms-2"></i></a>
                    </div>
                </div>
            </div>
            <%
                }
            %>

            <!-- Event 게시물 추천 Start -->
            <%
                for (int i = eventlist.size() - 1; i >= 0; i--) {
            %>
            <div class="col-md-6 col-lg-4 wow fadeInUp" data-wow-delay="0.1s">
                <div class="service-item rounded overflow-hidden">
                    <img class="img-fluidd" width="400px" height="270px" src="<%="http://localhost:8888//uploadedFiles/"+eventlist.get(i).getEvent_picName()%>" alt="">
                    <%--                    <img src="<%="http://localhost:8888//uploadedFiles/"+list.get(i).getComm_picName()%>"--%>
                    <%--                         alt="<%=list.get(i).getcomm_title()%>">--%>
                    <div class="position-relative p-4 pt-0">
                        <div class="service-icon">
                            <i class="bi bi-hand-thumbs-up"></i>
                        </div>
                        <h4 class="mb-3"><%=eventlist.get(i).getEvent_Title()%></h4>
                        <p><%=eventlist.get(i).getEvent_Preview()%></p>
                        <a class="small fw-medium" href="">더보기><i class="fa fa-arrow-right ms-2"></i></a>
                    </div>
                </div>
            </div>
            <%
                }
            %>
            <!-- Event 게시물 추천 End -->
        </div>
        <!-- 여행지 추천 게시판 End -->
    </div>
</div>

<!-- Footer Start -->
<jsp:directive.include file="../fragment/footer.jsp"/>
<!-- Footer End -->

<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i
        class="bi bi-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../static/lib/wow/wow.min.js"></script>
<script src="../static/lib/easing/easing.min.js"></script>
<script src="../static/lib/waypoints/waypoints.min.js"></script>
<script src="../static/lib/counterup/counterup.min.js"></script>
<script src="../static/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="../static/lib/isotope/isotope.pkgd.min.js"></script>
<script src="../static/lib/lightbox/js/lightbox.min.js"></script>

<!-- Template Javascript -->
<script src="../static/js/main.js"></script>
<script src="../static/js/rating.js"></script>

</body>

</html>