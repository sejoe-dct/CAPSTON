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
        this.adjacencyList[vertex1].push({node: vertex2, weight});
        this.adjacencyList[vertex2].push({node: vertex1, weight});
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
        return deg * (Math.PI / 180);
    }

    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1);  // deg2rad below
    var dLon = deg2rad(lng2 - lng1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km

    return d;
}

//////호출했을 때 my_map_root.jsp 에서 값 받아오는 함수로 init()생성, 안에 소스 옮김

/*
console.log("값 전달 됨 " + localStorage.getItem("arrAddress"));
console.log("값 전달 됨 " + localStorage.getItem("arrLat"));
console.log("값 전달 됨 " + localStorage.getItem("arrLng"));

var strAddress = localStorage.getItem("arrAddress");
var strLat = localStorage.getItem("arrLat");
var strLng = localStorage.getItem("arrLng");

var arrAddress = new Array();
var arrLat = new Array();
var arrLng = new Array();
/!*
 function(data) {
    console.log(data);
    var workList= data.split('.');   --->//var workList= (data||'').split('.'); 오류 검색
}*!/
//var jbString = 'abc,def,ghi';
var addSplit = (strAddress || '').split(',');
for (var i in addSplit) {
    arrAddress.push(addSplit[i]);
}
var latSplit = (strLat || '').split(',');
for (var i in latSplit) {
    arrLat.push(latSplit[i]);
}
var lngSplit = (strLng || '').split(',');
for (var i in lngSplit) {
    arrLng.push(lngSplit[i]);
}

var firstIndex = 0;
var lastIndex = arrAddress.length - 1;

var perAddress = (getPermutations(arrAddress, 2));
var perLat = (getPermutations(arrLat, 2));
var perLng = (getPermutations(arrLng, 2));
*/

//document.write('<p>' + "vertexList " + perAddress + '</p>');
//document.write('<p>' + "vertexList length" + perAddress.length + '</p>');


/////////

function getMin(verDisList, index) {
    var numList = [[1,2],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5],[3,4],[3,5],[4,5]];
    for(var i=0;i<Math.ceil(numList.length/2);i++){
        console.log(("numList 값 "+numList));
        //numList[i].remove(i);
        for(var j=0;;j++){
            if(numList[i][0]!=1) {//
                break;
            }
            numList.splice(0,1);
        }
    for (var i = 0; i < Math.ceil(perAddress.length / 2); i++) {
        while (1) {
            console.log(("verDisList 값 "+verDisList));
            if (index == verDisList[i][0]) {
                if (verDisList[i][2] = Math.min(...verDisList[i][2])) {
                    var min1 = Math.min(...verDisList[i][2]);//거리 최소값 저장
                    index = verDisList[i][0];//최소값이 되는 주소
                    verDisList.splice(0,1);
                }


            }
            i++;
            console.log("최소값 " + min1);

            //minPath.push(min)
        }
        while (index == verDislist[i][0]) {
            //var myArray = [1, 5, 6, 2, 3];
            //var m = Math.min(...myArray);
            //console.log(m)
            var min = Math.min(...verDislist[i][2]);
            console.log("최소값 " + min);

            //minPath.push(min)
        }
    }
    return index;
}

