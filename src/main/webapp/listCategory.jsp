<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listCategory.jsp</title>
	<style type="text/css">
	#in { color:blue; } #ex { color:red; } #sys { background-color:beige; }
	.hidden { display:none; }
	</style>
</head>
<body>
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
<div>
	<p>카테고리 목록</p>
	총 ${SIZE } 건<br>
	<table border="1">
	<tr><td>seqno</td><td>cate_code</td><td>inex</td><td>cate_name</td>
	<c:forEach items="${LIST }" var="c">
		<c:set var="url" value="detailCategory.do?CCODE=${c.cate_code }&MOD="/>	
	  <!-- choose when: system용 '미지정'은 별도 tr로.   -->
	  <!-- otherwise: 사용자용 '수입'/'지출'은 같은 tr 내 일부 td만 다르게 처리  -->
	  <c:choose>
		<c:when test="${c.inex == 'caNN' }">
			<tr id="sys">
				<td>${c.seqno }</td><td>${c.cate_code }</td>
				<td>기본</td><td>${c.cate_name }</td>
				<td><a href="${url }" onClick="popupUpdate(this); return false;">수정</a></td>
				<td><a href="${url }" onClick="popupDelete(this); return false;">삭제</a></td>
				<td>url : <c:out value="${url }"></c:out></td>
		</c:when>
		<c:otherwise>
			<tr><td>${c.seqno }</td><td>${c.cate_code }</td>
				<c:if test="${c.inex == 'IN' }"><td id="in">수입</td><td>${c.cate_name }</td></c:if>
				<c:if test="${c.inex == 'EX' }"><td id="ex">지출</td><td>${c.cate_name }</td></c:if>
				<td><a href="${url }" onClick="popupUpdate(this); return false;">수정</a></td>
				<td><a href="${url }" onClick="popupDelete(this); return false;">삭제</a></td>
				<td>url : <c:out value="${url }"></c:out></td>
			</tr>
	    </c:otherwise>
	  </c:choose>
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