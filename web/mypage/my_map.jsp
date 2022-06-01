<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bbs.BbsDAO" %>

<!DOCTYPE html>
<html lang="en">

<!--카카오지도 카테고리별-->



<head>
  <jsp:directive.include file="mypage_head.jsp"/>

  <style>
    .map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
    .map_wrap {position:relative;width:100%;height:350px;}
    #category {position:absolute;top:10px;left:1000px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
    #category li {float:right;list-style: none;width:50px; border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
    #category li.on {background: #eee;}
    #category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
    #category li:last-child{margin-right:0;border-right:0;}
    #category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
    #category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
    #category li .bank {background-position: -10px 0;}
    #category li .mart {background-position: -10px -36px;}
    #category li .pharmacy {background-position: -10px -72px;}
    #category li .oil {background-position: -10px -108px;}
    #category li .cafe {background-position: -10px -144px;}
    #category li .store {background-position: -10px -180px;}
    #category li.on .category_bg {background-position-x:-46px;}
    .placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
    .placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
    .placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
    .placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
    .placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
    .placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
    .placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
    .placeinfo .tel {color:#0f7833;}
    .placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
  </style>

</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="mypage_nav.jsp"/>

<!-- Map Start -->
<div class="container-xxl py-5">
  <div class="container">
    <!-- 제목 / 소제목 -->
    <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
      <h6 class="text-primary">지도</h6>
      <h1 class="mb-4">나의 지도</h1>
    </div>
    <div class="map_wrap">
      <div id="map" style="width:100%;height:400px;position:relative;overflow:hidden;"></div>
      <%--<ul id="category">
          <li id="BK9" data-order="0">
              <span class="category_bg bank"></span>
              은행
          </li>
          <li id="MT1" data-order="1">
              <span class="category_bg mart"></span>
              마트
          </li>
          <li id="PM9" data-order="2">
              <span class="category_bg pharmacy"></span>
              약국
          </li>
          <li id="OL7" data-order="3">
              <span class="category_bg oil"></span>
              주유소
          </li>
          <li id="CE7" data-order="4">
              <span class="category_bg cafe"></span>
              카페
          </li>
          <li id="CS2" data-order="5">
              <span class="category_bg store"></span>
              편의점
          </li>
      </ul>--%>
    </div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cbe730d167d2c649182403cd8299759f&libraries=services"></script>
    <%-- <div id="map" style="width:100%;height:350px;"></div>--%>

    <script>
      const mapContainer = document.getElementById('map'), // 지도를 표시할 div
              mapOption = {
                center: new kakao.maps.LatLng(37.5666805, 126.9784147), // 지도의 중심좌표
                level: 5 // 지도의 확대 레벨
              };
      // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
      /*    var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}),
              contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
              markers = [], // 마커를 담을 배열입니다
              currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
       */   // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
      //const map = new kakao.maps.Map(mapContainer, mapOption);


      // 지도를 생성합니다
      var map = new kakao.maps.Map(mapContainer, mapOption);
      // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
      var zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.LEFT);

      var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
      /*  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);*/
      var imageSize = new kakao.maps.Size(24, 35);
      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

      /* for (var i = 0; i < positions.length; i ++) { //-> db셀렉트 갯수 가지고 for문 돌리면 될듯

           // 마커 이미지의 이미지 크기 입니다
           var imageSize = new kakao.maps.Size(24, 35);

           // 마커 이미지를 생성합니다
           var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

           // 마커를 생성합니다
           var marker = new kakao.maps.Marker({
               map: map, // 마커를 표시할 지도
               position: positions[i].latlng, // 마커를 표시할 위치
               title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
               image : markerImage // 마커 이미지
           });
       }*/

      var geocoder = new kakao.maps.services.Geocoder();
      // 주소로 좌표를 검색합니다
      var doneCallback = function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
          var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
          marker = new kakao.maps.Marker({
            map: map,
            position: coords,
            image : markerImage
          });
          map.setCenter(coords);
        }
      };
      // 주소-좌표 변환 객체를 생성합니다
      <%
                              //    ArrayList<Bbs> list= bbsDAO.getList("서울");
          BbsDAO bbsDAO=new BbsDAO();
          ArrayList<Bbs> list= bbsDAO.getList("부산");
          for(int i=list.size()-1;i>=0;i--){
              %>
      geocoder.addressSearch('<%=list.get(i).getEvent_Address()%>', doneCallback);<%
                }
             %>
      geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', doneCallback);
      geocoder.addressSearch('제주특별자치도 제주시 첨단로 241', doneCallback);

    </script>
  </div>
</div>
<!-- Map End -->


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