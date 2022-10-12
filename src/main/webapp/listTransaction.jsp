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
		.oneTrans { border: 1px gray solid; margin: 5px 10px; }
		.upper, .lower { display:flex; justify-content: space-between; text-align:center; }	
		.inner { margin:0 auto; }
		.in { color:blue; } .ex { color:red; }
		.cate, .meth { color: skyblue; }
		
		
		
	</style>
</head>
<body>
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
<div class="contMain">
	<p>가계부 목록 화면입니다.</p>
	총 ${SIZE } 건<br>
	
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
		<div class="inner cate">카테고리: ${trans.cate_code }</div>
		<div class="inner meth">결제수단: ${trans.meth_code }</div>
	</div>
	</div>
	</c:forEach>
</div>
</body>
</html>