<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listMethod.jsp</title>
	<style type="text/css">
	#mn { color:blue; } #crd { color:orange; } #sys { background-color:beige; }
	.hidden { display:none; }
	</style>
</head>
<body>
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
<div>
	<p>결제수단 목록</p>
	총 ${SIZE } 건<br>
	<table border="1">
		<tr id="title"><td>seqno</td><td>meth_code</td><td>mncrd</td><td>meth_name</td></tr>
	<c:forEach items="${LIST }" var="m">
		<c:set var="url" value="detailMethod.do?MCODE=${m.meth_code }&MOD="/>	
	  <!-- choose when: system용 '미지정'은 별도 tr로.   -->
	  <!-- otherwise: 사용자용 '현금'/'카드'는 같은 tr 내 일부 td만 다르게 처리  -->
	  <c:choose>
		<c:when test="${m.mncrd == 'meNN' }">
			<tr id="sys">
				<td>${m.seqno }</td><td>${m.meth_code }</td>
				<td>기본</td><td>${m.meth_name }</td>
				<td><a href="${url }" onClick="popupUpdate(this); return false;">수정</a></td>
				<td><a href="${url }" onClick="popupDelete(this); return false;">삭제</a></td>
				<td>url : <c:out value="${url }"></c:out></td>
			</tr></c:when>
		<c:otherwise>
			<tr><td>${m.seqno }</td><td>${m.meth_code }</td>
				<c:if test="${m.mncrd == 'MN' }"><td id="mn">현금</td><td>${m.meth_name }</td></c:if>
				<c:if test="${m.mncrd == 'CRD' }"><td id="crd">카드</td><td>${m.meth_name }</td></c:if>
				<td><a href="${url }" onClick="popupUpdate(this); return false;">수정</a></td>
				<td><a href="${url }" onClick="popupDelete(this); return false;">삭제</a></td>
				<td>url : <c:out value="${url }"></c:out></td>
			</tr></c:otherwise>
	  </c:choose>
	</c:forEach>
	</table>
	<br>
	<div class="buttons">
	<a href="preAddMeth.do" onClick="popupAdd(this); return false;">추가하기</a>
	</div>
</div>
</body>

<script type="text/javascript">
function popupAdd(thisA){
	alert("popupAdd(thisA)호출됨");
	alert("url : "+thisA.href);
	window.open(thisA.href, '결제수단 추가하기', 'width=450, height=500');
}

function popupUpdate(thisA){
	alert("popupUpdate(thisA)호출됨");
	let url = thisA.href + 'UPD';
	alert("url : "+url);
	window.open(url, '결제수단 수정하기', 'width=450, height=500');
}

function popupDelete(thisA){
	alert("popupDelete(thisA)호출됨");
	let url = thisA.href + 'DEL';
	alert("url : "+url);
	window.open(url, '결제수단 삭제하기', 'width=450, height=500');
}

</script>
</html>