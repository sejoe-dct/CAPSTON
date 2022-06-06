<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
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
            for (let vertex in this.adjacencyList) {//점과 점 사이 거리 초기화
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

        //var graph = new WeightedGraph();

        //graph.addEdge(address1, address2 , d);

        return d;
    }

    //EXAMPLES=====================================================================

    /* var graph = new WeightedGraph();
     graph.addVertex("A");
     graph.addVertex("B");
     graph.addVertex("C");
     graph.addVertex("D");
     graph.addVertex("E");
     graph.addVertex("F");

     graph.addEdge("A", "B", 4);
     graph.addEdge("A", "C", 2);
     graph.addEdge("B", "E", 3);
     graph.addEdge("C", "D", 2);
     graph.addEdge("C", "F", 4);
     graph.addEdge("D", "E", 3);
     graph.addEdge("D", "F", 1);
     graph.addEdge("E", "F", 1);

     console.log(graph.Dijkstra("A", "E"));
     */


</script>