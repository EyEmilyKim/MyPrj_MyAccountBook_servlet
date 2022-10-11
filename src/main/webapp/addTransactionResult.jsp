<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addTransactionResult.jsp</title>
</head>
<body>
<c:if test="${param.R == 'Y' }">
	<script type="text/javascript">
		alert("가계부가 등록되었습니다.");	
	</script>
</c:if>
<c:if test="${param.R == 'N' }">
	<script type="text/javascript">
		alert("가계부 등록에 실패했습니다. 관리자에게 문의해주세요.");	
	</script>
</c:if>
<script type="text/javascript">
	if(confirm("이어서 가계부를 작성하시겠습니까?")){
		location.href = "makeAddTrans.do"
	}else{
		location.href = "listTransaction.jsp"
	}
</script>
</body>
</html>