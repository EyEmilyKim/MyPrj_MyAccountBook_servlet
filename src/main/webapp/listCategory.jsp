<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listCategory.jsp</title>
<style type="text/css">
#
</style>
</head>
<body>
<div>
	<p>카테고리 목록</p>
<%-- 	<c:set var="size" value="${SIZE }"/> --%>
	총 ${SIZE }건<br>
	<form action="">
	<table border="1">
		<tr><td>일련번호hidden</td><td>구분</td><td>이름</td></tr>
	<c:forEach items="${LIST }" var="c">
		<tr>
		<td><input type="text" value="${c.seqno }"></td>
		<c:if test="${c.inex == 'In' }"><td>수입</td><td>${c.cate_name }</td></c:if>
		<c:if test="${c.inex == 'EX' }"><td>지출</td><td>${c.cate_name }</td></c:if>
		<td id="${c.seqno }">
			<input type="button" value="수정" onClick="openUpdate(${c.cate_code })">
			<input type="button" value="삭제" onClick="openDelete(${c.cate_code })">
		</td>
		</tr>
	</c:forEach>
	</table>
	</form><br>
	<div class="button">
	<a href="editCategory.do">추가하기</a>
	<input type="button" value="편집하기" onClick="onMod()" id="ON_MOD">
	<input type="button" value="편집완료" onClick="offMod(${SIZE })" id="OFF_MOD">
	</div>
</div>
</body>

<script type="text/javascript">
function onMod(){
	alert("onMod()호출됨");
	alert("round : "+ round);
	for(int i=1; i<round+1; i++){

	alert("selected row ID : "+ i);
	}	
// 	document.getElementById().style.display = "none";
}		
function offMod(round){
	alert("offMod("+round+")호출됨");
// 	document.getElementById().style.display = "block";	
}
</script>
</html>