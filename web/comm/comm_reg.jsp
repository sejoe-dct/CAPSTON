<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en" xmlns:jsp="http://java.sun.com/JSP/Page">

<head>
    <jsp:directive.include file="../fragment/head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="comm_nav.jsp"/>



<!-- Page Header Start -->
<div class="container-fluid page-header py-5 mb-5">
    <div class="container py-5">
        <h1 class="display-3 text-white mb-3 animated slideInDown">Projects</h1>
        <nav aria-label="breadcrumb animated slideInDown">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
                <li class="breadcrumb-item text-white active" aria-current="page">Projects</li>
            </ol>
        </nav>
    </div>
</div>


<div class="container-xxl py-5">
    <div class="container">
        <!-- 제목 / 소제목 -->
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">커뮤니티</h6>
            <h1 class="mb-4">맛집 및 명소를 등록해주세요.</h1>
        </div>

        <form action="comm_reg_back.jsp" method="post" enctype="multipart/form-data" accept-charset="UTF-8" >
            <div class="row g-3">
                <div class="col-12 ">
                    <input type="text" class="form-control border-0" name="comm_title" placeholder="제목" style="height: 55px;">
                </div>
                <div class="col-12">
                    <input type="text" class="form-control border-0" name="comm_preview" placeholder="한줄 소개" style="height: 55px;">
                </div>
                <div class="col-12">
                    <input type="file" class="form-control border-0" name="comm_picture" placeholder="행사소개 이미지"
                           style="height: 55px;">
                </div>
                <div class="col-12 col-sm-6">
                    <input type="text" class="form-control border-0" id="address" name="comm_address" placeholder="행사 장소"
                           style="height: 55px;" readonly>
                </div>
                <div class="col-12 col-sm-6">
                    <button class="btn btn-outline-success btn-sm py-3 px-5" id="adBtn" onclick="Postcode()" type="button"
                            placeholder="주소 검색">주소검색
                    </button>
                </div>
                <div class="col-12 col-sm-6">
                    <input type="text" class="form-control border-0" id="detailAddress" name= "event_detailAddress" placeholder="상세 주소"
                           style="height: 55px;">
                </div>

                <div class="col-12">
                    <textarea class="form-control border-0" name="comm_info" placeholder="내용"></textarea>
                </div>

<!--                <div class="col-12 col-sm-6">-->
<!--                    <textarea class="form-control border-0" name="comm_score" placeholder="평점"></textarea>-->
<!--                </div>-->

                <div class="col-md-4">
                    <div class="input-group spinner">
                        <input type="text" class="form-control" name="comm_score" value="0.5" min="0" max="5">
                        <div class="input-group-btn-vertical">
                            <button class="btn btn-default" type="button"><i class="fa fa-caret-up"></i></button>
                            <button class="btn btn-default" type="button"><i class="fa fa-caret-down"></i></button>
                        </div>
                    </div>
<!--                    <p class="help-block">Min 0 - Max 5.</p>-->
                </div>

                <div class="col-12" >
                    <button class="btn btn-primary rounded-pill py-3 px-5" type="submit">Submit</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function Postcode() {
        daum.postcode.load(function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    var addr = "";
                    if(data.userSelectedType === 'R'){
                        addr = data.roadAddress;
                    }else{
                        addr = data.jibunAddress;
                    }
                    document.getElementById("address").value = addr;
                    document.getElementById("detailAddress").focus();
                }


            }).open();
        });


    }
</script>


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


<!— JavaScript Libraries —>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../static/lib/wow/wow.min.js"></script>
<script src="../static/lib/easing/easing.min.js"></script>
<script src="../static/lib/waypoints/waypoints.min.js"></script>
<script src="../static/lib/counterup/counterup.min.js"></script>
<script src="../static/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="../static/lib/isotope/isotope.pkgd.min.js"></script>
<script src="../static/lib/lightbox/js/lightbox.min.js"></script>

<!— Template Javascript —>
<script src="../static/js/main.js"></script>
<script src="../static/js/score.js"></script>
</body>

</html>