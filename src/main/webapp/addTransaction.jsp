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
	.contMain { border: 1px skyblue solid; max-width: 400px;}
	#slct_in, #slct_ex, #row_meth, #slct_mn, #slct_crd { display:none; } 
	#guide { color:red; } #ccode, #mcode { border:orange solid 1px;  display:none; }
	.hidden { display:none; } .test {border:red solid 1px; color:orange; }
</style>
</head>
<body>
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
	<div class="contMain">
	<p>가계부 쓰기 화면입니다.</p>
	
	<form action="addTransaction.do" method = "post" name="fm" onSubmit="return catchSub()">
<!-- 0.일련번호(hidden)-->
		<input type="hidden" name="SEQNO" value="${requestScope.MSN +1 }">
		<table>
<!-- 1.수입or지출 구분 -->
		<tr><td><input type="hidden" name="INEX" id="inex">
			<input type="button" value="수입" onClick="doIN()" id="btn_in">
			<input type="button" value="지출" onClick="doEX()" id="btn_ex">
			</td></tr>
<!-- 2.거래날짜 -->
		<tr><td><input type="date" name="DATE" id="date"></td></tr>
<!--  버려둔 버튼	<input type="button" value="오늘" onClick="setToday()"></td></tr> -->
<!-- 3.카테고리 -->
	<!-- 드롭다운 : 초기화면 -->
		<tr><td><input type="text" name="CCODE" id="ccode" placeholder="ccode 자동수신">
				<select name="SLCT_NN" id="slct_nn">
					<option value="">--카테고리(미지정)--</option>
				</select>
	<!-- 드롭다운 : 수입 -->
				<select name="SLCT_IN" id="slct_in" onChange="setCCODE(this)">
					<option value="">--카테고리(수입)--</option>
				<c:forEach items="${CATELIST }" var="c">
				<c:set var="cate_code" value="${c.cate_code }"/>
				<c:set var="cate_name" value="${c.cate_name }"/>
				<c:if test="${ fn:startsWith(cate_code,'IN') }">
					<option value="${c.cate_code }">${c.cate_name }</option>
				</c:if>		
				</c:forEach></select>
	<!-- 드롭다운 : 지출 -->
				<select name="SLCT_EX" id="slct_ex" onChange="setCCODE(this)">
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
		<tr><td><textarea name="ITEM" placeholder="내용을 입력하세요"
		 			cols="40" rows="5"></textarea></td></tr>
<!-- 5.거래금액 -->
		<tr><td>
			<input type="text" placeholder="금액을 입력하세요" name="AMOUNT"></td></tr>
<!-- 6.결제수단 -->	
	<!-- 현금or카드 버튼 -->
		<tr id="row_meth">
			<td><input type="hidden" name="SupMETHOD">
				<input type="text" name="MCODE" id="mcode"  placeholder="mcode 자동수신">
				<input type="button" value="현금" onClick="doMN()" id="btn_mn">
				<input type="button" value="카드" onClick="doCRD()" id="btn_crd">
				</td>
	<!-- 드롭다운 : 현금 -->
			<td><select name="SLCT_MN" id="slct_mn" onChange="setMCODE(this.value)">
					<option value="">--결제수단(현금)--</option>
				<c:forEach items="${METHLIST }" var="m">
				<c:set var="meth_code" value="${m.meth_code }"/>
				<c:set var="meth_name" value="${m.meth_name }"/>
				<c:if test="${ fn:startsWith(meth_code,'MN') }">
					<option value="${m.meth_code }">${m.meth_name }</option>
				</c:if>		
				</c:forEach></select>
	<!-- 드롭다운 : 카드 -->
				<select name="SLCT_CRD" id="slct_crd" onChange="setMCODE(this.value)">
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
		<tr class="hidden test"><td><input type="text" name="TEST1"></td></tr>	
		<tr class="hidden test"><td><input type="text" name="TEST2"></td></tr>	
		<tr class="hidden test"><td><input type="text" name="TEST3"></td></tr>	
<!-- 7.안내문구 출력row -->			
		<tr><td id="guide"></td></tr>	
<!-- 8.form 등록/취소 -->			
		<tr><td><br>
			<input type="submit" value="등록">
			<input type="reset" value="취소" onClick="backToList()"></td></tr>
		</table>
	</form>
	</div>
</body>
<script src="makeTransaction.js"></script>
</html>