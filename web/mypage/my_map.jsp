<%@ page import="java.util.ArrayList" %>
<%@ page import="comm.Comm_data" %>
<%@ page import="bbs.*" %>
<%@ page import="comm.Comm_dataDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="comm.CommDAO" %>
<%@ page import="comm.Comm" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <jsp:directive.include file="mypage_head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="mypage_nav.jsp"/>
<%
  String session_userID = String.valueOf(session.getAttribute("userID"));

  ArrayList<Event_data> eventlist= new Event_dataDAO().getEventUserID(session_userID);
  ArrayList<Comm_data> commlist= new Comm_dataDAO().getCommUserID(session_userID);
  System.out.println("세션 userID: "+session_userID);
%>
<!-- Map Start -->
<div class="container-xxl py-5">
  <div class="container">
    <!-- 제목 / 소제목 -->
    <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
      <h6 class="text-primary">나만의 지도</h6>
      <h1 class="mb-4">지도</h1>
    </div>
    <div class="map_wrap">
      <div id="map" style="width:100%;height:400px;position:relative;overflow:hidden;"></div>
    </div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cbe730d167d2c649182403cd8299759f&libraries=services"></script>

    <script>
      const mapContainer = document.getElementById('map'), // 지도를 표시할 div
              mapOption = {
                center: new kakao.maps.LatLng(37.5666805, 126.9784147), // 지도의 중심좌표
                level: 4
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
                      //  ArrayList<Bbs> list= bbsDAO.getList("서울"); commlist
                    //  BbsDAO bbsDAO=new BbsDAO();
                //      Event_dataDAO bbsDAO=new Event_dataDAO();
               //       ArrayList<Bbs> list= bbsDAO.getEventUserID(session.getAttribute("userID"));
                      for(int i=eventlist.size()-1;i>=0;i--){
                          %>
      geocoder.addressSearch('<%=eventlist.get(i).getevent_address()%>', doneCallback);
      <%
        }
                      for(int j=commlist.size()-1;j>=0;j--){
                          %>
      geocoder.addressSearch('<%=commlist.get(j).getcomm_address()%>', doneCallback2);
      <%
        }
      %>
      /*geocoder.addressSearch('제주특별자치도 제주시 첨단로 242', doneCallback);
      geocoder.addressSearch('제주특별자치도 제주시 첨단로 241', doneCallback);*/

    </script>
  </div>
</div>
<!-- Map End -->

<!-- 리스트 Strat -->
<div class="container-xxl py-5">
  <div class="container">
    <!-- 제목 / 소제목 -->
    <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
      <h6 class="text-primary">나만의 지도</h6>
      <h1 class="mb-4">좋아요 누른 게시물</h1>
    </div>

    <div class="cp33list1">
      <%

        System.out.println("예전 event_detail.jsp에 있던 소스로 넘어옴");
        Connection conn =null;
        Statement stmt =null;
        ResultSet rs =null;

        Comm_dataDAO commdataDAO=new Comm_dataDAO();

      %>
      <form method="get" action="like_map.jsp">
        <ul class="lst1">
        <!--1번째 --> <!-- 서울 리스트 for문 -->
        <div class="country-item portfolio-item seoul"> <!-- 카테고리 구분 -->
          <%
            ArrayList<Comm> list = commdataDAO.getComm_data(session_userID);
            System.out.println(session_userID);
            for (int i = list.size() - 1; i >= 0; i--) {
          %>
          <
          <li class="li1">
            <div class="w1">
              <!-- 이미지 -->
              <div class="w1c1">
                <a href="?amode=view&amp;idx=191&amp;category=F0100" class="figs">
                  <span class="f1">
                    <span class="f1p1">
                      <img src="<%="http://localhost:8888//uploadedFiles/"+list.get(i).getComm_picName()%>"
                           alt="<%=list.get(i).getcomm_title()%>">
                    </span>
                  </span>
                </a>
              </div>
              <!-- 설명 -->
              <div class="w1c2">
                <div class="texts">
                  <a href="comm_detail.jsp?commID=<%= list.get(i).getcomm_id() %>" class="tg1">
                    <em class="ic1 bsContain "
                        style="background-size: contain;"><%=list.size() - i%>
                    </em>
                    <strong class="t1"><%=list.get(i).getcomm_title()%></strong>
                    <div class="t2"><%=list.get(i).getcomm_preview()%></div>
                  </a>
                  <div class="cp33dlist1">
                    <ul class="dl1">
                      <li class="di place">
                        <b class="dt">
                          <i class="ic1"></i>
                          <span class="t1">위치</span>
                          <span class="sep">:</span>
                        </b>
                        <span class="dd">
                          <span class="t2"> <%=list.get(i).getcomm_address()%></span>
                        </span>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>

                <!-- 체크박스 -->
                <div class="cp33btns1" style="text-align: center">
<%--                  <a href="comm_like.jsp?commID=<%= list.get(i).getcomm_id() %>" onclick="doConfirmRealName(this.href);return false;" class="button" data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기취소</span></a>--%>
                  <input type="checkbox" name="likeitem" style="width:30px;height:30px;" value="<%=list.get(i).getcomm_address()%>">
                </div>
              </div>
          </li>
          <%
            }
          %>
        </div>
      </ul>
        <div style="text-align: right">
          <input type="submit" class="btn btn-primary" style="margin: 10px" value="확인">
        </div>
      </form>
    </div>

  </div>
</div>

<!-- 리스트 End -->


<!-- Footer Start -->
<jsp:directive.include file="../fragment/footer.jsp"/>
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