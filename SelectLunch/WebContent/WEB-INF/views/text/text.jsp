<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
function addList(){ 
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
	<div>
		<div >
			<h2>EMP List</h2>
			<table>
				<thead>
					<tr>
						<th>Number</th>
						<th>Name</th>
						<th>Job</th>
						<th>Sal</th>
						<th>HireDate</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="test" items="${test}">
						<tr>
							<td>${test.EMPNO}</td>
							<td>${test.ENAME}</td>
							<td>${test.JOB}</td>
							<td>${test.SAL}</td>
							<td>${test.HIREDATE}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
<br>
<input type="text" name="addText" id="addText"/>
<input type="button" value="add" onclick="addList();"/>
<br>
<ul id="Randomlist">
</ul>

</body>
</html>