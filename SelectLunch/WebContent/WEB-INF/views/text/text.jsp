<%@ page language="java" contentType="text/html; pageEncoding=utf-8"%>
<%
	String text = (String) request.getAttribute("text");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf">
<script type="text/javascript">
var i = null;
function addList(){ //리스트 추가 함수 
	var list = document.getElementById('Randomlist');
	var title = document.getElementById('addText').value;
	i++;
	
	if(list.firstChild != null){
		var randomList = list.getElementsByTagName('li');
		var inum = "text"+randomList.length + i;
	}
	list.innerHTML += '<li value='+inum+'>' + title +" "+ '<input type="button" onclick='+inum+' value="delete"></button></li>';
	title.setAttribute('value', "");
}
</script>
<title>Insert title here</title>
</head>
<body>
	will be text here
	<%=text%>
<br>
<input type="text" name="addText" id="addText"/>
<input type="button" value="add" onclick="addList();"/>
<br>
<ul id="Randomlist">
</ul>

</body>
</html>