<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listTransaction.jsp</title>
	<style type="text/css">
		.contMain { border: 1px skyblue solid; max-width: 400px;}
		.list, .page { text-align: center; border: 1px red solid; margin: 5px 10px; }
		.oneTrans { border: 1px gray solid; margin: 5px 10px; }
		.upper, .lower { display:flex; justify-content: space-between; text-align:center; }	
		.inner { margin:0 auto; }
		.in { color:blue; } .ex { color:red; }
		.cate, .meth { color: skyblue; }
		.hidden { display:; }
	/* structure */
		.set_view { display: flex; justify-content: space-between; margin:10px; }
		
	</style>
</head>
<body onLoad="preset()">
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
<div class="contMain">
	<p>가계부 목록 화면입니다.</p>
<!-- 목록 화면 세팅	-->
	<form class="hidden" name="preset">
		<input type="text" name="PRE_SLC" value="${param.SLC }">
	</form>
	<div class="set_view">
		<div id="cnt"> # ${STARTRN } ~ ${ENDRN } / 총 ${TOTAL } 건<br></div>
		<div id="slc"><form action="listTransaction.do" name="fmSLC">
			<select name="SLC" id="slct_slc" onChange="showListCount(this.value)">
				<option value="5">5줄 보기</option>
				<option value="10">10줄 보기</option>
				<option value="15">15줄 보기</option>
			</select></form></div>
	</div> 
<!-- 실제 목록 -->
	<div class="list">
	<c:forEach items="${LIST }" var="trans">
	<div class="oneTrans">
		<div class="upper">
			<div class="inner date">${trans.trans_date }</div>
			<c:if test="${trans.inex == 'IN' }">
			<div class="inner in">${trans.inex }</div>
			</c:if>
			<c:if test="${trans.inex == 'EX' }">
			<div class="inner ex">${trans.inex }</div>
			</c:if>
			<div class="inner item">
			<a href="detailTransaction.do?SN=${trans.seqno }">${trans.item }</a></div>
			<div class="inner amnt"><fmt:formatNumber groupingUsed="true">
			${trans.amount }</fmt:formatNumber>원</div>
		</div>
		<div class="lower">
			<div class="hidden inner seqno">${trans.seqno }</div>
			<div class="inner cate">카테고리: ${trans.cate_code }</div>
			<div class="inner meth">결제수단: ${trans.meth_code }</div>
		</div>
	</div> <!-- oneTrans 끝 -->
	</c:forEach>
	</div> <!-- list 끝 -->
	<div class="page">
		<c:forEach begin="1" end="${PAGES }" var="page">
		<a href="noticeList.do?PAGE="${page }>${page }</a>	
		</c:forEach>
	</div>
</div> <!-- contMain 끝 -->
</body>

<script type="text/javascript">

/* 화면 로드시 데이터에 따라 미리 html 요소 반영 */
function preset(){ 
// 	alert("로드되었습니다");
	const pre_slc = document.preset.PRE_SLC.value;
	document.getElementById("slct_slc").value = pre_slc;
}
function showListCount(thisV){ //선택지 바뀌면 해당 수 만큼 거래목록 조회
// 	alert("showListCount(thisV) 호출됨" +"\nthisV : "+thisV);
	document.fmSLC.submit();
}
</script>
</html>