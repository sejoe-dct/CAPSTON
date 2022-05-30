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
<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:directive.include file="../fragment/head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="event_nav.jsp"/>


<!-- 게시판 Start -->
<div class="container-xxl py-5">
    <div class="container">
        <!-- 제목 / 소제목 -->
        <!--<div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">지도</h6>
            <h1 class="mb-4">전국 각지 지역의 축제 및 명소를 알려드립니다.</h1>
        </div>-->
        <div class="container-xxl py-5">
            <%
                Connection conn =null;
                Statement stmt =null;
                ResultSet rs =null;

                BbsDAO bbsDAO=new BbsDAO();
            %>
            <div class="container">

                <div class="container bootstrap snippets bootdey" >

                    <div class="row" >
                        <%
                            ArrayList<Bbs> list= bbsDAO.getList_detail("ddddddd");

                        %>
                        <div class="col-md-6">
                            <div class="pro-img-details" >
<%--                                <img src="<%=list.get(0).getEvent_Picture()%>" alt="<%=list.get(0).getEvent_Title()%>>">--%>
                            </div>

                        </div>
                        <div class="col-sm-6 push-bit" style="padding: 10px;">
                            <div class="clearfix" enctype="multipart/form-data" >
                                <span class="h4" >

                    <h3  class="text-success"><%=list.get(0).getEvent_Title()%></h3><br />
                        </span>

                                <!--                    <hr />-->
                                <div class="text-end">
                                    <p><%=list.get(0).getEvent_Address()%></p>
                                </div>
                                <hr />getEvent_Content
                                <h6><%=list.get(0).getEvent_Content()%></h6>


                            </div>
                        </div>
                    </div>
                    <!-- detail End -->

                    <hr/>
                    <!-- 댓글 Start -->

<%--                    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">--%>
<%--                    <div class="container bootdey">--%>
<%--                        <div class="col-md-12 bootstrap snippets">--%>
<%--                            <div class="form-group">--%>
<%--                                <div class="panel">--%>
<%--                                    <div class="panel-body">--%>
<%--                                        <div th:object="${foodCmtDto}">--%>
<%--                                            <form  th:action="@{/foods/{id}(id=${foodBoard.id})}"  method="post">--%>
<%--                                                <textarea type="text" th:field="*{cmt}" class="form-control" rows="2" placeholder="댓글을 남겨주세요"></textarea>--%>
<%--                                                <div class="mar-top clearfix">--%>
<%--                                                    <button style="margin-top: 5px" class="btn btn-sm btn-primary pull-right" type="submit"><i class="fa fa-pencil fa-fw"></i> Share</button>--%>
<%--                                                </div>--%>
<%--                                            </form>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <hr/>--%>

<%--                                <div class="panel">--%>
<%--                                    <div class="panel-body">--%>
<%--                                        <!-- Newsfeed Content -->--%>
<%--                                        <!--===================================================-->--%>
<%--                                        <div class="media-block">--%>
<%--                                            <div class="media-body" th:each="cmts ,i : ${foodCmts}">--%>
<%--                                                <div class="mar-btm">--%>
<%--                                                    <h2 href="#" class="btn-link text-semibold media-heading box-inline" th:text="${cmts.user.nickname}">Lisa D.</h2>--%>
<%--                                                </div>--%>
<%--                                                <p th:text="${cmts.foodCmt}"></p>--%>

<%--                                                <hr>--%>

<%--                                                <!-- Comments -->--%>
<%--                                            </div>--%>
<%--                                        </div>--%>
<%--                                        <!--===================================================-->--%>
<%--                                        <!-- End Newsfeed Content -->--%>

<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                        <!-- 댓글 End -->


                    </div>
                </div>
            </div>
        </div>
</div>
<!-- 게시판 End -->


<!-- Footer Start -->
<div class="container-fluid bg-dark text-body footer mt-5 pt-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-lg-3 col-md-6">
                <h5 class="text-white mb-4">Address</h5>
                <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                <div class="d-flex pt-2">
                    <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                    <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                    <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                    <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="text-white mb-4">Quick Links</h5>
                <a class="btn btn-link" href="">About Us</a>
                <a class="btn btn-link" href="">Contact Us</a>
                <a class="btn btn-link" href="">Our Services</a>
                <a class="btn btn-link" href="">Terms & Condition</a>
                <a class="btn btn-link" href="">Support</a>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="text-white mb-4">Project Gallery</h5>
                <div class="row g-2">
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-1.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-2.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-3.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-4.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-5.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-6.jpg" alt="">
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="text-white mb-4">Newsletter</h5>
                <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                <div class="position-relative mx-auto" style="max-width: 400px;">
                    <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                    <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="copyright">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    &copy; <a href="#">Your Site Name</a>, All Right Reserved.
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                    Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                    <br>Distributed By: <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
                </div>
            </div>
        </div>
    </div>
</div>
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
