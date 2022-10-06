<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginResult.jsp</title>
</head>
<body>
<c:if test="${param.R == 'NOID' }">
	<script type="text/javascript">
		alert("계정이 존재하지 않습니다.");
		location.href="login.jsp";
	</script>
</c:if>
<c:if test="${param.R == 'NOPWD' }">
	<script type="text/javascript">
		alert("암호가 일치하지 않습니다.");
		location.href="login.jsp";
	</script>
</c:if>
<c:if test="${param.R == 'OK' }">
	<script type="text/javascript">
		alert("로그인 되었습니다.\n반갑습니다 XXX님~~");
		location.href="index.jsp";
	</script>
</c:if>
</body>
</html>