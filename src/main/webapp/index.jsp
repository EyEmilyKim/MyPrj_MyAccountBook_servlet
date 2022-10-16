<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link rel="stylesheet" href="index.css">
<style type="text/css">
	.hidden { display:none; }
	.myPainting { width:40%; } .myPainting2 { width:30%; }
</style>
<script src="https://kit.fontawesome.com/f747bc5595.js" crossorigin="anonymous"> </script>    
</head>
<body>
<div class="container">
<header>
	<div class="home">
		<i class="fa-solid fa-sack-dollar"></i>
		<a href="index.jsp">My 가계부</a>
	</div>
	<ul class="menu">
		<li id="add"><a href="makeAddTrans.do">가계부 쓰기</a></li>
		<li id="list"><a href="listTransaction.do?INEX=ALL">전체내역</a></li>
		<li id="ex"><a href="listTransaction.do?INEX=EX">지출</a></li>
		<li id="in"><a href="listTransaction.do?INEX=IN">수입</a></li>
		<li id="set"><a href="#">설정</a>
			<ul class="depth_1">
                <li><a href="listCategory.do">카테고리 관리</a></li>
                <li><a href="listMethod.do">결제수단 관리</a></li>
                <li class="hidden"><a href="#">고정금액 관리(tbu)</a></li>
            </ul>
		</li>
	<c:if test="${sessionScope.USER_ID != null }">
		<li id="logout"><a href="logout.do">로그아웃</a></li>
	</c:if>	
	</ul>
</header>
<section>
<c:if test="${ empty param.BODY }">
<div class="default">
	<p>땡그랑 한푼, 땡그랑 두푼♪</p>
	<c:if test="${ empty sessionScope.USER_ID }">
	<p>로그인해주세요~</p>
	<a href="index.jsp?BODY=login.jsp" class="login">로그인</a>
	<a href="index.jsp?BODY=signUp.jsp" class="signUp">가입하기</a><br/>
	<img class="myPainting2" alt="" src="image2.png">
	</c:if>
	<c:if test="${! empty sessionScope.USER_ID }">
	<p>반갑습니다 ${USER_ID }님~~</p>
	<img class="myPainting" alt="" src="image.png">
	</c:if>
</div>	
</c:if>
<c:if test="${ ! empty param.BODY  }">
	<div id="BODY">
		<jsp:include page="${param.BODY }"/>
	</div>
</c:if>
</section>
<footer>
	<p>2022 All right reserved. developed by EyKim.</p>
</footer>
</div>
</body>
</html>