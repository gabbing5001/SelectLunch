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
</script>

</head>
<body>
	<form name="MapForm" method="post" action="/SelectLunch/main">
		<input type="hidden" name="test" value="mapmap">
	</form>
	"hi"
	<button onclick="mapTest();">gotomap</button>
</body>
</html>