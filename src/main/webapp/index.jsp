<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link rel="stylesheet" href="MyAccBook.css">
</head>
<body>
<div class="container">
<header>
	<div class="home">
		<a href="index.jsp">My 가계부</a>
	</div>
	<ul class="menu">
		<li><a href="">가계부 쓰기</a></li>
		<li><a href="">전체내역</a></li>
		<li><a href="">지출</a></li>
		<li><a href="">수입</a></li>
		<li><a href="#">설정</a>
			<ul class="depth_1">
                <li><a href="listCategory.do">카테고리 관리</a></li>
                <li><a href="#">지출수단 관리(tbu)</a></li>
                <li><a href="#">즐겨찾기 관리(tbu)</a></li>
            </ul>
		</li>
	<c:if test="${sessionScope.USER_ID != null }">
		<li><a href="logout.do">로그아웃</a></li>
	</c:if>	
	</ul>
</header>
<section>
	<c:if test="${ empty sessionScope.USER_ID }">
	<p>로그인해주세요~</p>
	</c:if>
	<c:if test="${! empty sessionScope.USER_ID }">
	<p>반갑습니다 ${USER_ID }님~~</p>
	</c:if>
	<p>땡그랑 한푼, 땡그랑 두푼♪</p>
	<a href="login.jsp">로그인</a>
	<div>
<%-- 	<%@ include file="login.jsp" %>	 --%>
	</div>
</section>
<footer>
	<p>2022 All right reserved. developed by EyKim.</p>
</footer>
</div>
</body>
</html>