<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listEXTransaction.jsp</title>
	<style type="text/css">
		.contMain { border: 1px skyblue solid; max-width: 700px;}
		.listMain, .page { text-align: center; border: 1px red solid; margin: 5px 10px; }
		.oneTrans { border: 1px gray solid; margin: 5px 10px; }
		.upper, .lower { display:flex; justify-content: space-between; text-align:center; }	
		.inner { margin:0 auto; }
		.in { color:blue; } .ex { color:red; }
		.cate, .meth { color: skyblue; }
		.hidden { display:none; }
		.addTrans {
			display: block;
		    border: 1px solid black;
		    width: 150px;
		    font-size: 1.3rem;
		    font-weight: 600;
		    margin: auto;
		    padding: 1rem;
		    border-radius: 10px;
		    text-decoration: none;
		    background-color: white;
		    color: black;
  		  }
	/* structure */
		.preSrch, .set_listCount { display:flex; justify-content: space-between; margin:10px; }
		.left { align:left; border:orange solid 1px; } 
		.right { display:flex; align:right; border:orange solid 1px; }
		.btn_search { margin:0px 5px;}
		#set_search { display:none; }
	</style>
</head>
<body onLoad="preset()">
<div class="home">
	<a href="index.jsp">My 가계부</a>
</div>
<div class="contMain">
	<h3>지출 목록 화면입니다.</h3>
<!-- 목록 화면 컨트롤	-->
	<form class="" name="preset">
		<c:if test="${param.SRCH == 'true' }">
		<div class="preSrch">
			<div class="left">
			기간: [ ${SRCH_V[0] } ~ ${SRCH_V[1] } ] / 내용 : [ ${SRCH_V[2] } ] / 카테고리 : [ ${SRCH_V[3] } ] / 결제수단 : [ ${SRCH_V[4] } ] 검색 결과입니다.
			<input type="button" value="전체보기" onClick="location.href='listTransaction.do?INEX=EX&SLC=${param.SLC }'"></div>
		</div>	
		</c:if>
	</form>
	<div class="set_listCount">
		<div class="left cnt"> # ${STARTRN } ~ ${ENDRN } / 총 ${TOTAL } 건<br></div>
		<div class="right">
			<div class="btn_search">
			<input type="button" value="검색" onClick="switchSearch()"></div>
			<div id="slc"><form action="listTransaction.do" name="fmLC">
				<input type="hidden" name="INEX" value="EX">
			<c:if test="${param.SRCH == 'true' }">
				<input type="hidden" name="D_FROM" value="${SRCH_V[0] }">
				<input type="hidden" name="D_TO" value="${SRCH_V[1] }">
				<input type="hidden" name="ITEM" value="${SRCH_V[2] }">
				<input type="hidden" name="CATE" value="${SRCH_V[3] }">
				<input type="hidden" name="METH" value="${SRCH_V[4] }">
			</c:if>	
				<select name="SLC" id="slct_slc" onChange="showListCounted(this.value)">
					<option value="5">5줄 보기</option>
					<option value="10">10줄 보기</option>
					<option value="15">15줄 보기</option>
				</select></form></div></div>
	</div>	<!-- set_listCount 끝 --> 
	<form action="listTransaction.do?INEX=EX" name="fmSRCH" >
	<div id="set_search"><input type="hidden" id="onOff_set_search" value="0">
		<input type="hidden" name="INEX" value="EX">
		<input type="hidden" name="SLC" value="${param.SLC }" size="3">
		<input type="date" name="D_FROM" id="d_from"> ~ <input type="date" name="D_TO" id="d_to"> 
		<input type="text" name="ITEM" placeholder="--내용--" size="10"><br/>
		<select name="CATE">
			<option value="">--카테고리--</option>
		<c:forEach items="${CATELIST }" var="c">
			<c:set var="cate_code" value="${c.cate_code }"/>
			<c:set var="cate_name" value="${c.cate_name }"/>
			<c:if test="${ fn:startsWith(cate_code,'EX') }">
				<option>${c.cate_name }</option>
			</c:if>		
		</c:forEach>
			<option>미지정</option>
		</select>
		<select name="METH">
			<option value="">--결제수단--</option>
		<c:forEach items="${METHLIST }" var="m">
			<option>${m.meth_name }</option>
			</c:forEach>
		</select>
		<input type="submit" value="조회하기">
	</div>	<!-- set_search 끝 --> 
	
	</form>
		<!-- search 끝 -->
<!-- 목록 화면 컨트롤 끝 --> 
<!-- 실제 목록 -->
	<div class="listMain">
	<c:if test="${TOTAL == 0 }">
	<div class="noTrans">
	<p>	거래내역이 없습니다.</p>
	<a href="makeAddTrans.do" class="addTrans">가계부 쓰기</a><br><br>
	</div>
	</c:if>
	<c:forEach items="${LIST }" var="trans">
	<div class="oneTrans">
		<div class="upper">
			<div class="inner date">${trans.trans_date }</div>
			<c:if test="${trans.inex == 'IN' }">
			<div class="inner in">수입</div>
			</c:if>
			<c:if test="${trans.inex == 'EX' }">
			<div class="inner ex">지출</div>
			</c:if>
			<div class="inner item">
			<a href="detailTransaction.do?SN=${trans.seqno }">${trans.item }</a></div>
			<div class="inner amnt"><fmt:formatNumber groupingUsed="true">
			${trans.amount }</fmt:formatNumber>원</div>
		</div>
		<div class="lower">
			<div class="hidden inner seqno">${trans.seqno }</div>
			<div class="inner cate">카테고리: ${trans.cate_name }</div>
			<div class="inner meth">결제수단: ${trans.meth_name }</div>
		</div>
	</div> <!-- oneTrans 끝 -->
	</c:forEach>
	</div> <!-- list 끝 -->
	<div class="page">
		<c:if test="${ param.SRCH == 'false' }">
			<c:forEach begin="1" end="${PAGES }" var="page">
			<a href="listTransaction.do?INEX=EX&SLC=${param.SLC }&PG=${page }">${page }</a>	
			</c:forEach>
		</c:if>
		<c:if test="${ param.SRCH == 'true' }">
			<c:forEach begin="1" end="${PAGES }" var="page">
			<a href="listTransaction.do?INEX=EX&SLC=${param.SLC }&PG=${page }&
			D_FROM=${SRCH_V[0] }&D_TO=${SRCH_V[1] }&ITEM=${SRCH_V[2] }&CATE=${SRCH_V[3] }&METH=${SRCH_V[4] }">${page }</a>	
			</c:forEach>
		</c:if>
	</div>
</div> <!-- contMain 끝 -->
</body>

<script type="text/javascript">
const set_search = document.getElementById("set_search");
const slct_slc = document.getElementById("slct_slc");
const onOff_set_search = document.getElementById("onOff_set_search");
/* 화면 로드시 데이터에 따라 미리 html 요소 반영 */
function preset(){ 
// 	alert("로드되었습니다");
	const pre_slc = document.fmSRCH.SLC.value;
	slct_slc.value = pre_slc;
}
function switchSearch(){
// 	alert("showSearch() 호출됨");
	if(onOff_set_search.value == "0") {
		set_search.style.display = "block"; onOff_set_search.value = "1";
	}else if(onOff_set_search.value == "1"){
		set_search.style.display = "none"; onOff_set_search.value = "0";
	}
}
function showListCounted(thisV){ //선택지 바뀌면 해당 수 만큼 거래목록 조회
// 	alert("showListCounted(thisV) 호출됨" +"\nthisV : "+thisV);
	document.fmLC.submit();
}
</script>
</html>