<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en" xmlns:jsp="http://java.sun.com/JSP/Page">

<head>
    <jsp:directive.include file="comm_head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="comm_nav.jsp"/>

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


                <div class="col-md-4">
                    <div class="input-group spinner">
                        <input type="text" class="form-control" name="comm_score" value="0.5" min="0" max="5">
                        <div class="input-group-btn-vertical">
                            <button class="btn btn-default" type="button"><i class="fa fa-caret-up"></i></button>
                            <button class="btn btn-default" type="button"><i class="fa fa-caret-down"></i></button>
                        </div>
                    </div>
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
<jsp:directive.include file="../fragment/footer.jsp"/>
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