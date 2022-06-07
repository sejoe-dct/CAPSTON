<%@ page import="java.util.ArrayList" %>
<%@ page import="comm.Comm_data" %>
<%@ page import="bbs.*" %>
<%@ page import="comm.Comm_dataDAO" %>
<%@ page import="java.util.Arrays" %><%--<%@ page language="java" contentType="text/html;charset=UTF-8"--%>
<%--         pageEncoding="UTF-8" %>--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:directive.include file="mypage_head.jsp"/>
    <style>
        .dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}
        .dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
        .dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
        .number {font-weight:bold;color:#ee6152;}
        .dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
        .distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
        .distanceInfo .label {display:inline-block;width:50px;}
        .distanceInfo:after {content:none;}
    </style>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="mypage_nav.jsp"/>
<%
    String session_userID = String.valueOf(session.getAttribute("userID"));
    // 만약 넘어온 데이터가 없다면
    // 유효한 글이라면 구체적인 정보를 'evnet'라는 인스턴스에 담는다
    ArrayList<Event_data> eventlist= new Event_dataDAO().getEventUserID(session_userID);
    ArrayList<Comm_data> commlist= new Comm_dataDAO().getCommUserID(session_userID);
    System.out.println("세션 userID: "+session_userID);
%>
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
        </div>
        <button type="button" class="btn btn-lg btn-light" id="search_button" onclick="drawPolyline(latlngList)">거리 한눈에보기</button>
        <button type="button" class="btn btn-lg btn-light" id="search_button" onclick="removePoly()">선지우기</button>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cbe730d167d2c649182403cd8299759f&libraries=services"></script>
        <%-- <div id="map" style="width:100%;height:350px;"></div>--%>

        <script>
            var polyline = new kakao.maps.Polyline({
                strokeWeight: 5, // 선의 두께 입니다
                strokeColor: '#DC143C', // 선의 색깔입니다
                strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                strokeStyle: 'solid' // 선의 스타일입니다
            });
            //도착지 마커
            var finishMarker = new kakao.maps.Marker({
                position: null
            });

            //경로의 길이와 예상 소요 시간을 출력할 인포윈도우
            var infowindow = new kakao.maps.InfoWindow({
                position: null,
                content: null
            });
            const mapContainer = document.getElementById('map'), // 지도를 표시할 div
                mapOption = {
                    center: new kakao.maps.LatLng(37.5666805, 126.9784147), // 지도의 중심좌표
                    level: 8
                    //   level: 5 // 지도의 확대 레벨
                };
            // 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
            // 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
            function showDistance(content, position) {

                if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면

                    // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
                    distanceOverlay.setPosition(position);
                    distanceOverlay.setContent(content);

                } else { // 커스텀 오버레이가 생성되지 않은 상태이면

                    // 커스텀 오버레이를 생성하고 지도에 표시합니다
                    distanceOverlay = new kakao.maps.CustomOverlay({
                        map: map, // 커스텀오버레이를 표시할 지도입니다
                        content: content,  // 커스텀오버레이에 표시할 내용입니다
                        position: position, // 커스텀오버레이를 표시할 위치입니다.
                        xAnchor: 0,
                        yAnchor: 0,
                        zIndex: 3
                    });
                }
            }
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
            //  var imageSrc2 = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png";
            var imageSrc2 = "../static/img/marker_blue.png";
            /*  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);*/
            var imageSize = new kakao.maps.Size(24, 35);
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
            var markerImage2 = new kakao.maps.MarkerImage(imageSrc2, imageSize);
            var distanceOverlay;
            var dats=[];
            /*for (var i = 0; i < positions.length; i ++) { //-> db셀렉트 갯수 가지고 for문 돌리면 될듯

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
            /*function makeOverListener(map, marker, infowindow) {
                return function() {
                    infowindow.open(map, marker);
                };
            }
            function makeOutListener(infowindow) {
                return function() {
                    infowindow.close();
                };
            }*/
            <%
                     String[] likelangs = request.getParameterValues("likeitem");
             //       String[] liketitle = request.getParameterValues("liketitle");


                 //배열 to 리스트
              //   ArrayList<String> liketitleList = new ArrayList<String>(Arrays.asList(liketitle));
                 ArrayList<String> likelist = new ArrayList<String>(Arrays.asList(likelangs));
            //     System.out.println("지도 title 값: " +liketitleList);
                 System.out.println("지도 likelist 값: " +likelist);
                           %>
            polyline.setMap(null);
            var bounds = new kakao.maps.LatLngBounds(); //지도 마커범위 맞춰서 재설정
            var latlngList =[];
            var addrList=[];
            var geocoder = new kakao.maps.services.Geocoder();
            <%   for(int i=likelist.size()-1;i>=0;i--){
                                  %>
            // 주소로 좌표를 검색합니다'
            geocoder.addressSearch('<%=likelist.get(i)%>' ,function(result,status) {

                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    //이전에 그려져있던 경로 삭제
                    latlngList.push(coords);
                    console.log("event 콜백함수 안 latlngList 값 "+latlngList);

                    //     polyline.setMap(map);
                    marker = new kakao.maps.Marker({
                        map: map,
                        position: coords,
                        image : markerImage
                    });
                    infowindow = new kakao.maps.InfoWindow({
                        content: '<div class="info"><%=likelist.get(i)%></div>'
                        // 인포윈도우에 표시할 내용
                        /* map: map,
                         position: marker.getPosition()*/
                    });
                    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
                    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
                    map.setCenter(coords);
                    bounds.extend(coords);

                    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
                    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다

                }
                /*kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
                kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));*/
            }); <%}%>
            function makeOverListener(map, marker, infowindow) {
                return function() {
                    infowindow.open(map, marker);
                };
            }
            function makeOutListener(infowindow) {
                return function() {
                    infowindow.close();
                };
            }
            /* var doneCallback2 = function(result, status) {
                 if (status === kakao.maps.services.Status.OK) {
                     var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                     //   $("input[name=lat]").val(result[0].y);
                     latlngList.push(coords);
                     console.log("comm콜백함수 안 latlngList 값 "+latlngList);

                     marker = new kakao.maps.Marker({
                         map: map,
                         position: coords,
                         image : markerImage2
                     });
                     map.setCenter(coords);
                 }
             };
                   var callback = function(result, status) {
                     if (status === kakao.maps.services.Status.OK) {
                       const coX = new kakao.maps.LatLng(result[0].x);
                       const coY = new kakao.maps.LatLng(result[0].y);
                    //   $("input[name=lat]").val(result[0].y);
                       console.log(coX,coY);
                     }
                   };*/

            //                            for(int j=commlist.size()-1;j>=0;j--){

            <%--geocoder.addressSearch('<%=commlist.get(j).getcomm_address()%>', doneCallback2);--%>
            <%--            <%--%>
            <%--//              }--%>
            <%--            %>--%>

            function getTimeHTML(distance) {

                // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
                var walkkTime = distance / 67 | 0;
                var walkHour = '', walkMin = '';

                // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
                if (walkkTime > 60) {
                    walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
                }
                walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

                // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
                var bycicleTime = distance / 227 | 0;
                var bycicleHour = '', bycicleMin = '';

                // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
                if (bycicleTime > 60) {
                    bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
                }
                bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

                // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
                var content = '<ul class="dotOverlay distanceInfo">';
                content += '    <li>';
                content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
                content += '    </li>';
                content += '    <li>';
                content += '        <span class="label">도보</span>' + walkHour + walkMin;
                content += '    </li>';
                content += '    <li>';
                content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
                content += '    </li>';
                content += '</ul>'

                return content;
            }
            function drawPolyline(latlngList){
                console.log("latlngList 값2 "+latlngList);
                polyline.setPath(latlngList);
                polyline.setMap(map);
                var distance = Math.round(polyline.getLength());
                console.log("distance : "+distance);
                content = getTimeHTML(distance);
                console.log("content 값: " + content);
                var lastPosition = latlngList.length-1;
                showDistance(content, latlngList[lastPosition]);
                map.setBounds(bounds);
            }

            function  removePoly() {
                polyline.setMap(null);
                if (distanceOverlay) {
                    distanceOverlay.setMap(null);
                    distanceOverlay = null;
                }
            }
            /*geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', doneCallback);
            geocoder.addressSearch('제주특별자치도 제주시 첨단로 241', doneCallback);*/

        </script>
    </div>
</div>
<!-- Map End -->


<!-- Footer Start -->
<jsp:directive.include file="../fragment/footer.jsp"/>
<!-- Footer End -->


<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>


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
</body>


</html>