//최단경로를 구하는 함수
function getShortCut() {
    console.log("값 전달 됨 " + localStorage.getItem("arrAddress"));
    console.log("값 전달 됨 " + localStorage.getItem("arrLat"));
    console.log("값 전달 됨 " + localStorage.getItem("arrLng"));

    var strAddress = localStorage.getItem("arrAddress");
    var strLat = localStorage.getItem("arrLat");
    var strLng = localStorage.getItem("arrLng");

    var arrAddress = new Array();
    var arrLat = new Array();
    var arrLng = new Array();

    /*
     function(data) {
        console.log(data);
        var workList= data.split('.');   --->//var workList= (data||'').split('.'); 오류 검색
    }*/
//var jbString = 'abc,def,ghi';
    var addSplit = (strAddress || '').split(',');
    for (var i in addSplit) {
        arrAddress.push(addSplit[i]);
    }
    var latSplit = (strLat || '').split(',');
    for (var i in latSplit) {
        arrLat.push(latSplit[i]);
    }
    var lngSplit = (strLng || '').split(',');
    for (var i in lngSplit) {
        arrLng.push(lngSplit[i]);
    }

    var firstIndex = 0;
    var lastIndex = arrAddress.length - 1;

    var perAddress = (getPermutations(arrAddress, 2));
    var perLat = (getPermutations(arrLat, 2));
    var perLng = (getPermutations(arrLng, 2));
////////시작
    //var graph = new WeightedGraph(); //그래프

    var finishPos = null; //도착 건물의 좌표
    var linePath = []; //최단경로를 이루는 정점들의 좌표를 저장할 배열

    var graph = new WeightedGraph();

    for (var i = 0; i < arrAddress.length; i++) {
        graph.addVertex(arrAddress[i]);
        console.log("arrAddress " + arrAddress[i]);
        // graph.addVertex(perAddress[i][1]);
    }
    var verDislist = new Array();
    for (var i = 0; i < (perAddress.length) / 2; i++) {
        /*   var k = getDistanceFromLatLonInKm(arrAddress[n], arrAddress[m], arrLat[n], arrLng[n], arrLat[m], arrLng[m]);
           console.log("폴 문  "+ arrAddress[n]+ " "+ arrAddress[i+1]+" "+  arrLat[i] + " "+ arrLng[i] + " " + arrLat[i+1] + " " + arrLng[i+1]);*/
        var d = getDistanceFromLatLonInKm(perAddress[i][0], perAddress[i][1], perLat[i][0], perLng[i][0], perLat[i][1], perLng[i][1]);
        console.log("폴 문  " + perAddress[i][0] + " " + perAddress[i][1] + " " + perLat[i][0] + " " + perLng[i][0] + " " + perLat[i][1] + " " + perLng[i][1]);

        verDislist.push(perAddress[i][0], perAddress[i][1], d); //점과 점 사이 거리 구한 값 리스트에 넣기
        console.log("k값 : " + d);

        //    graph.addEdge(perAddress[i][0], perAddress[i][1], d);
    }
    var index = arrAddress[0];//첫번째 주소
    var indexList = new Array();
    for (var i=0; i < arrLng.length; i++) {

        index = getMin(verDislist, index);
        indexList.push(index);

    }


        //numList.splice(0,1);
    }


    // console.log(graph.Dijkstra(arrAddress[firstIndex], arrAddress[lastIndex]));

    //그래프 생성
    //  path = graph.Dijkstra(arrAddress[firstIndex], arrAddress[lastIndex]); //다익스트라 알고리즘을 통해 최단경로를 구성하는 정점들을 배열에 저장

    /*   for (i = 0; i < path.length; i++) {
           console.log(path[i]);

           for (j = 0; j < arrLat.length; j++) {
               if (arrAddress[j] == path[i]) {//최단 경로를 이루는 정점의 좌표 저장
                   linePath.push(new kakao.maps.LatLng(arrLat[j], arrLng[j]));
             //      linePath.push(new kakao.maps.LatLng(vertexData[j][1], vertexData[j][2]));
               }

               if (arrAddress[j] == arrAddress[lastIndex]) { //종점 좌표
                   finishPos = new kakao.maps.LatLng(arrLat[j], arrLng[j]);
               }

           }
       }*/

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
    infowindow.setContent("<div class='path_info'>" + shortDis + "m<br>" + "도보 약 " + shortTime + "분</div>");
    infowindow.open(map, finishMarker); //도착지 마커 위에 표시

    //인포윈도위 기본 디자인 초기화
    initInfoWindow = document.querySelectorAll('.path_info');
    initInfoWindow.forEach(function (e) {
        var w = e.offsetWidth + 10;
        var ml = w / 2;
        e.parentElement.style.top = "5px";
        e.parentElement.style.left = "50%";
        e.parentElement.style.marginLeft = -ml + "px";
        e.parentElement.style.width = w + "px";
        e.parentElement.previousSibling.style.display = "none";
        e.parentElement.parentElement.style.border = "0px";
        e.parentElement.parentElement.style.background = "unset";
    });

}

function mainFunc() { //html의 검색 버튼과 이어줄 함수
    //   init();
    getShortCut(); //최단경로를
}