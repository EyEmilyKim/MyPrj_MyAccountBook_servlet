<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCategory.jsp</title>
</head>
<body>
	<div>
	<p>카테고리 추가 화면입니다.</p>
	<form action="addCategory.do" name="fmC" onSubmit="return check()">
		<input type="hidden" name="SEQNO" value="${param.MSN +1 }">
		<table>
		<tr><td>
			<input type="hidden" name="INEX">
			<input type="button" value="수입" onClick="setIN()" id="btn_in">
			<input type="button" value="지출" onClick="setEX()" id="btn_ex">
			</td></tr>
		<tr><td>
			<input type="text" placeholder="카테고리명을 입력하세요" value="" name="CNAME"></td></tr>
		<tr><td>
			<input type="submit" value="등록">
			<input type="reset" value="취소" onClick="backToList()"></td>
		</table>
	</form>
	</div>
</body>
<script type="text/javascript">
let btn_in = document.getElementById("btn_in");
let btn_ex = document.getElementById("btn_ex");
function setEX(){
		//수입or지출 구분(INEX) : 지출(EX)
		document.fmC.INEX.value = "EX";
		alert("set INEX : "+document.fmC.INEX.value);
		//[TBC] 버튼 색 바꾸기
		btn_ex.style.backgroundColor = "red";
		btn_in.style.backgroundColor = null;
}
function setIN(){
		//수입or지출 구분(INEX) : 수입(IN)
		document.fmC.INEX.value = "IN";
		alert("set INEX : "+document.fmC.INEX.value);
		//[TBC] 버튼 색 바꾸기
		btn_in.style.backgroundColor = "blue";
		btn_ex.style.backgroundColor = null;
}
function check(){
	let inex = document.fmC.INEX.value;
	let s_inex = ""; if(inex == "EX") s_inex = "지출"; else s_inex = "수입";
	let cname = document.fmC.CNAME.value;
	if(inex == ''){ alert("지출/소비 구분을 선택해주세요."); return false }
	if(cname == ''){ alert("카테고리명을 입력해주세요."); return false }
	if(! confirm("등록하시겠습니까?\n\n---\n구분 : "+s_inex+"\n카테고리명 : "+cname) ) return false;
	if(! confirm("등록될 seqno : "+document.fmC.SEQNO.value) ) return false;
}
function backToList(){
	if(confirm("취소하고 목록으로 돌아가시겠습니까?")){
		opener.location.reload();
		window.close();
	}else {
		//수입or지출 구분(INEX) 초기화
		document.fmC.INEX.value = null;
		alert("clear INEX : "+document.fmC.INEX.value);
		//수입or지출 버튼색 초기화
		btn_ex.style.backgroundColor = null;
		btn_in.style.backgroundColor = null;
	}
}
</script>
</html>