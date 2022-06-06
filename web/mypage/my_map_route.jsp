<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="comm.Comm_data" %>
<%@ page import="bbs.*" %>
<%@ page import="comm.Comm_dataDAO" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:directive.include file="mypage_head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="mypage_nav.jsp"/>

<%--<script>
    var shortDis = null;
    var shortTime = null;
    //최단경로를 그리기 위한 폴리라인
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

    //인포윈도우를 커스텀할 떄 요소들을 초기화할 때 사용할 변수
    var initInfoWindow = null;

    class Node {
        constructor(val, priority) {
            this.val = val;
            this.priority = priority;
        }
    }

    class PriorityQueue {
        constructor() {
            this.values = [];
        }
        enqueue(val, priority) {
            let newNode = new Node(val, priority);
            this.values.push(newNode);
            this.bubbleUp();
        }
        bubbleUp() {
            let idx = this.values.length - 1;
            const element = this.values[idx];
            while (idx > 0) {
                let parentIdx = Math.floor((idx - 1) / 2);
                let parent = this.values[parentIdx];
                if (element.priority >= parent.priority) break;
                this.values[parentIdx] = element;
                this.values[idx] = parent;
                idx = parentIdx;
            }
        }
        dequeue() {
            const min = this.values[0];
            const end = this.values.pop();
            if (this.values.length > 0) {
                this.values[0] = end;
                this.sinkDown();
            }
            return min;
        }
        sinkDown() {
            let idx = 0;
            const length = this.values.length;
            const element = this.values[0];
            while (true) {
                let leftChildIdx = 2 * idx + 1;
                let rightChildIdx = 2 * idx + 2;
                let leftChild, rightChild;
                let swap = null;

                if (leftChildIdx < length) {
                    leftChild = this.values[leftChildIdx];
                    if (leftChild.priority < element.priority) {
                        swap = leftChildIdx;
                    }
                }
                if (rightChildIdx < length) {
                    rightChild = this.values[rightChildIdx];
                    if (
                        (swap === null && rightChild.priority < element.priority) ||
                        (swap !== null && rightChild.priority < leftChild.priority)
                    ) {
                        swap = rightChildIdx;
                    }
                }
                if (swap === null) break;
                this.values[idx] = this.values[swap];
                this.values[swap] = element;
                idx = swap;
            }
        }
    }

    //Dijkstra's algorithm only works on a weighted graph.

    class WeightedGraph {
        constructor() {
            this.adjacencyList = {};
        }
        addVertex(vertex) {
            if (!this.adjacencyList[vertex]) this.adjacencyList[vertex] = [];
        }
        addEdge(vertex1, vertex2, weight) {
            this.adjacencyList[vertex1].push({ node: vertex2, weight });
            this.adjacencyList[vertex2].push({ node: vertex1, weight });
        }
        Dijkstra(start, finish) {
            const nodes = new PriorityQueue();
            const distances = {};
            const previous = {};
            let path = []; //to return at end
            let smallest;
            //build up initial state
            for (let vertex in this.adjacencyList) {
                if (vertex === start) {
                    distances[vertex] = 0;
                    nodes.enqueue(vertex, 0);
                } else {
                    distances[vertex] = Infinity;
                    nodes.enqueue(vertex, Infinity);
                }
                previous[vertex] = null;
            }
            // as long as there is something to visit
            while (nodes.values.length) {
                smallest = nodes.dequeue().val;
                if (smallest === finish) {
                    //WE ARE DONE
                    //BUILD UP PATH TO RETURN AT END

                    shortDis = Math.round(distances[finish]);
                    shortTime = Math.round((shortDis / 1.2 / 60));

                    console.log(shortDis + "m");
                    console.log("도보로 약 " + shortTime + "분이 소요됩니다.");

                    while (previous[smallest]) {
                        path.push(smallest);
                        smallest = previous[smallest];
                    }
                    break;
                }
                if (smallest || distances[smallest] !== Infinity) {
                    for (let neighbor in this.adjacencyList[smallest]) {
                        //find neighboring node
                        let nextNode = this.adjacencyList[smallest][neighbor];
                        //calculate new distance to neighboring node
                        let candidate = distances[smallest] + nextNode.weight;
                        let nextNeighbor = nextNode.node;
                        if (candidate < distances[nextNeighbor]) {
                            //updating new smallest distance to neighbor
                            distances[nextNeighbor] = candidate;
                            //updating previous - How we got to neighbor
                            previous[nextNeighbor] = smallest;
                            //enqueue in priority queue with new priority
                            nodes.enqueue(nextNeighbor, candidate);
                        }
                    }
                }
            }
            return path.concat(smallest).reverse();
        }
    }

    /////////////////거리시작
    const getPermutations = function (arr, selectNumber) {
        const results = [];
        if (selectNumber === 1) return arr.map((value) => [value]); // 1개씩 택할 때, 바로 모든 배열의 원소 return

        arr.forEach((fixed, index, origin) => {
            const rest = [...origin.slice(0, index), ...origin.slice(index + 1)]; // 해당하는 fixed를 제외한 나머지 배열
            const permutations = getPermutations(rest, selectNumber - 1); // 나머지에 대해 순열을 구한다.
            const attached = permutations.map((permutation) => [fixed, ...permutation]); // 돌아온 순열에 대해 떼 놓은(fixed) 값 붙이기
            results.push(...attached); // 배열 spread syntax 로 모두다 push
        });

        return results; // 결과 담긴 results return
    };

    function getDistanceFromLatLonInKm(address1, address2, lat1, lng1, lat2, lng2) {
        function deg2rad(deg) {
            return deg * (Math.PI/180);
        }
        var R = 6371; // Radius of the earth in km
        var dLat = deg2rad(lat2-lat1);  // deg2rad below
        var dLon = deg2rad(lng2-lng1);
        var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2);
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        var d = R * c; // Distance in km

        return d;
    }


    console.log("값 전달 됨 "+ localStorage.getItem("arrAddress"));
    console.log("값 전달 됨 "+ localStorage.getItem("arrLat"));
    console.log("값 전달 됨 "+ localStorage.getItem("arrLng"));

    var strAddress = localStorage.getItem("arrAddress");
    var strLat = localStorage.getItem("arrLat");
    var strLng = localStorage.getItem("arrLng");

    var arrAddress = new Array();
    var arrLat = new Array();
    var arrLng = new Array();

    //var jbString = 'abc,def,ghi';
    var addSplit = strAddress.split(',');
    for ( var i in addSplit ) {
        arrAddress.push(addSplit[i]);
    }
    var latSplit = strLat.split(',');
    for ( var i in latSplit ) {
        arrLat.push(latSplit[i]);
    }
    var lngSplit = strLng.split(',');
    for ( var i in lngSplit ) {
        arrLng.push(lngSplit[i]);
    }

    var firstIndex = 0;
    var lastIndex = arrAddress.length - 1;

    var perAddress = (getPermutations(arrAddress,2));
    var perLat = (getPermutations(arrLat,2));
    var perLng = (getPermutations(arrLng,2));

    document.write( '<p>' + "vertexList " + perAddress+ '</p>' );
    document.write( '<p>' + "vertexList length" + perAddress.length + '</p>' );


    /////////


    //최단경로를 구하는 함수
    function getShortCut() {

        //var graph = new WeightedGraph(); //그래프

        var finishPos = null; //도착 건물의 좌표
        var linePath = []; //최단경로를 이루는 정점들의 좌표를 저장할 배열

        var graph = new WeightedGraph();

        for (var i = 0; i< arrAddress.length; i++){
            graph.addVertex(arrAddress[i]);
            console.log("arrAddress "+arrAddress[i]);
            // graph.addVertex(perAddress[i][1]);
        }

        for (var i = 0; i < (perAddress.length)/2; i++)
        {
            /*   var k = getDistanceFromLatLonInKm(arrAddress[n], arrAddress[m], arrLat[n], arrLng[n], arrLat[m], arrLng[m]);
               console.log("폴 문  "+ arrAddress[n]+ " "+ arrAddress[i+1]+" "+  arrLat[i] + " "+ arrLng[i] + " " + arrLat[i+1] + " " + arrLng[i+1]);*/
            var d = getDistanceFromLatLonInKm(perAddress[i][0], perAddress[i][1], perLat[i][0], perLng[i][0], perLat[i][1], perLng[i][1]);
            console.log("폴 문  "+ perAddress[i][0]+ " "+ perAddress[i][1]+" "+  perLat[i][0] + " "+ perLng[i][0] + " " + perLat[i][1] + " " + perLng[i][1]);

            console.log("k값 : "+ d);

            graph.addEdge(perAddress[i][0], perAddress[i][1] , d);
        }


        console.log(graph.Dijkstra(arrAddress[firstIndex], arrAddress[lastIndex]));

        //그래프 생성
        path =  graph.Dijkstra(arrAddress[firstIndex], arrAddress[lastIndex]); //다익스트라 알고리즘을 통해 최단경로를 구성하는 정점들을 배열에 저장

        for (i = 0; i < path.length; i++) {
            console.log(path[i]);

            for (j = 0; j < arrLat.length; j++) {
                if (arrAddress[j] == path[i]) {//최단 경로를 이루는 정점의 좌표 저장
                    linePath.push(new kakao.maps.LatLng(arrLat[1], arrLng[2]));
                }
                if (arrAddress[0] == arrAddress[lastIndex]) { //종점 좌표
                    finishPos = new kakao.maps.LatLng(arrLat[lastIndex], arrLng[lastIndex]);
                }
            }
        }




        //최단경로
        polyline.setMap(null); //이전에 그려져있던 경로 삭제
        polyline.setPath(linePath);
        polyline.setMap(map);  //지도에 경로 표시

        //도착지 마커
        finishMarker.setMap(null); //이전에 표시되어 있던 마커 삭제
        finishMarker.setPosition(finishPos);
        finishMarker.setMap(map); //지도에 마커 표시

        // 인포윈도우
        infowindow.close(); //이전 검색기록의 인포윈도우 삭제
        infowindow.setPosition(finishPos);
        infowindow.setContent("<div class='path_info'>"+shortDis + "m<br>" + "도보 약 " + shortTime + "분</div>");
        infowindow.open(map, finishMarker); //도착지 마커 위에 표시

        //인포윈도위 기본 디자인 초기화
        initInfoWindow = document.querySelectorAll('.path_info');
        initInfoWindow.forEach(function(e) {
            var w = e.offsetWidth + 10;
            var ml = w/2;
            e.parentElement.style.top = "5px";
            e.parentElement.style.left = "50%";
            e.parentElement.style.marginLeft = -ml+"px";
            e.parentElement.style.width = w+"px";
            e.parentElement.previousSibling.style.display = "none";
            e.parentElement.parentElement.style.border = "0px";
            e.parentElement.parentElement.style.background = "unset";
        });

    }
