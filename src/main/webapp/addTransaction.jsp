<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addTransaction.jsp</title>
	<style type="text/css">
	#slct_in, #slct_ex, #set_meth, #slct_mn, #slct_crd { display:none; } 
	.hidden { display:none; }
	</style>
</head>
<body>
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
	<div>
	<p>가계부 쓰기 화면입니다.</p>
	
	<form action="#addCategory.do" name="fm" onSubmit="return check()">
<!-- 0.일련번호(hidden)-->
		<input type="hidden" name="SEQNO" value="${param.MSN +1 }">
		<table>
<!-- 1.수입or지출 구분 -->
		<tr><td><input type="hidden" name="INEX">
			<input type="button" value="수입" onClick="setIN()" id="btn_in">
			<input type="button" value="지출" onClick="setEX()" id="btn_ex">
			</td></tr>
<!-- 2.거래날짜 -->
		<tr><td><input type="date" name="DATE"></td></tr>
<!-- 3.카테고리 -->
	<!-- 드롭다운 : 초기화면 -->
		<tr><td><select name="CCODE" id="slct_nn">
					<option value="">--카테고리(미지정)--</option>
					<option value="">수입/지출을 선택하세요</option>
				</select>
	<!-- 드롭다운 : 수입 -->
				<select name="CCODE" id="slct_in">
					<option value="">--카테고리(수입)--</option>
				<c:forEach items="${CATELIST }" var="c">
				<c:set var="cate_code" value="${c.cate_code }"/>
				<c:set var="cate_name" value="${c.cate_name }"/>
				<c:if test="${ fn:startsWith(cate_code,'IN') }">
					<option value="${c.cate_code }">${c.cate_name }</option>
				</c:if>		
				</c:forEach></select>
	<!-- 드롭다운 : 지출 -->
				<select name="CCODE" id="slct_ex">
					<option value="">--카테고리(지출)--</option>
				<c:forEach items="${CATELIST }" var="c">
				<c:set var="cate_code" value="${c.cate_code }"/>
				<c:set var="cate_name" value="${c.cate_name }"/>
				<c:if test="${ fn:startsWith(cate_code,'EX') }">
					<option value="${c.cate_code }">${c.cate_name }</option>
				</c:if>		
				</c:forEach></select>
			</td></tr>	
<!-- 4.거래내용 -->
		<tr><td>
			<textarea name="ITEM" cols="40" rows="5" placeholder="내용을 입력하세요"></textarea></td></tr>
<!-- 5.거래금액 -->
		<tr><td>
			<input type="text" placeholder="금액을 입력하세요" value="" name="AMOUNT"></td></tr>
<!-- 6.결제수단 -->	
	<!-- 현금or카드 버튼 -->
		<tr id="set_meth">
			<td><input type="hidden" name="SupMETHOD" value="">
				<input type="button" value="현금" onClick="openMN()" id="btn_mn">
				<input type="button" value="카드" onClick="openCRD()" id="btn_crd"></td>
	<!-- 드롭다운 : 현금 -->
			<td><select name="METHOD" id="slct_mn">
					<option value="">--결제수단(현금)--</option>
				<c:forEach items="${METHLIST }" var="m">
				<c:set var="meth_code" value="${m.meth_code }"/>
				<c:set var="meth_name" value="${m.meth_name }"/>
				<c:if test="${ fn:startsWith(meth_code,'MN') }">
					<option value="${m.meth_code }">${m.meth_name }</option>
				</c:if>		
				</c:forEach></select>
	<!-- 드롭다운 : 카드 -->
				<select name="METHOD" id="slct_crd">
					<option value="">--결제수단(카드)--</option>
				<c:forEach items="${METHLIST }" var="m">
				<c:set var="meth_code" value="${m.meth_code }"/>
				<c:set var="meth_name" value="${m.meth_name }"/>
				<c:if test="${ fn:startsWith(meth_code,'CRD') }">
					<option value="${m.meth_code }">${m.meth_name }</option>
				</c:if>		
				</c:forEach></select>
			</td></tr>	
	<!-- (확인용 hidden) 전체 결제수단	-->
		<tr class="hidden">
			<td><c:forEach items="${METHLIST }" var="m">
				<c:set var="meth_code" value="${m.meth_code }"/>
				<c:set var="meth_name" value="${m.meth_name }"/>
				<c:out value="${meth_code }"/> / <c:out value="${meth_name }"/><br>
				</c:forEach>
			</td></tr>
