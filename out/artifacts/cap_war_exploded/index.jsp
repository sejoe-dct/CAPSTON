<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="comm.CommDAO" %>
<%@ page import="comm.Comm" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:directive.include file="fragment/head.jsp"/>
    <style>
        .img-fluidd {
            object-fit:cover; /* ☆ */
            width: 100%;
            height:270px;
        }

        .col-lg-44 {
            flex: 0 0 auto;
            width: 33.33333%;
            height : 410px;
        }

        .img-fluiddd {
            object-fit:cover; /* ☆ */
            width: 100%;
            height:650px;
        }
        .col-lg-44 {
            flex: 0 0 auto;
            width: 33.33333%;
            height : 410px;
        }

    </style>
</head>

<body>
<jsp:directive.include file="fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="fragment/nav.jsp"/>

<!-- Carousel Start -->
<div class="container-fluid p-0 pb-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="owl-carousel header-carousel position-relative">
        <div class="owl-carousel-item position-relative" data-dot="<img src='../static/img/전주성당.jpg'>">
            <img class="img-fluiddd" src="../static/img/전주성당.jpg" alt="">
            <div class="owl-carousel-inner">
                <div class="container">
                    <div class="row justify-content-start">
                        <div class="col-10 col-lg-8">
                            <h1 class="display-2 text-white animated slideInDown">순교의 의미, 전주전동성당</h1>
                            <p class="fs-5 fw-medium text-white mb-4 pb-3"> 호남지역 최초로 지어진 로마네스크 양식의 성당</p>
                            <a href="https://map.kakao.com/link/search/전주전동성당" target="_blank" rel="noopener" title="새 창" class="btn btn-primary rounded-pill py-3 px-5 animated slideInLeft">더보기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="owl-carousel-item position-relative" data-dot="<img src='../static/img/광안리.jpg'>">
            <img class="img-fluiddd" src="../static/img/광안리.jpg" alt="">
            <div class="owl-carousel-inner">
                <div class="container">
                    <div class="row justify-content-start">
                        <div class="col-10 col-lg-8">
                            <h1 class="display-2 text-white animated slideInDown">낭만의 정석, 광안리 바다</h1>
                            <p class="fs-5 fw-medium text-white mb-4 pb-3">광안리의 밤은 당신의 낮보다 아름답다</p>
                            <a href="https://map.kakao.com/link/search/광안리해수욕장" target="_blank" rel="noopener" title="새 창" class="btn btn-primary rounded-pill py-3 px-5 animated slideInLeft">더보기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="owl-carousel-item position-relative" data-dot="<img src='../static/img/산너미목장.jpg'>">
            <img class="img-fluiddd" src="../static/img/산너미목장.jpg" alt="">
            <div class="owl-carousel-inner">
                <div class="container">
                    <div class="row justify-content-start">
                        <div class="col-10 col-lg-8">
                            <h1 class="display-2 text-white animated slideInDown">산너미 목장</h1>
                            <p class="fs-5 fw-medium text-white mb-4 pb-3">평창의 자연과 흑염소가 있는 산너미 목장</p>
                            <a href="https://map.kakao.com/link/search/산너미목장" target="_blank" rel="noopener" title="새 창" class="btn btn-primary rounded-pill py-3 px-5 animated slideInLeft">더보기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="owl-carousel-item position-relative" data-dot="<img src='../static/img/담양가로수길.jpg'>">
            <img class="img-fluiddd" src="../static/img/담양가로수길.jpg" alt="">
            <div class="owl-carousel-inner">
                <div class="container">
                    <div class="row justify-content-start">
                        <div class="col-10 col-lg-8">
                            <h2 class="display-3 text-white animated slideInDown"> 담양 메타세쿼이아 가로수길</h2>
                            <p class="fs-5 fw-medium text-white mb-4 pb-3">이국적 풍경, 가로수가 만든 초록빛 동굴</p>
                            <a href="https://map.kakao.com/link/search/담양메타세쿼이아길" target="_blank" rel="noopener" title="새 창" class="btn btn-primary rounded-pill py-3 px-5 animated slideInLeft">더보기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="owl-carousel-item position-relative" data-dot="<img src='../static/img/제주허브동산.jpg'>">
            <img class="img-fluiddd" src="../static/img/제주허브동산.jpg" alt="">
            <div class="owl-carousel-inner">
                <div class="container">
                    <div class="row justify-content-start">
                        <div class="col-10 col-lg-8">
                            <h2 class="display-3 text-white animated slideInDown"> 이국적인 정원, 제주 허브동산</h2>
                            <p class="fs-5 fw-medium text-white mb-4 pb-3">해풍을 맞고 자라난 싱그러운 허브들</p>
                            <a href="https://map.kakao.com/link/search/제주허브동산" target="_blank" rel="noopener" title="새 창" class="btn btn-primary rounded-pill py-3 px-5 animated slideInLeft">더보기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Carousel End -->


