<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addTransaction.jsp</title>
</head>
<body>
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
	<div>
	<p>가계부 쓰기 화면입니다.</p>
	<form action="#addCategory.do" name="fm" onSubmit="return check()">
		<input type="hidden" name="SEQNO" value="${param.MSN +1 }">
		<table>
		<tr><td>
			<input type="hidden" name="INEX">
			<input type="button" value="수입" onClick="setIN()" id="btn_in">
			<input type="button" value="지출" onClick="setEX()" id="btn_ex">
			</td></tr>
		<tr><td><input type="date" name="DATE"></td></tr>
		<tr><td>
			<select name="CNAME">
				<option value="">--카테고리를 선택하세요--</option>
				<option value="">a</option>
				<option value="">a</option>
				<option value="">미지정</option>
			</select></td></tr>
		<tr><td>
			<textarea cols="40" rows="5" placeholder="내용을 입력하세요" name="ITEM"></textarea></td></tr>
		<tr><td>
			<input type="text" placeholder="금액을 입력하세요" value="" name="AMOUNT"></td></tr>
		<tr><td>
			<input type="hidden" name="METHOD" value="">
			<input type="button" value="현금" onClick="setMN()" id="btn_mn">
			<input type="button" value="카드" onClick="openCRD()" id="btn_crd">
			
			<c:if test="">
			
			</c:if>
			</td></tr>	
		<tr><td><br>
			<input type="submit" value="등록">
			<input type="reset" value="취소" onClick="backToList()"></td>
		</table>
	</form>
	</div>
</body>
<script type="text/javascript">
let btn_in = document.getElementById("btn_in");
let btn_ex = document.getElementById("btn_ex");
let btn_mn = document.getElementById("btn_mn");
let btn_crd = document.getElementById("btn_crd");

function setMN(){
	alert("setMN() 호출됨");
	//결제수단(METHOD) : 현금(MN)
	document.fm.METHOD.value = "MN";
	alert("set METHOD : "+document.fm.METHOD.value);
	//버튼 색 바꾸기
	btn_mn.style.backgroundColor = "orange";
	btn_crd.style.backgroundColor = null;
}
function openCRD(){
	alert("openCRD() 호출됨");
// 	//결제수단(METHOD) : 현금(CRD)
// 	document.fm.METHOD.value = "MN";
// 	alert("set METHOD : "+document.fm.METHOD.value);
	//버튼 색 바꾸기
	btn_mn.style.backgroundColor = null;
	btn_crd.style.backgroundColor = "orange";
	//카드 소분류 보여주기
	alert("카드 소분류 보여주기!!!!!!!!!! [TBC]");
}

function setIN(){
	//수입or지출 구분(INEX) : 수입(IN)
	document.fm.INEX.value = "IN";
	alert("set INEX : "+document.fm.INEX.value);
	//버튼 색 바꾸기
	btn_in.style.backgroundColor = "blue";
	btn_ex.style.backgroundColor = null;
}
function setEX(){
	//수입or지출 구분(INEX) : 지출(EX)
	document.fm.INEX.value = "EX";
	alert("set INEX : "+document.fm.INEX.value);
	//버튼 색 바꾸기
	btn_ex.style.backgroundColor = "red";
	btn_in.style.backgroundColor = null;
}

function check(){
	alert("check() 호출됨. 미구현!!!!!!!!!! [TBC]");
}

function backToList(){
	if(confirm("취소하고 홈화면으로 돌아가시겠습니까?")){
		location.href="index.jsp";
	}else {
		//수입or지출 구분(INEX) 초기화
		document.fm.INEX.value = null;
		alert("clear INEX : "+document.fm.INEX.value);
		//수입or지출 버튼색 초기화
		btn_ex.style.backgroundColor = null;
		btn_in.style.backgroundColor = null;
		//현금or카드 구분(METHOD) 초기화
		document.fm.METHOD.value = null;
		alert("clear METHOD : "+document.fm.METHOD.value);
		//현금or카드 버튼색 초기화
		btn_mn.style.backgroundColor = null;
		btn_crd.style.backgroundColor = null;
	}
}
</script>
</html>