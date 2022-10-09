<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteCategory.jsp</title>
</head>
<body>
<div>
	<p>카테고리 삭제 화면입니다.</p>
	<form action="deleteCategory.do" name="fm" onSubmit="return check()">
		<input type="hidden" name="CCODE" value="${C.cate_code }">
		<input type="hidden" name="CNAME" value="${C.cate_name }">
		<table>
		<tr><td>
			<c:if test="${C.inex == 'IN' }">
			<input type="button" value="수입" name="S_INEX" id="btn_in"></c:if>
			<c:if test="${C.inex == 'EX' }">
			<input type="button" value="지출" name="S_INEX" id="btn_ex"></c:if>
			</td>
			<td>${C.cate_name }</td></tr>
		<tr><td>
			<input type="submit" value="삭제">
			<input type="reset" value="취소" onClick="backToList()"></td></tr>		
		</table>
	</form>
	</div>
</body>
<script type="text/javascript">
function check(){
	alert("check()호출됨");
	let s_inex = ""; switch(document.fm.S_INEX.value){
	case "수입" : s_inex = "수입"; break; 
	case "지출" : s_inex = "지출"; break; }
	let cname = document.fm.CNAME.value;
	let guideConf = "기존에 이 카테고리를 사용해 입력한 가계부 기록의 카테고리 정보가 사라집니다.";
	let detailConf = "구분 : "+s_inex+"\n카테고리명 : "+cname;
	alert("let OK");
	if(! confirm( guideConf+"\n\n삭제하시겠습니까?\n\n---\n"+detailConf ) ) return false;
	if(! confirm("삭제될 cate_code : "+document.fm.CCODE.value) ) return false;
}

function backToList(){
	if(confirm("취소하고 목록으로 돌아가시겠습니까?")){
		opener.location.reload();
		window.close();
	}
}
</script>
</html>