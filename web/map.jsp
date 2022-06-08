<%@ page import="java.util.ArrayList" %>
<%@ page import="comm.Comm_data" %>
<%@ page import="bbs.*" %>
<%@ page import="comm.CommDAO" %>
<%@ page import="comm.Comm" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %><%--<%@ page language="java" contentType="text/html;charset=UTF-8"--%>
<%--         pageEncoding="UTF-8" %>--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">


<head>
    <jsp:directive.include file="fragment/head.jsp"/>
    <style>
        .wrap {
            position: absolute;
            left: 0;
            bottom: 40px;
            width: 288px;
            height: 132px;
            margin-left: -144px;
            text-align: left;
            overflow: hidden;
            font-size: 12px;
            font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
            line-height: 1.5;
        }

        .wrap * {
            padding: 0;
            margin: 0;
        }

        .wrap .info {
            width: 286px;
            height: 120px;
            border-radius: 5px;
            border-bottom: 2px solid #ccc;
            border-right: 1px solid #ccc;
            overflow: hidden;
            background: #fff;
        }

        .wrap .info:nth-child(1) {
            border: 0;
            box-shadow: 0px 1px 2px #888;
        }

        .info .title {
            padding: 5px 0 0 10px;
            height: 30px;
            background: #eee;
            border-bottom: 1px solid #ddd;
            font-size: 18px;
            font-weight: bold;
        }

        .info .close {
            position: absolute;
            top: 10px;
            right: 10px;
            color: #888;
            width: 17px;
            height: 17px;
            background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
        }

        .info .close:hover {
            cursor: pointer;
        }

        .info .body {
            position: relative;
            overflow: hidden;
        }

        .info .desc {
            position: relative;
            margin: 13px 0 0 90px;
            height: 75px;
        }

        .desc .ellipsis {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .desc .jibun {
            font-size: 11px;
            color: #888;
            margin-top: -2px;
        }

        .info .img {
            position: absolute;
            top: 6px;
            left: 5px;
            width: 73px;
            height: 71px;
            border: 1px solid #ddd;
            color: #888;
            overflow: hidden;
        }

        .info:after {
            content: '';
            position: absolute;
            margin-left: -12px;
            left: 50%;
            bottom: 0;
            width: 22px;
            height: 12px;
            background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
        }

        .info .link {
            color: #5085BB;
        }
    </style>
</head>

<body>

<jsp:directive.include file="fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="fragment/nav.jsp"/>

<%
  BbsDAO bbsDAO=new BbsDAO();
  CommDAO commDAO = new CommDAO();
    ArrayList<Comm> commlist = commDAO.getList2("전국","");
  ArrayList<Bbs> eventlist = bbsDAO.getList2("전국","");

    %>
<!-- Map Start -->
<div class="container-xxl py-5">
    <div class="container">
        <!-- 제목 / 소제목 -->
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">지도</h6>
            <h1 class="mb-4">전체 지도 살펴보기</h1>
        </div>
        <div class="map_wrap">
            <div id="map" style="width:100%;height:400px;position:relative;overflow:hidden;"></div>
        </div>
        <button type="button" class="btn btn-lg btn-light" id="search_button" onclick="markUPUP(latlngList)">마크 한눈에 보기</button>
        <script type="text/javascript"
                src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cbe730d167d2c649182403cd8299759f&libraries=services"></script>
        <%-- <div id="Map" style="width:100%;height:350px;"></div>--%>

        <script>
            const mapContainer = document.getElementById('map'), // 지도를 표시할 div
                mapOption = {
                    center: new kakao.maps.LatLng(37.5666805, 126.9784147), // 지도의 중심좌표
                    level: 7
                    //   level: 5 // 지도의 확대 레벨
                };

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

            var bounds = new kakao.maps.LatLngBounds();
            var latlngList = [];
            var geocoder = new kakao.maps.services.Geocoder();
            // 주소로 좌표를 검색합니다
            <% for(int i=eventlist.size()-1;i>=0;i--){
             %>

            geocoder.addressSearch('<%=eventlist.get(i).getEvent_Address()%>', function (result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    marker = new kakao.maps.Marker({
                        map: map,
                        position: coords,
                        image: markerImage
                    });
                    latlngList.push(coords);
                    infowindow = new kakao.maps.InfoWindow({
                        content: '    <div class="info">' +
                            '        <div class="title">' +
                            '            <%=eventlist.get(i).getEvent_Title()%>' +
                            '        </div>' +
                            '        <div class="body">' +
                            '            <div class="img">' +
                            '                <img src="http://localhost:8888//uploadedFiles/<%=eventlist.get(i).getEvent_picName()%>" width="73" height="70">' +
                            '           </div>' +
                            '            <div class="desc">' +
                            '                <div class="ellipsis"><%=eventlist.get(i).getEvent_Address()%></div>' +
                            '            </div>' +
                            '        </div>' +
                            '    </div>'// 인포윈도우에 표시할 내용
                        /* map: map,
                         position: marker.getPosition()*/
                    });
                    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
                    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

                    map.setCenter(coords);
                    bounds.extend(coords);

                }

            });
            <%}

                  for(int i=commlist.size()-1;i>=0;i--){
               %>

            geocoder.addressSearch('<%=commlist.get(i).getcomm_address()%>', function (result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    marker = new kakao.maps.Marker({
                        map: map,
                        position: coords,
                        image: markerImage2
                    });
                    latlngList.push(coords);
                    infowindow = new kakao.maps.InfoWindow({
                        content: '    <div class="info">' +
                            '        <div class="title">' +
                            '            <%=commlist.get(i).getcomm_title()%>' +
                            '        </div>' +
                            '        <div class="body">' +
                            '            <div class="img">' +
                            '                <img src="http://localhost:8888//uploadedFiles/<%=commlist.get(i).getComm_picName()%>" width="73" height="70">' +
                            '           </div>' +
                            '            <div class="desc">' +
                            '                <div class="ellipsis"><%=commlist.get(i).getcomm_address()%></div>' +
                            '            </div>' +
                            '        </div>' +
                            '    </div>'// 인포윈도우에 표시할 내용
                        /* map: map,
                         position: marker.getPosition()*/
                    });
                    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
                    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

                    map.setCenter(coords);
                    console.log("result, title 값: " + result + title);

                    bounds.extend(coords);
                }

            });
            <%}
                 %>

            function makeOverListener(map, marker, infowindow) {
                return function () {
                    infowindow.open(map, marker);
                };
            }

            function makeOutListener(infowindow) {
                return function () {
                    infowindow.close();
                };
            }

            function markUPUP(latlngList) {
                console.log("mymap ::::: latlngList 값2 " + latlngList);
                map.setBounds(bounds);
            }
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