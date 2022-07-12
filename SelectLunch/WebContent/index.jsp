<%@ page language="java" contentType="text/html; pageEncoding=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script language="javascript" type="text/javascript">
	function mapTest() {
		document.MapForm.submit();
	}
	
	function textTest() {
		document.textForm.submit();
	}
</script>

</head>
<body>
	<form name="MapForm" method="post" action="/SelectLunch/main">
		<input type="hidden" name="test" value="mapmap">
	</form>
	<form name="textForm" method="post" action="/SelectLunch/text">
		<input type="hidden" name="test" value="txttxt">
	</form>
	"hi"
	<button onclick="mapTest();">gotomap</button>
	<button onclick="textTest();">gototext</button>
</body>
</html>