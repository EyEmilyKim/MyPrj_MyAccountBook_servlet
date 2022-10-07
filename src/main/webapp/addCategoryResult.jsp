<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCategoryResult.jsp</title>
</head>
<body>
<c:if test="${param.R == 'Y' }">
	<script type="text/javascript">
		alert("카테고리가 등록되었습니다.");	
	</script>
</c:if>
<c:if test="${param.R == 'N' }">
	<script type="text/javascript">
		alert("카테고리 등록에 실패했습니다. 관리자에게 문의해주세요.");	
	</script>
</c:if>
</body>
<script type="text/javascript">
	location.href="listCategory.jsp";
</script>
</html>