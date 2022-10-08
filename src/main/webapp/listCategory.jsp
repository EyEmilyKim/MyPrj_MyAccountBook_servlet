<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listCategory.jsp</title>
</head>
<body>
<div>
	<p>카테고리 목록</p>
	총 ${SIZE }건<br>
	<table border="1">
	<tr><td>seqno</td><td>cate_code</td><td>inex</td><td>cate_name</td>
	<c:forEach items="${LIST }" var="c">
		<c:set var="url" value="detailCategory.do?CCODE=${c.cate_code }"/>	
			<tr>
				<td>${c.seqno }</td><td>${c.cate_code }</td>
				<c:if test="${c.inex == 'In' }"><td>수입</td><td>${c.cate_name }</td></c:if>
				<c:if test="${c.inex == 'IN' }"><td>수입</td><td>${c.cate_name }</td></c:if>
				<c:if test="${c.inex == 'EX' }"><td>지출</td><td>${c.cate_name }</td></c:if>
				<td><a href="${url }" onclick="jumpUpdate(this)">수정하기</a></td>
				<td>
<!-- 					<input type="submit" value="수정"> -->
					<input type="button" value="삭제" onClick="openDelete()">
				</td>
				<td><c:out value="${url }"></c:out></td>
			</tr>
	</c:forEach>
	</table>
	<br>
	<div class="buttons">
	<a href="editCategory.do">추가하기</a>
	</div>
</div>
</body>

<script type="text/javascript">

// function jumpUpdate(thisA){
// 	alert("jumpUpdate(thisA)호출됨");
// 	window.open(thisA.href, '카테고리 수정', 'width=400, height=600');
// }

// function openDelete(){
// 	alert("openDelete()호출됨");
	
// }
</script>
</html>