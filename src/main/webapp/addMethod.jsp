<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addMethod.jsp</title>
<style type="text/css">
	.hidden { display:none; }
</style>
</head>
<body>
	<div>
	<p>결제수단 추가 화면입니다.</p>
	<form action="addMethod.do" name="fm" onSubmit="return check()">
		<input type="hidden" name="SEQNO" value="${param.MSN +1 }">
		<table>
		<tr><td>
			<input type="hidden" name="MNCRD">
			<input type="button" value="현금" onClick="setMN()" id="btn_mn">
			<input type="button" value="카드" onClick="setCRD()" id="btn_crd">
			</td></tr>
		<tr><td>
			<input type="text" placeholder="결제수단명을 입력하세요" value="" name="MNAME" id="mname"></td></tr>
		<tr><td>
			<input type="submit" value="등록">
			<input type="reset" value="취소" onClick="backToList()"></td>
		</table>
	</form>
	<div class="hidden">
		<input type="text" value="${LIST.size() }" id="slct_name_cnt">
		<select class="" id="slct_name">
			<c:forEach items="${LIST }" var="m">
				<option>${m.meth_name }</option>
			</c:forEach>
		</select>	
	</div>
	</div>
</body>
<script type="text/javascript">
let btn_mn = document.getElementById("btn_mn");
let btn_crd = document.getElementById("btn_crd");
let slct_name = document.getElementById("slct_name");
let slct_name_cnt = document.getElementById("slct_name_cnt");
function setMN(){
		//현금or카드 구분(MNCRD) : 수입(MN)
		document.fm.MNCRD.value = "MN";
// 		alert("set MNCRD : "+document.fm.MNCRD.value);
		//버튼 색 바꾸기
		btn_mn.style.backgroundColor = "blue";
		btn_crd.style.backgroundColor = null;
}
function setCRD(){
		//현금or카드 구분(MNCRD) : 수입(CRD)
		document.fm.MNCRD.value = "CRD";
// 		alert("set MNCRD : "+document.fm.MNCRD.value);
		//버튼 색 바꾸기
		btn_mn.style.backgroundColor = null;
		btn_crd.style.backgroundColor = "orange";
}
function nameDupCheck(mname){
// 	alert("nameDupCheck(mname) 호출됨.");
	let cnt = slct_name_cnt.value;
	for(i=0; i<cnt; i++){
		if(mname == slct_name.options[i].value) {
		alert("이미 사용중인 카테고리명입니다."); return false; }
	}
	return true;
}
function check(){
	let mncrd = document.fm.MNCRD.value;
	let s_mncrd = ""; 
	if(mncrd == "MN") s_mncrd = "현금"; if(mncrd == "CRD") s_mncrd = "카드";
	let mname = document.fm.MNAME.value;
	if(mncrd == ''){ alert("현금/카드 구분을 선택해주세요."); return false }
	if(mname == ''){ alert("결제수단명을 입력해주세요."); return false }
	//기존 결제수단명과 중복 확인
	if(! nameDupCheck(mname) ) return false;
	if(! confirm("등록하시겠습니까?\n\n---\n구분 : "+s_mncrd+"\n결제수단명 : "+mname) ) return false;
// 	if(! confirm("등록될 seqno : "+document.fm.SEQNO.value) ) return false;
}
function backToList(){
	if(confirm("취소하고 목록으로 돌아가시겠습니까?")){
		opener.location.reload();
		window.close();
	}else {
		//현금or카드 구분(MNCRD) 초기화
		document.fm.MNCRD.value = null;
// 		alert("clear MNCRD : "+document.fm.MNCRD.value);
		//현금or카드 버튼색 초기화
		btn_mn.style.backgroundColor = null;
		btn_crd.style.backgroundColor = null;
	}
}
</script>
</html>