<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listMethod.jsp</title>
	<style type="text/css">
		.contMain { min-width:500px; min-height:300px; background-color: white; align:center; padding:20px; border-radius: 15px;} 
		 h3{ margin: 10px 0 20px; color:var(--hoverMenu-color); }
		#mn { color:blue; } #crd { color:red; } #sys { background-color:beige; }
		.seqno, .cate_code { display:none; }
		.hidden { display:none; }
		table {min-width:300px;} tr {height : 25px; }
		.btn {
			display: block;
		    border: 1px solid var(--topbott-color);
		    font-size: 0.8rem;
 		    font-weight: 400; 
		    padding: 0.1rem 0;
		    border-radius: 5px;
		    text-decoration: none;
		    text-align: center;
		    background-color: var(--background-color);
		    color: var(--selectedMenu-color);
		}
		.add { height:1.5rem; margin:10px; font-size: 1rem;
 		    font-weight: 400; text-align: center;}
	</style>
</head>
<body>
<!-- <div class="home"> -->
<!-- 	<a href="index.jsp">My 가계부</a> -->
<!-- </div> -->
<div class="contMain" align="center">
	<h3>결제수단 목록</h3>
	총 ${SIZE } 건<br><br>
	<table>
		<tr class="hidden"><td class="seqno">seqno</td><td class="meth_code">meth_code</td><td>mncrd</td><td>meth_name</td></tr>
	<c:forEach items="${LIST }" var="m">
		<c:set var="url" value="detailMethod.do?MCODE=${m.meth_code }&MOD="/>	
	  <!-- choose when: system용 '미지정'은 별도 tr로.   -->
	  <!-- otherwise: 사용자용 '현금'/'카드'는 같은 tr 내 일부 td만 다르게 처리  -->
	  <c:choose>
		<c:when test="${m.mncrd == 'meNN' }">
			<tr id="sys">
				<td class="hidden seqno">${m.seqno }</td><td class="hidden meth_code">${m.meth_code }</td>
				<td>기본</td><td>${m.meth_name }</td>
				<td class="hidden"><a href="${url }" onClick="popupUpdate(this); return false;">수정</a></td>
				<td class="hidden"><a href="${url }" onClick="popupDelete(this); return false;">삭제</a></td>
				<td class="hidden">url : <c:out value="${url }"></c:out></td>
			</tr></c:when>
		<c:otherwise>
			<tr><td class="hidden seqno">${m.seqno }</td><td class="hidden meth_code">${m.meth_code }</td>
				<c:if test="${m.mncrd == 'MN' }"><td id="mn">현금</td><td>${m.meth_name }</td></c:if>
				<c:if test="${m.mncrd == 'CRD' }"><td id="crd">카드</td><td>${m.meth_name }</td></c:if>
				<td><a class="btn" href="${url }" onClick="popupUpdate(this); return false;">수정</a></td>
				<td><a class="btn" href="${url }" onClick="popupDelete(this); return false;">삭제</a></td>
				<td class="hidden">url : <c:out value="${url }"></c:out></td>
			</tr></c:otherwise>
	  </c:choose>
	</c:forEach>
	</table>
	<br>
	<div class="buttons">
	<a class="btn" href="preAddMeth.do" onClick="popupAdd(this); return false;">추가하기</a>
	</div>
</div>
</body>

<script type="text/javascript">
function popupAdd(thisA){
// 	alert("popupAdd(thisA)호출됨");
// 	alert("url : "+thisA.href);
	window.open(thisA.href, '결제수단 추가하기', 'width=450, height=500');
}

function popupUpdate(thisA){
// 	alert("popupUpdate(thisA)호출됨");
	let url = thisA.href + 'UPD';
// 	alert("url : "+url);
	window.open(url, '결제수단 수정하기', 'width=450, height=500');
}

function popupDelete(thisA){
// 	alert("popupDelete(thisA)호출됨");
	let url = thisA.href + 'DEL';
// 	alert("url : "+url);
	window.open(url, '결제수단 삭제하기', 'width=450, height=500');
}

</script>
</html>