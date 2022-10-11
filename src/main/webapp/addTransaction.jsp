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
		<tr><td><input type="date" name="DATE" id="date">
<!-- 			<input type="button" value="오늘" onClick="setToday()"></td></tr> -->
<!-- 3.카테고리 -->
	<!-- 드롭다운 : 초기화면 -->
		<tr><td><input type="hidden" name="CCODE" id="ccode">
				<select name="SLCT_NN" id="slct_nn">
					<option value="">--카테고리(미지정)--</option>
				</select>
	<!-- 드롭다운 : 수입 -->
				<select name="SLCT_IN" id="slct_in">
					<option value="">--카테고리(수입)--</option>
				<c:forEach items="${CATELIST }" var="c">
				<c:set var="cate_code" value="${c.cate_code }"/>
				<c:set var="cate_name" value="${c.cate_name }"/>
				<c:if test="${ fn:startsWith(cate_code,'IN') }">
					<option value="${c.cate_code }">${c.cate_name }</option>
				</c:if>		
				</c:forEach></select>
	<!-- 드롭다운 : 지출 -->
				<select name="SLCT_EX" id="slct_ex">
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
			<td><input type="hidden" name="SupMETHOD">
				<input type="hidden" name="MCODE" id="mcode">
				<input type="button" value="현금" onClick="setMN()" id="btn_mn">
				<input type="button" value="카드" onClick="setCRD()" id="btn_crd">
				</td>
	<!-- 드롭다운 : 현금 -->
			<td><select name="SLCT_MN" id="slct_mn">
					<option value="">--결제수단(현금)--</option>
				<c:forEach items="${METHLIST }" var="m">
				<c:set var="meth_code" value="${m.meth_code }"/>
				<c:set var="meth_name" value="${m.meth_name }"/>
				<c:if test="${ fn:startsWith(meth_code,'MN') }">
					<option value="${m.meth_code }">${m.meth_name }</option>
				</c:if>		
				</c:forEach></select>
	<!-- 드롭다운 : 카드 -->
				<select name="SLCT_CRD" id="slct_crd">
					<option value="">--결제수단(카드)--</option>
				<c:forEach items="${METHLIST }" var="m">
				<c:set var="meth_code" value="${m.meth_code }"/>
				<c:set var="meth_name" value="${m.meth_name }"/>
				<c:if test="${ fn:startsWith(meth_code,'CRD') }">
					<option value="${m.meth_code }">${m.meth_name }</option>
				</c:if>		
				</c:forEach></select>
			</td></tr>	
	<!-- (확인용 hidden) 전체 결제수단 출력-->
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
/* 변수 : css 통제를 위한 html 요소 식별 */
const btn_in = document.getElementById("btn_in");
const btn_ex = document.getElementById("btn_ex");
const date = document.getElementById("id");
const ccode = document.getElementById("ccode");
const slct_nn = document.getElementById("slct_nn");
const slct_in = document.getElementById("slct_in");
const slct_ex = document.getElementById("slct_ex");
const set_meth = document.getElementById("set_meth");
const btn_mn = document.getElementById("btn_mn");
const btn_crd = document.getElementById("btn_crd");
const mcode = document.getElementById("mcode");
const slct_mn = document.getElementById("slct_mn");
const slct_crd = document.getElementById("slct_crd");
/* 공통 기능 */
function clearValCCODE(){ //카테고리 선택값 초기화
	alert("BEFORE> slct_nn: "+slct_nn.value+" / slct_in: "+slct_in.value+
			" / slct_ex: "+slct_ex.value+"\n=> CCODE: "+ccode.value);
	ccode.value = ""; slct_nn.value = ""; slct_in.value = ""; slct_ex.value = "";
	alert("AFTER> slct_nn: "+slct_nn.value+" / slct_in: "+slct_in.value+
			" / slct_ex: "+slct_ex.value+"\n=> CCODE: "+ccode.value);
}
function clearVarMCODE(){ //결제수단 선택값 초기화
	alert("BEFORE> slct_mn: "+slct_mn.value+" / slct_crd: "+slct_crd.value+"\n=> MCODE: "+mcode.value);
	mcode.value = ""; slct_mn.value = ""; slct_crd.value = "";
	alert("AFTER> slct_mn: "+slct_mn.value+" / slct_crd: "+slct_crd.value+"\n=> MCODE: "+mcode.value);
}
function setINEX(INorEX){ //수입or지출 구분(INEX) 매개변수 받아 설정
	document.fm.INEX.value = INorEX;
	alert("set INEX : "+document.fm.INEX.value);
}
function setSupMETHOD(MNorCRD){ //현금or카드 대분류(SupMETHOD) 매개변수 받아 설정
	document.fm.SupMETHOD.value = MNorCRD;
	alert("set SupMETHOD : "+document.fm.SupMETHOD.value);
}
function onoffSET_METH(ONorOFF){ //결제수단 row 표시,비표시 (기본:가려짐)
	if(ONorOFF=="ON") set_meth.style.display = "block";
	if(ONorOFF=="OFF") set_meth.style.display = null;
}
function showSLCT_XX(NNINEX){ //카테고리(XX)만 남기고 가리기
	if(NNINEX=="NN") {
		slct_nn.style.display = "block";
		slct_in.style.display = "none";
		slct_ex.style.display = "none";
	}else if(NNINEX=="IN") {
		slct_nn.style.display = "none";
		slct_in.style.display = "block";
		slct_ex.style.display = "none";
	}else if(NNINEX=="EX") {
		slct_nn.style.display = "none";
		slct_in.style.display = "none";
		slct_ex.style.display = "block";
	}
}
function colorBtnINEX(INorEX){ //버튼 색 바꾸기 - 수입or지출
	if(INorEX=="IN"){ 
		btn_in.style.backgroundColor = "blue";
		btn_ex.style.backgroundColor = null;
	}else if(INorEX=="EX"){ 
		btn_in.style.backgroundColor = null;
		btn_ex.style.backgroundColor = "red";
	}
}
function colorBtnMNCRD(MNorCRD){ //버튼 색 바꾸기 - 현금or카드
	if(MNorCRD=="MN"){ 
		btn_mn.style.backgroundColor = "orange";
		btn_crd.style.backgroundColor = null;
	}else if(MNorCRD=="CRD"){ 
		btn_mn.style.backgroundColor = null;
		btn_crd.style.backgroundColor = "orange";
	}
}
function clearBtnAll(){ //버튼 색 all초기화 - 수입,지출,현금,카드
	btn_in.style.backgroundColor = null;
	btn_ex.style.backgroundColor = null;
	btn_mn.style.backgroundColor = null;
	btn_crd.style.backgroundColor = null;
}
function openSlct(MNorCRD){ //결제수단 드롭다운(현금or카드) 보여주기
	if(MNorCRD=="MN"){ 
		slct_mn.style.display = "block";
		slct_crd.style.display = null;
	}else if(MNorCRD=="CRD"){ 
		slct_mn.style.display = null;
		slct_crd.style.display = "block";
	}
}
/* 공통 기능 끝 */
/* 수입 or 지출 선택 */
function setIN(){ //[수입]
	alert("setIN() 호출됨");
	setINEX("IN"); //수입or지출 구분(INEX) : 수입(IN)
	colorBtnINEX("IN"); //버튼 색 바꾸기
	onoffSET_METH("OFF"); //결제수단 row 가리기
	showSLCT_XX("IN"); //카테고리(수입)만 남기고 가리기
	clearValCCODE(); //카테고리 선택값 초기화
	clearVarMCODE(); //결제수단 선택값 초기화
	alert("끝");
}
function setEX(){ //[지출]
	alert("setEX() 호출됨");
	setINEX("EX"); //수입or지출 구분(INEX) : 지출(EX)
	colorBtnINEX("EX"); //버튼 색 바꾸기
	onoffSET_METH("ON"); //결제수단 row 보여주기
	showSLCT_XX("EX"); //카테고리(지출)만 남기고 가리기
	clearValCCODE(); //카테고리 선택값 초기화
	alert("끝");
}

