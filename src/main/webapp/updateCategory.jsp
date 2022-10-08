<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCategory.jsp</title>
</head>
<body>
<div>
	<p>카테고리 수정 화면입니다.</p>
	<form action="updateCategory.do" name="fmC" onSubmit="return check()">
		<input type="hidden" name="CCODE" value="${param.CCODE }">
		<table>
		<tr><td>
			<input type="hidden" name="INEX">
			<input type="button" value="수입" onClick="setIn()" id="btn_in">
			<input type="button" value="지출" onClick="setEx()" id="btn_ex">
			</td></tr>
		<tr><td>
			<input type="text" placeholder="카테고리명을 입력하세요" name="CNAME"></td></tr>
		<tr><td>
			<input type="submit" value="등록">
			<input type="reset" value="취소" onClick="goBack()">		
		</table>
	</form>
	</div>
</body>`
</html>