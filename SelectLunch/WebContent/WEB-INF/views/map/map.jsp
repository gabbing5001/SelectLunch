<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; pageEncoding=utf-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String map = (String) request.getAttribute("map");
	System.out.println("dhk");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- jsp파일들은 서버쪽에있기때문에 아래 경로를 이렇게 하면안돼 
    위의 c 라이브러리로 쓴거다.
    servlet-context 16줄 참고-->
<link href="<c:url value="/resources/css/map.css"/>" rel="stylesheet" type="text/css">
<title>Insert title here</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e5c58acfef16e1c7aa7143d4084fe0f1&libraries=services,clusterer,drawing"></script>
<script>
//키워드 검색을 요청하는 함수입니다
var nowPage=0;
function searchPlaces() {
    var keyword = document.getElementById('keyword').value;
    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }
    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}
// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);
        // 페이지 번호를 표출합니다
        displayPagination(pagination);
    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        alert('검색 결과가 존재하지 않습니다.');
        return;
    } else if (status === kakao.maps.services.Status.ERROR) {
        alert('검색 결과 중 오류가 발생했습니다.');
        return;
    }
}
// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);
    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    var newmarking = 0;
	if(nowPage!=0){newmarking = (nowPage * 15) - 15}
    //newmarking = (pagination.current * 15) - 15 //이미지가 15번까지 밖에 없음 
    for ( var i=0; i<places.length; i++ ) {
    	newmarking++;
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);
        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });
            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });
            
            kakao.maps.event.addListener(marker, 'click', function() {
            	displayRandomList(marker, title);
            });
            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };
            
            itemEl.onclick =  function () {
                displayRandomList(marker, title);
            };
            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);
        fragment.appendChild(itemEl);
    }
    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}
// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {
    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';
    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           
    el.innerHTML = itemStr;
    el.className = 'item';
    return el;
}
// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다 마커 이미지가 15까지 밖에 없음  
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
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
// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 
    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }
    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;
        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                	nowPage=i;
                    pagination.gotoPage(i);
                }
            })(i);
        }
        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}
// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
    infowindow.setContent(content);
    infowindow.open(map, marker);
}
//클릭시 랜덤 리스트에 추가 되는 함수 
function displayRandomList(marker, title) {
	var list = document.getElementById("Randomlist");
	var titleV = title.replace(/(\s*)/g,""); //공백제거
	
	//innerHtml에서 input onclick 함수 호출시 파라미터를 넘기기 위해 
	var text="'" + titleV + "'"
	var delTitle = '"deleteList(' + text + ')";';
	
	var checkShop = true;
	if(list.firstChild != null){ //처음일경우 체크
		var randomList = list.getElementsByTagName('li');
		for(var i=0; i<randomList.length; i++){ //이미 선택한 마커인지 확인
	    	if(title == randomList[i].innerText.trim()){
	    		alert("이미 선택한 장소 입니다.")
				checkShop = false;
	    	}
		}
		
		if(checkShop)//리스트에 없는 경우에만 추가 가능 
			list.innerHTML += '<li value='+titleV+'>' + title +" "+ '<input type="button" onclick='+delTitle+' value="delete"></button></li>';
	}else{
		list.innerHTML += '<li value='+titleV+'>' + title +" "+ '<input type="button" onclick='+delTitle+' value="delete"></button></li>';
	}
}
//랜덤 리스트 제거 함수 
function deleteList(title){
	var list = document.getElementById("Randomlist");
	var randomList = list.getElementsByTagName('li');
	for(var i=0; i<randomList.length; i++){
		var findTxt = randomList[i].innerText.replace(/(\s*)/g,"");//공백제거
    	if(title == findTxt){//버튼누른 녀석과 비교 
    		randomList[i].remove(); //리스트에서 삭제 
    	}
	}
}
 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
</script>
</head>
<body>
	will be map here
	<%=map%>
<div class="option">
    <div>
        <form onsubmit="searchPlaces(); return false;" accept-charset="utf-8">
            키워드 : <input type="text" value="가로수길 맛집" id="keyword" size="15"> 
            <button type="submit">검색하기</button> 
        </form>
    </div>
</div>
<br>
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div  class="bg_white">
        
        <div id="menu_wrap">
	        <!--<hr>-->
	        <ul id="placesList"></ul>
        </div>
    </div>
</div>
<br>
<div id="pagination"></div>
<script>
// 마커를 담을 배열입니다
var markers = [];
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 
// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  
// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});
// 키워드로 장소를 검색합니다
searchPlaces();
</script>
<hr>
<ul id="Randomlist"></ul>
</body>
</html>