<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCategory.jsp</title>
<style type="text/css">
	.hidden { display:none; }
</style>
</head>
<body>
	<div>
	<p>카테고리 추가 화면입니다.</p>
	<form action="addCategory.do" name="fm" onSubmit="return check()">
		<input type="hidden" name="SEQNO" value="${param.MSN +1 }">
		<table>
		<tr><td>
			<input type="hidden" name="INEX">
			<input type="button" value="수입" onClick="setIN()" id="btn_in">
			<input type="button" value="지출" onClick="setEX()" id="btn_ex">
			</td></tr>
		<tr><td>
			<input type="text" placeholder="카테고리명을 입력하세요" value="" name="CNAME" id="cname"></td></tr>
		<tr><td>
			<input type="submit" value="등록">
			<input type="reset" value="취소" onClick="backToList()"></td>
		</table>
	</form>
	<div class="hidden">
		<input type="text" value="${LIST.size() }" id="slct_name_cnt">
		<select class="" id="slct_name">
			<c:forEach items="${LIST }" var="c">
				<option>${c.cate_name }</option>
			</c:forEach>
		</select>
	</div>
	</div>
</body>
<script type="text/javascript">
let btn_in = document.getElementById("btn_in");
let btn_ex = document.getElementById("btn_ex");
let slct_name = document.getElementById("slct_name");
let slct_name_cnt = document.getElementById("slct_name_cnt");
function setIN(){
		//수입or지출 구분(INEX) : 수입(IN)
		document.fm.INEX.value = "IN";
// 		alert("set INEX : "+document.fm.INEX.value);
		//버튼 색 바꾸기
		btn_in.style.backgroundColor = "blue";
		btn_ex.style.backgroundColor = null;
}
function setEX(){
		//수입or지출 구분(INEX) : 지출(EX)
		document.fm.INEX.value = "EX";
// 		alert("set INEX : "+document.fm.INEX.value);
		//버튼 색 바꾸기
		btn_ex.style.backgroundColor = "red";
		btn_in.style.backgroundColor = null;
}
function nameDupCheck(cname){
// 	alert("nameDupCheck(cname) 호출됨.");
	let cnt = slct_name_cnt.value;
	for(i=0; i<cnt; i++){
		if(cname == slct_name.options[i].value) {
		alert("이미 사용중인 카테고리명입니다."); return false; }
	}
// 	alert("nameDupCheck(cname) 끝.");
	return true;
}
function check(){
// 	alert("check() 호출됨");
	let inex = document.fm.INEX.value;
	let s_inex = ""; if(inex == "EX") s_inex = "지출"; else s_inex = "수입";
	let cname = document.fm.CNAME.value;
	if(inex == ''){ alert("지출/소비 구분을 선택해주세요."); return false }
	if(cname == ''){ alert("카테고리명을 입력해주세요."); return false }
// 	alert("check() 여기1");
	//기존 카테고리명과 중복 확인
	if(! nameDupCheck(cname) ) return false;
// 	alert("check() 여기2");
	if(! confirm("등록하시겠습니까?\n\n---\n구분 : "+s_inex+"\n카테고리명 : "+cname) ) return false;
// 	if(! confirm("등록될 seqno : "+document.fm.SEQNO.value) ) return false;
}
function backToList(){
	if(confirm("취소하고 목록으로 돌아가시겠습니까?")){
		opener.location.reload();
		window.close();
	}else {
		//수입or지출 구분(INEX) 초기화
		document.fm.INEX.value = null;
// 		alert("clear INEX : "+document.fm.INEX.value);
		//수입or지출 버튼색 초기화
		btn_ex.style.backgroundColor = null;
		btn_in.style.backgroundColor = null;
	}
}
</script>
</html>