</script>--%>
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
        <%-- <div id="map" style="width:100%;height:350px;"></div>--%>
        <script src="../static/js/map.js"></script>
        <button type="button" class="btn btn-lg btn-light" id="search_button" onclick="mainFunc()">검색</button>

        <script>
           /* const mapContainer = document.getElementById('map'), // 지도를 표시할 div   여기 새로 주석처리함 !!!
                mapOption = {
                    center: new kakao.maps.LatLng(37.5666805, 126.9784147), // 지도의 중심좌표
                    level: 4
                    //   level: 5 // 지도의 확대 레벨
                };*/
            // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
            /*    var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}),
                    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
                    markers = [], // 마커를 담을 배열입니다
                    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
             */   // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
            //const map = new kakao.maps.Map(mapContainer, mapOption);


            // 지도를 생성합니다
         //   var map = new kakao.maps.Map(mapContainer, mapOption);
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
                    //이벤트 위치 값
                    var mLatLng = new kakao.maps.LatLng(result[0].y, result[0].x);
                    var lng = mLatLng.getLng();
                    var lat = mLatLng.getLat();

                    //조건에 해당하는 값을 배열에 순차대로 넣기

                    arrAddress.push((result[0]).address_name);
                    arrLat.push(lat);
                    arrLng.push(lng);

                    localStorage.setItem("arrAddress",arrAddress);
                    localStorage.setItem("arrLat",arrLat);
                    localStorage.setItem("arrLng",arrLng);

                    //프린트

                    console.log("위도 " + lng + "경도 " + lat);


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
                    //   $("input[name=lat]").val(result[0].y);
                    marker = new kakao.maps.Marker({
                        map: map,
                        position: coords,
                        image : markerImage2
                    });
                    map.setCenter(coords);
                }
            };






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
        <script src="../static/lib/wow/wow.min.js"></script>
        <script src="../static/js/map_route.js"></script>
        <script src="../static/lib/waypoints/waypoints.min.js"></script>
        <script src="../static/lib/counterup/counterup.min.js"></script>
        <script src="../static/lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="../static/lib/isotope/isotope.pkgd.min.js"></script>
        <script src="../static/lib/lightbox/js/lightbox.min.js"></script>

        <!-- Template Javascript -->
        <script src="../static/js/main.js"></script>
</body>


</html>