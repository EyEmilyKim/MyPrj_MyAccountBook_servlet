<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signUpResult.jsp</title>
</head>
<body>
<c:if test="${param.R == 'true' }">
	<script type="text/javascript">
		alert("환영합니다! :) \n회원가입에 성공했습니다. ");
		location.href="index.jsp";
	</script>
</c:if>
<c:if test="${param.R == 'false' }">
	<script type="text/javascript">
		alert("회원가입에 실패했습니다. 관리자에게 문의하세요.");
		location.href="index.jsp";
	</script>
</c:if>
</body>
</html>