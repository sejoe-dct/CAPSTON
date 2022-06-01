<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en" xmlns:jsp="http://java.sun.com/JSP/Page">

<head>
  <jsp:directive.include file="fragment/head.jsp"/>
</head>

<body>
<jsp:directive.include file="fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="fragment/nav.jsp"/>

<!-- Map Start -->
<div class="container-xxl py-5">
  <div class="container">
    <!-- 제목 / 소제목 -->
    <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
      <h6 class="text-primary">지도</h6>
      <h1 class="mb-4">전국 각지 지역의 축제 및 명소를 알려드립니다.</h1>
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

      <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cbe730d167d2c649182403cd8299759f&libraries=services"></script>
      <script>
        const mapContainer = document.getElementById('map'), // 지도를 표시할 div
                mapOption = {
                  center: new kakao.maps.LatLng(37.5666805, 126.9784147), // 지도의 중심좌표
                  level: 5 // 지도의 확대 레벨
                };
        // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
        var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}),
                contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
                markers = [], // 마커를 담을 배열입니다
                currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
        // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
        //const map = new kakao.maps.Map(mapContainer, mapOption);

        // 지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 마커를 표시할 위치와 title 객체 배열입니다
        var positions = [
          {
            title: '카카오',
            latlng: new kakao.maps.LatLng(33.450705, 126.570677)
          },
          {
            title: '생태연못',
            latlng: new kakao.maps.LatLng(33.450936, 126.569477)
          },
          {
            title: '텃밭',
            latlng: new kakao.maps.LatLng(33.450879, 126.569940)
          },
          {
            title: '근린공원',
            latlng: new kakao.maps.LatLng(33.451393, 126.570738)
          }
        ];

        // 마커 이미지의 이미지 주소입니다
        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

        for (var i = 0; i < positions.length; i ++) {

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
        }

        // 장소 검색 객체를 생성합니다
        var ps = new kakao.maps.services.Places(map);

        // 지도에 idle 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'idle', searchPlaces);

        // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다
        contentNode.className = 'placeinfo_wrap';

        // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
        // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다
        addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
        addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

        // 커스텀 오버레이 컨텐츠를 설정합니다
        placeOverlay.setContent(contentNode);

        // 각 카테고리에 클릭 이벤트를 등록합니다
        addCategoryClickEvent();

        // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
        function addEventHandle(target, type, callback) {
          if (target.addEventListener) {
            target.addEventListener(type, callback);
          } else {
            target.attachEvent('on' + type, callback);
          }
        }

        // 카테고리 검색을 요청하는 함수입니다
        function searchPlaces() {
          if (!currCategory) {
            return;
          }

          // 커스텀 오버레이를 숨깁니다
          placeOverlay.setMap(null);

          // 지도에 표시되고 있는 마커를 제거합니다
          removeMarker();

          ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true});
        }

        // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
        function placesSearchCB(data, status, pagination) {
          if (status === kakao.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
            displayPlaces(data);
          } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

          } else if (status === kakao.maps.services.Status.ERROR) {
            // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

          }
        }

        // 지도에 마커를 표출하는 함수입니다
        function displayPlaces(places) {

          // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
          // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
          var order = document.getElementById(currCategory).getAttribute('data-order');



          for ( var i=0; i<places.length; i++ ) {

            // 마커를 생성하고 지도에 표시합니다
            var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

            // 마커와 검색결과 항목을 클릭 했을 때
            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
            (function(marker, place) {
              kakao.maps.event.addListener(marker, 'click', function() {
                displayPlaceInfo(place);
              });
            })(marker, places[i]);
          }
        }

        // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
        function addMarker(position, order) {
          var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                  imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
                  imgOptions =  {
                    spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
                    spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                  },
                  markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                  marker = new kakao.maps.Marker({
                    position: position, // 마커의 위치
                    image: markerImage
                  });

          marker.setMap(map); // 지도 위에 마커를 표출합니다
          markers.push(marker);  // 배열에 생성된 마커를 추가합니다

          return marker;
        }

        // 지도 위에 표시되고 있는 마커를 모두 제거합니다
        function removeMarker() {
          for ( var i = 0; i < markers.length; i++ ) {
            markers[i].setMap(null);
          }
          markers = [];
        }

        // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
        function displayPlaceInfo (place) {
          var content = '<div class="placeinfo">' +
                  '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';

          if (place.road_address_name) {
            content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                    '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
          }  else {
            content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
          }

          content += '    <span class="tel">' + place.phone + '</span>' +
                  '</div>' +
                  '<div class="after"></div>';

          contentNode.innerHTML = content;
          placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
          placeOverlay.setMap(map);
        }


        // 각 카테고리에 클릭 이벤트를 등록합니다
        function addCategoryClickEvent() {
          var category = document.getElementById('category'),
                  children = category.children;

          for (var i=0; i<children.length; i++) {
            children[i].onclick = onClickCategory;
          }
        }

        // 카테고리를 클릭했을 때 호출되는 함수입니다
        function onClickCategory() {
          var id = this.id,
                  className = this.className;

          placeOverlay.setMap(null);

          if (className === 'on') {
            currCategory = '';
            changeCategoryClass();
            removeMarker();
          } else {
            currCategory = id;
            changeCategoryClass(this);
            searchPlaces();
          }
        }

        // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
        function changeCategoryClass(el) {
          var category = document.getElementById('category'),
                  children = category.children,
                  i;

          for ( i=0; i<children.length; i++ ) {
            children[i].className = '';
          }

          if (el) {
            el.className = 'on';
          }
        } </script>
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