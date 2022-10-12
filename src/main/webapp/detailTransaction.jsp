<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailTransaction.jsp</title>
</head>
<body>
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
<div>
	<p>가계부 목록 화면입니다.</p>

	<table border="1" class="table">
	
	<tr><td><div class="oneTrans">
	<div class="upper">
		<div class="inner date">${TRANS.trans_date }</div>
		<c:if test="${TRANS.inex == 'IN' }">
		<div class="inner in">${TRANS.inex }</div>
		</c:if>
		<c:if test="${TRANS.inex == 'EX' }">
		<div class="inner ex">${TRANS.inex }</div>
		</c:if>
		<div class="inner item">
		<a href="modifyTransaction.do?SN=${TRANS.seqno }">${TRANS.item }</a></div>
		<div class="inner amnt"><fmt:formatNumber groupingUsed="true">
		${TRANS.amount }</fmt:formatNumber>원</div>
	</div>
	<div class="lower">
		<div class="inner cate">카테고리: ${TRANS.cate_code }</div>
		<div class="inner meth">결제수단: ${TRANS.meth_code }</div>
	</div>
	
	
	</div></td></tr>
	</table>

</div>	
</body>
</html>