<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMethod.jsp</title>
</head>
<body>
<div>
	<p>결제수단 수정 화면입니다.</p>
	<form action="updateMethod.do" name="fm" onSubmit="return check()">
		<input type="hidden" name="MCODE" value="${M.meth_code }">
		<input type="hidden" name="MNAME" value="${M.meth_name }">
		<table>
		<tr><td>
			<input type="hidden" value="${M.mncrd }" name="MNCRD">
			<c:if test="${M.mncrd == 'MN' }">
			<input type="button" value="현금" onClick="guideMncrd()" id="btn_mn"></c:if>
			<c:if test="${M.mncrd == 'CRD' }">
			<input type="button" value="카드" onClick="guideMncrd()" id="btn_crd"></c:if>
			</td></tr>
		<tr><td>현재 결제수단명 : ${M.meth_name }</td></tr>
		<tr><td><input type="text" placeholder="변경할 결제수단명" name="N_MNAME"></td></tr>
		<tr><td><span id="guide"></span></td></tr>
		<tr><td>
			<input type="submit" value="저장">
			<input type="reset" value="취소" onClick="backToList()"></td></tr>		
		</table>
	</form>
	</div>
</body>
<script type="text/javascript">
function guideMncrd(){
// 	alert("guideMncrd()호출됨");
	let guideMncrd = "현금/카드 구분은 수정할 수 없습니다. 목록에서 삭제 후 다시 등록해주세요.";
	document.getElementById("guide").innerHTML = guideMncrd;
}
function check(){
// 	alert("check()호출됨");
	document.getElementById("guide").innerHTML = "";
	let mncrd = document.fm.MNCRD.value;
	let s_mncrd = ""; if(mncrd == "CRD") s_mncrd = "카드"; else s_mncrd = "현금";
	let mname = document.fm.MNAME.value;
	let n_mname = document.fm.N_MNAME.value;
	let guideConf = "기존에 이 결제수단을 사용해 입력한 가계부 기록에도 변경된 결제수단명이 반영됩니다.";
	let detailConf = "구분 : "+s_mncrd+"\n수정 전 : "+mname+"\n수정 후 : "+n_mname;
// 	alert("let OK");
	if(n_mname == ''){ alert("결제수단명을 입력해주세요."); return false }
	if(! confirm( guideConf+"\n\n저장하시겠습니까?\n\n---\n"+detailConf ) ) return false;
// 	if(! confirm("수정될 meth_code : "+document.fm.MCODE.value) ) return false;
}
function backToList(){
	if(confirm("취소하고 목록으로 돌아가시겠습니까?")){
		opener.location.reload();
		window.close();
	}else{
		document.getElementById("guide").innerHTML = "";
	}
}
</script>
</html>