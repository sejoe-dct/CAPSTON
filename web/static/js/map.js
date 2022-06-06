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
//const map = new kakao.maps.Map(mapContainer, mapOption);


// 지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);
// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.LEFT);