<!-- form 등록/취소 -->			
		<tr><td><br>
			<input type="submit" value="등록">
			<input type="reset" value="취소" onClick="backToList()"></td></tr>
		</table>
	</form>
	</div>
</body>
<script type="text/javascript">
/* 변수 : html 요소 식별 */
let btn_in = document.getElementById("btn_in");
let btn_ex = document.getElementById("btn_ex");
let slct_nn = document.getElementById("slct_nn");
let slct_in = document.getElementById("slct_in");
let slct_ex = document.getElementById("slct_ex");
let set_meth = document.getElementById("set_meth");
let btn_mn = document.getElementById("btn_mn");
let btn_crd = document.getElementById("btn_crd");
let slct_mn = document.getElementById("slct_mn");
let slct_crd = document.getElementById("slct_crd");
/* 수입 or 지출 선택 */
function setIN(){ //[수입]
	//수입or지출 구분(INEX) : 수입(IN)
	document.fm.INEX.value = "IN";
	alert("set INEX : "+document.fm.INEX.value);
	//버튼 색 바꾸기
	btn_in.style.backgroundColor = "blue";
	btn_ex.style.backgroundColor = null;
	//결제수단 row 가리기 (기본:가려짐)
	set_meth.style.display = null;
	//카테고리(수입)만 남기고 가리기
	slct_nn.style.display = "none";
	slct_in.style.display = "block";
	slct_ex.style.display = "none";
}
function setEX(){ //[지출]
	//수입or지출 구분(INEX) : 지출(EX)
	document.fm.INEX.value = "EX";
	alert("set INEX : "+document.fm.INEX.value);
	//버튼 색 바꾸기
	btn_ex.style.backgroundColor = "red";
	btn_in.style.backgroundColor = null;
	//결제수단 row 보여주기 (기본:가려짐)
	set_meth.style.display = "block";
	//카테고리(지출)만 남기고 가리기
	slct_nn.style.display = "none";
	slct_in.style.display = "none";
	slct_ex.style.display = "block";
}
/* 현금 or 카드 선택 */
function openMN(){ //[현금]버튼 클릭시
	alert("openMN() 호출됨");
	//현금or카드 대분류(SupMETHOD) : 현금(MN)
	document.fm.SupMETHOD.value = "MN";
	alert("set SupMETHOD : "+document.fm.SupMETHOD.value);
	//버튼 색 바꾸기
	btn_mn.style.backgroundColor = "orange";
	btn_crd.style.backgroundColor = null;
	//결제수단 현금 드롭다운 보여주기
	slct_mn.style.display = "block";
	slct_crd.style.display = null;
}
function openCRD(){ //[카드]버튼 클릭시
	alert("openCRD() 호출됨");
	//현금or카드 대분류(SupMETHOD) : 현금(CRD)
	document.fm.SupMETHOD.value = "CRD";
	alert("set SupMETHOD : "+document.fm.SupMETHOD.value);
	//버튼 색 바꾸기
	btn_mn.style.backgroundColor = null;
	btn_crd.style.backgroundColor = "orange";
	//결제수단 카드 드롭다운 보여주기
	slct_mn.style.display = null;
	slct_crd.style.display = "block";
}
/* form 제출 or 취소 */
function check(){
	alert("check() 호출됨. 미구현!!!!!!!!!! [TBC]");
	if()
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
		//현금or카드 대분류(SupMETHOD) 초기화
		document.fm.SupMETHOD.value = null;
		alert("clear SupMETHOD : "+document.fm.SupMETHOD.value);
		//현금or카드 버튼색 초기화
		btn_mn.style.backgroundColor = null;
		btn_crd.style.backgroundColor = null;
		//결제수단 row 초기화 (기본:가려짐)
		set_meth.style.display = null;
		slct_mn.style.display = null;
		slct_crd.style.display = null;
		//카테고리 드롭다운 초기화
		slct_nn.style.display = null;
		slct_in.style.display = null;
		slct_ex.style.display = null;
	}
}
</script>
</html>