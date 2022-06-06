<%@ page import="java.util.ArrayList" %>
<%@ page import="comm.Comm_data" %>
<%@ page import="bbs.*" %>
<%@ page import="comm.CommDAO" %>
<%@ page import="comm.Comm" %><%--<%@ page language="java" contentType="text/html;charset=UTF-8"--%>
<%--         pageEncoding="UTF-8" %>--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">


<head>
  <jsp:directive.include file="fragment/head.jsp"/>
</head>

<body>

<jsp:directive.include file="fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="fragment/nav.jsp"/>

<%--<%
    String session_userID = String.valueOf(session.getAttribute("userID"));
    // 만약 넘어온 데이터가 없다면
    // 유효한 글이라면 구체적인 정보를 'evnet'라는 인스턴스에 담는다
  //  ArrayList<Event_data> eventlist = new Event_dataDAO().getEventUserID(session_userID);
 //   ArrayList<Comm_data> commlist = new bbs.Comm_dataDAO().getCommUserID(session_userID);
/*    ArrayList<Event_data> eventlist = new Event_dataDAO().getEventUserID(session_userID);
    ArrayList<Comm_data> commlist = new bbs.Comm_dataDAO().getCommUserID(session_userID);
    System.out.println("세션 userID: " + session_userID);*/

%>--%>
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
      <ul id="category">
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
      </ul>
    </div>

    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cbe730d167d2c649182403cd8299759f&libraries=services"></script>
    <%-- <div id="Map" style="width:100%;height:350px;"></div>--%>

    <script>
      const mapContainer = document.getElementById('map'), // 지도를 표시할 div
              mapOption = {
                center: new kakao.maps.LatLng(37.5666805, 126.9784147), // 지도의 중심좌표
                level: 4
                //   level: 5 // 지도의 확대 레벨
              };
      // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
      /*    var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}),
              contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
              markers = [], // 마커를 담을 배열입니다
              currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
       */   // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
      //const Map = new kakao.maps.Map(mapContainer, mapOption);


      // 지도를 생성합니다
      var Map = new kakao.maps.Map(mapContainer, mapOption);
      // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
      var zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.LEFT);

      var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
      //  var imageSrc2 = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png";
      var imageSrc2 = "../static/img/marker_blue.png";
      /*  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);*/
      var imageSize = new kakao.maps.Size(24, 35);
      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
      var markerImage2 = new kakao.maps.MarkerImage(imageSrc2, imageSize);
      /*for (var i = 0; i < positions.length; i ++) { //-> db셀렉트 갯수 가지고 for문 돌리면 될듯

          // 마커 이미지의 이미지 크기 입니다
          var imageSize = new kakao.maps.Size(24, 35);

          // 마커 이미지를 생성합니다
          var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

          // 마커를 생성합니다
          var marker = new kakao.maps.Marker({
              Map: Map, // 마커를 표시할 지도
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
      var doneCallback2 = function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
          var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
          marker = new kakao.maps.Marker({
            map: map,
            position: coords,
            image : markerImage2
          });
          map.setCenter(coords);
        }
      };
      // 주소-좌표 변환 객체를 생성합니다
      <%
                              //    ArrayList<Bbs> list= bbsDAO.getList("서울");
          CommDAO commDAO=new CommDAO();
          BbsDAO bbsDAO=new BbsDAO();

          ArrayList<Bbs> bbslist= bbsDAO.getList("전국");
          for(int i=bbslist.size()-1;i>=0;i--){
              %>
      geocoder.addressSearch('<%=bbslist.get(i).getEvent_Address()%>', doneCallback);<%
                }
                ArrayList<Comm> commlist= commDAO.getList("전국");
                for(int i=commlist.size()-1;i>=0;i--){
                    %>
      geocoder.addressSearch('<%=commlist.get(i).getcomm_address()%>', doneCallback2);<%
                }
             %>

      /*geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', doneCallback);
      geocoder.addressSearch('제주특별자치도 제주시 첨단로 241', doneCallback);*/

    </script>
  </div>
</div>
<!-- Map End -->


<!-- Footer Start -->
<jsp:directive.include file="./fragment/footer.jsp"/>
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