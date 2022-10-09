<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addMethod.jsp</title>
</head>
<body>
	<div>
	<p>결제수단 추가 화면입니다.</p>
	<form action="addMethod.do" name="fmC" onSubmit="return check()">
		<input type="hidden" name="SEQNO" value="${param.MSN +1 }">
		<table>
		<tr><td>
			<input type="hidden" name="MNCRD">
			<input type="button" value="현금" onClick="setMN()" id="btn_mn">
			<input type="button" value="카드" onClick="setCRD()" id="btn_crd">
			</td></tr>
		<tr><td>
			<input type="text" placeholder="결제수단명을 입력하세요" value="" name="MNAME"></td></tr>
		<tr><td>
			<input type="submit" value="등록">
			<input type="reset" value="취소" onClick="backToList()"></td>
		</table>
	</form>
	</div>
</body>
<script type="text/javascript">
let btn_mn = document.getElementById("btn_mn");
let btn_crd = document.getElementById("btn_crd");
function setMN(){
		//현금or카드 구분(MNCRD) : 수입(MN)
		document.fmC.MNCRD.value = "MN";
		alert("set MNCRD : "+document.fmC.MNCRD.value);
		//버튼 색 바꾸기
		btn_mn.style.backgroundColor = "blue";
		btn_crd.style.backgroundColor = null;
}
function setCRD(){
		//현금or카드 구분(MNCRD) : 수입(CRD)
		document.fmC.INEX.value = "EX";
		alert("set MNCRD : "+document.fmC.MNCRD.value);
		//버튼 색 바꾸기
		btn_mn.style.backgroundColor = "orange";
		btn_crd.style.backgroundColor = null;
}
function check(){
	let mncrd = document.fmC.MNCRD.value;
	let s_mncrd = ""; 
	if(mncrd == "MN") s_mncrd = "현금"; if(mncrd == "CRD") s_mncrd = "카드";
	let mname = document.fmC.MNAME.value;
	if(mncrd == ''){ alert("현금/카드 구분을 선택해주세요."); return false }
	if(mname == ''){ alert("결제수단명을 입력해주세요."); return false }
	if(! confirm("등록하시겠습니까?\n\n---\n구분 : "+s_mncrd+"\n결제수단명 : "+mname) ) return false;
	if(! confirm("등록될 seqno : "+document.fmC.SEQNO.value) ) return false;
}
function backToList(){
	if(confirm("취소하고 목록으로 돌아가시겠습니까?")){
		opener.location.reload();
		window.close();
	}else {
		//현금or카드 구분(MNCRD) 초기화
		document.fmC.MNCRD.value = null;
		alert("clear MNCRD : "+document.fmC.MNCRD.value);
		//현금or카드 버튼색 초기화
		btn_mn.style.backgroundColor = null;
		btn_crd.style.backgroundColor = null;
	}
}
</script>
</html>