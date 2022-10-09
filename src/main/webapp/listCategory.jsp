<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listCategory.jsp</title>
	<style type="text/css">
	#in { color:blue; } #ex { color:red; }
	</style>
</head>
<body>
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
<div>
	<p>카테고리 목록</p>
	총 ${SIZE }건<br>
	<table border="1">
	<tr><td>seqno</td><td>cate_code</td><td>inex</td><td>cate_name</td>
	<c:forEach items="${LIST }" var="c">
		<c:set var="url" value="detailCategory.do?CCODE=${c.cate_code }&MOD="/>	
			<tr>
				<td>${c.seqno }</td><td>${c.cate_code }</td>
				<c:if test="${c.inex == 'IN' }"><td id="in">수입</td><td>${c.cate_name }</td></c:if>
				<c:if test="${c.inex == 'EX' }"><td id="ex">지출</td><td>${c.cate_name }</td></c:if>
				<td><a href="${url }" onClick="popupUpdate(this); return false;">수정</a></td>
				<td><a href="${url }" onClick="popupDelete(this); return false;">삭제</a></td>
				<td>url : <c:out value="${url }"></c:out></td>
			</tr>
	</c:forEach>
	</table>
	<br>
	<div class="buttons">
	<a href="getCateSeqno.do" onClick="popupAdd(this); return false;">추가하기</a>
	</div>
</div>
</body>

<script type="text/javascript">
function popupUpdate(thisA){
	alert("popupUpdate(thisA)호출됨");
	let url = thisA.href + 'UPD';
	alert("url : "+url);
	window.open(url, '카테고리 수정하기', 'width=450, height=500');
}

function popupDelete(thisA){
	alert("popupDelete(thisA)호출됨");
	let url = thisA.href + 'DEL';
	alert("url : "+url);
	window.open(url, '카테고리 삭제하기', 'width=450, height=500');
}

function popupAdd(thisA){
	alert("popupAdd(thisA)호출됨");
	alert("url : "+thisA.href);
	window.open(thisA.href, '카테고리 추가하기', 'width=450, height=500');
}
</script>
</html>