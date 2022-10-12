<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailTransaction.jsp</title>
	<style type="text/css">
		.contMain { border: 1px skyblue solid; max-width: 400px;}
		.oneTrans { border: 1px gray solid; margin: 5px 10px; }
		.btns { display:flex;  justify-content: space-evenly;  } 
		.btn { width: 100px; }
	</style>
</head>
<body>
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
<div class="contMain">
	<p>가계부 상세 화면입니다.</p>
<!-- 거래내역 상세 정보 -->
	<div class="oneTrans">	
		<div class="upper">
			<div class="inner date">${TRANS.trans_date }</div>
			<c:if test="${TRANS.inex == 'IN' }">
			<div class="inner in">${TRANS.inex }</div>
			</c:if>
			<c:if test="${TRANS.inex == 'EX' }">
			<div class="inner ex">${TRANS.inex }</div>
			</c:if>
			<div class="inner item">${TRANS.item }</div>
			<div class="inner amnt"><fmt:formatNumber groupingUsed="true">
			${TRANS.amount }</fmt:formatNumber>원</div>
		</div>
		<div class="lower">
			<div class="inner cate">카테고리: ${TRANS.cate_code }</div>
			<div class="inner meth">결제수단: ${TRANS.meth_code }</div>
		</div>
	</div>	<!-- oneTrans 끝 -->
	<div class="btns">
		<input type="button" value="목록으로" class="btn" onClick="backToList()">
		<input type="button" value="수정" class="btn" onClick="updateTrans(${TRANS.seqno})">
		<input type="button" value="삭제" class="btn" onClick="deleteTrans(${TRANS.seqno})">
	</div>	
</div>	<!-- contMain 끝 -->
</body>
<script type="text/javascript">
function backToList(){
	alert("backToList() 호출됨");
	location.href = "listTransaction.do";
}
function updateTrans(seqno){
	alert("updateTrans(seqno) 호출됨");
	location.href = "modifyTransaction.do?SN="+seqno;
}
function deleteTrans(seqno){
	alert("deleteTrans(seqno) 호출됨");
	if( confirm("삭제 하시겠습니까?") ){
		alert("url: deleteTransaction.do?SN=[seqno] ");		
		location.href = "deleteTransaction.do?SN="+seqno;
	}
}

</script>
</html>