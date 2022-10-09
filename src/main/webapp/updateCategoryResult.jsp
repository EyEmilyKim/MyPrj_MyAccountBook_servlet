<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCategoryResult.jsp</title>
</head>
<body>
<c:if test="${param.R == true }">
	<script type="text/javascript">
		alert("카테고리가 수정되었습니다.");	
	</script>
</c:if>
<c:if test="${param.R == false }">
	<script type="text/javascript">
		alert("카테고리 수정에 실패했습니다. 관리자에게 문의해주세요.");	
	</script>
</c:if>
</body>
<script type="text/javascript">
	opener.location.reload();
	window.close();
</script>
</html>