<!-- 행사/축제 미리보기 -->
<div class="container-xxl py-5">
    <div class="container">
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">행사/축제 안내</h6>
            <h1 class="mb-4">각 지역의 행사 및 축제 소개</h1>
        </div>

        <%
            BbsDAO bbsDAO=new BbsDAO();
            ArrayList<Bbs> list= bbsDAO.getPreviewList();
        %>

        <div class="row g-4">
            <%
                for (int i = 0; i<6; i++) {
            %>
            <div class="col-md-6 col-lg-44 wow fadeInUp" data-wow-delay="0.1s">
                <div class="service-item rounded overflow-hidden">
                    <img class="img-fluidd" src="<%="http://localhost:8888//uploadedFiles/"+list.get(i).getEvent_picName()%>"
                         alt="<%=list.get(i).getEvent_Title()%>">
                    <div class="position-relative p-4 pt-0">
                        <h4 class="mb-3" style="padding-top: 10px"><%=list.get(i).getEvent_Title()%></h4>
                        <p><%=list.get(i).getEvent_Preview()%></p>
                        <a class="small fw-medium" href="event/event_detail.jsp?eventID=<%= list.get(i).getEventID() %>">더보기<i class="fa fa-arrow-right ms-2"></i></a>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>
<!-- 행사/축제 미리보기 End -->

<!-- Testimonial Start -->
<%
    CommDAO commDAO=new CommDAO();
    ArrayList<Comm> commList= commDAO.getPreviewList();

%>

<div class="container-xxl py-5">
    <div class="container">
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">맛집 소개</h6>
            <h1 class="mb-4">전국 각 지역의 맛집 소개</h1>
        </div>

        <div class="owl-carousel testimonial-carousel wow fadeInUp" data-wow-delay="0.1s">
            <% for(int i =0; i<5;i++) { %>
            <div class="testimonial-item text-center">
                <div class="testimonial-img position-relative">
                    <img class="img-fluid rounded-circle mx-auto mb-5" src="<%="http://localhost:8888//uploadedFiles/"+commList.get(i).getComm_picName()%>">
                    <div class="btn-square bg-primary rounded-circle">
                        <i class="fa fa-quote-left text-white"></i>
                    </div>
                </div>
                <div class="testimonial-text text-center rounded p-4">
                    <p><%=commList.get(i).getcomm_preview()%></p>
                    <a href="comm/comm_detail.jsp?commID=<%=commList.get(i).getcomm_id()%>">
                        <h5 class="mb-1"><%=commList.get(i).getcomm_title()%>  </h5>
                    </a>                    <span class="fst-italic"><%=commList.get(i).getcomm_address()%></span>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
<!-- Testimonial End -->


<!-- Footer Start -->
<jsp:directive.include file="./fragment/footer.jsp"/>
<!-- Footer End -->

<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../static/lib/wow/wow.min.js"></script>
<script src="../static/lib/easing/easing.min.js"></script>
<script src="../static/lib/waypoints/waypoints.min.js"></script>
<script src="../static/lib/counterup/counterup.min.js"></script>
<script src="../static/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="../static/lib/isotope/isotope.pkgd.min.js"></script>
<script src="../static/lib/lightbox/js/lightbox.min.js"></script>

<!-- Template Javascript -->
<script src="../static/js/main.js"></script>
</body>

</html>