/* 현금 or 카드 선택 */
function setMN(){ //[현금]버튼 클릭시
	alert("setMN() 호출됨");
	setSupMETHOD("MN"); //현금or카드 대분류(SupMETHOD) : 현금(MN)
	colorBtnMNCRD("MN"); //버튼 색 바꾸기
	openSlct("MN"); //결제수단 드롭다운 보여주기 : 현금
	alert("끝");
}
function setCRD(){ //[카드]버튼 클릭시
	alert("setCRD() 호출됨");
	setSupMETHOD("CRD"); //현금or카드 대분류(SupMETHOD) : 현금(CRD)
	colorBtnMNCRD("CRD"); //버튼 색 바꾸기
	openSlct("CRD"); //결제수단 드롭다운 보여주기 : 카드
	alert("끝");
}
/* form 제출 or 취소 */
function check(){
	alert("check() 호출됨. ---작성중---");
	/* CCODE: 미선택,지출,소비로 나눠져있는 드롭다운에서 최종값을 찾아 form 필드에 전달 */
	let ccode = document.fm.CCODE.value;
	let ccode_nn = document.fm.SLCT_NN.value;
	let ccode_in = document.fm.SLCT_IN.value;
	let ccode_ex = document.fm.SLCT_EX.value;
	if(ccode_in != '') ccode = ccode_in; else if(ccode_ex != '') ccode = ccode_ex; else ccode = ''; 
	alert("\nccode_nn: "+ccode_nn+" / ccode_in: "+ccode_in+" / ccode_ex: "+ccode_ex+"\n=> ccode: "+ccode);
	/* 카테고리 선택:필수아님 -> 미선택시 서블릿에서 디폴트 값 입력 */
// 	if(ccode == ''){ alert("카테고리를 선택해주세요."); return false } 
	/* MCODE: 현금,카드로 나눠져있는 드롭다운에서 최종값을 찾아 form 필드에 전달 */
	let mcode = document.fm.MCODE.value;
	let slct_mn = document.fm.SLCT_MN.value;
	let slct_crd = document.fm.SLCT_CRD.value;
	if(slct_mn != '') mcode = slct_mn; else if(slct_crd != '') mcode = slct_crd; else mcode = ''; 
	alert("\nslct_mn: "+slct_mn+" / slct_crd: "+slct_crd+"\n=> mcode: "+mcode);
	/* 결제수단 선택:필수아님 -> 수입일 때 결제수단 없음. + 지출이고 미선택시 서블릿에서 디폴트 값 입력 */
// 	if(mcode == ''){ alert("결제수단을 선택해주세요."); return false }
	
	
	
	let item = document.fm.ITEM.value;
	let inex = document.fm.INEX.value;
	if(inex == ''){ alert("지출/소비 구분을 선택해주세요."); return false }
	let date = document.fm.DATE.value;
	if(date == ''){ alert("거래날짜를 선택해주세요."); return false }
	
	if(item == ''){ alert("내용을 입력해주세요."); return false }
	let amount = document.fm.AMOUNT.value;
	if(amount == ''){ alert("금액을 입력해주세요."); return false }
	
	alert("inex: "+inex+"\ndate: "+date+"item: "+item+"\namount: "+amount
			+"\nccode_nn: "+ccode_nn+" / ccode_in: "+ccode_in+" / ccode_ex: "+ccode_ex+"\n=> ccode: "+ccode
			+"\nslct_mn: "+slct_mn+" / slct_crd: "+slct_crd+"\n=> mcode: "+mcode);
	
	
	let detailConf = "구분 : "+inex+"\n거래날짜 : "+date+"\n카테고리 : "+ccode+"\n금액 : "+amount+"원\n";
	if(! confirm("등록하시겠습니까?\n\n---\n"+detailConf) ) return false;
	if(! confirm("등록될 seqno : "+document.fm.SEQNO.value) ) return false;	
	alert("끝");
}
function backToList(){
	if(confirm("취소하고 홈화면으로 돌아가시겠습니까?")){
		location.href="index.jsp";
	}else {
	/* reset 시 fm 입력 값은 자동 초기화됨을 확인했음. 단 js css는 수동 초기화 필요. */
		//버튼 색 all초기화 - 수입,지출,현금,카드
		clearBtnAll
		
		//결제수단 row 초기화 (기본:가려짐)
		set_meth.style.display = null;
		slct_mn.style.display = null;
		slct_crd.style.display = null;
		//카테고리 드롭다운 초기화
		slct_nn.style.display = null;
		slct_in.style.display = null;
		slct_ex.style.display = null;
	}
	alert("끝");
}
/* 거래날짜 오늘로 설정 <- 잘안됨 일단 버려둠..*/
//function setToday(){
//	alert("setToday() 호출됨 ---작성중---");
//	document.fm.DATE.value = new Date();
//	alert("set DATE : "+document.fm.SupMETHOD.value);
//}
</script>
</html>