/**
 * @addTransaction.jsp
 */
/* 변수 : css 통제를 위한 html 요소 식별 */
const btn_in = document.getElementById("btn_in");
const btn_ex = document.getElementById("btn_ex");
const date = document.getElementById("id");
const ccode = document.getElementById("ccode");
const slct_nn = document.getElementById("slct_nn");
const slct_in = document.getElementById("slct_in");
const slct_ex = document.getElementById("slct_ex");
const row_meth = document.getElementById("row_meth");
const btn_mn = document.getElementById("btn_mn");
const btn_crd = document.getElementById("btn_crd");
const mcode = document.getElementById("mcode");
const slct_mn = document.getElementById("slct_mn");
const slct_crd = document.getElementById("slct_crd");

/* --- form 제출 or 취소 --- */
function makeSubmit(){
	
	
}

function check(){
// 	alert("check() 호출됨. ");
	/* 안내문 출력해주기 위한 문자열 변수 선언 */
	let guide = "";
	/* CCODE: 미선택,지출,소비로 나눠져있는 드롭다운에서 최종값을 찾아 form 필드에 전달 */
	let ccode_val = document.fm.CCODE.value;
	let slct_nn_val = document.fm.SLCT_NN.value;
	let slct_in_val = document.fm.SLCT_IN.value;
	let slct_ex_val = document.fm.SLCT_EX.value;
	if(slct_in_val != '') ccode_val = slct_in_val; 
	else if(slct_ex_val != '') ccode_val = slct_ex_val; 
	else ccode_val = ""; 
// 	alert("\nslct_nn_val: "+slct_nn_val+" / slct_in_val: "+slct_in_val+" / slct_ex_val: "+slct_ex_val+"\n=> CCODE_val: "+ccode_val);
	/* CHECK> 카테고리 선택:필수no!(안내문) -> 미선택시 서블릿에서 디폴트 값 입력 */
	//	if(ccode_val == ''){ alert("카테고리를 선택해주세요."); return false } 
		if(ccode_val == ''){ guide = guide+"카테고리가 선택되지 않았습니다.<br/>"; }
	/* MCODE: 현금,카드로 나눠져있는 드롭다운에서 최종값을 찾아 form 필드에 전달 */
	let mcode_val = document.fm.MCODE.value;
	let slct_mn_val = document.fm.SLCT_MN.value;
	let slct_crd_val = document.fm.SLCT_CRD.value;
	if(slct_mn_val != '') mcode_val = slct_mn_val; else if(slct_crd_val != '') mcode_val = slct_crd_val; else mcode_val = ''; 
// 	alert("\nslct_mn_val: "+slct_mn_val+" / slct_crd_val: "+slct_crd_val+"\n=> MCODE_val: "+mcode_val);
	/* CHECK> 내용 입력:필수no!(안내문) -> 미입력시 서블릿에서 디폴트 값 입력 */
	let item_val = document.fm.ITEM.value;
	//	if(item_val == ''){ alert("내용을 입력해주세요."); return false }
		if(item_val == ''){ guide = guide+"내용이 비어있습니다.<br/>"; }
	/* CHECK> 지출/소비 구분:필수 */	
	let inex_val = document.fm.INEX.value;
	if(inex_val == ''){ alert("지출/소비 구분을 선택해주세요."); return false }
	/* CHECK> 결제수단 선택:필수no!(안내문) -> 미선택시 서블릿에서 디폴트(수입:미지정,지출:해당없음) 값 입력 */
	//	if(mcode_val == ''){ alert("결제수단을 선택해주세요."); return false }
		if(inex_val == "EX"){
			if(mcode_val == ''){ guide = guide+"결제수단이 선택되지 않았습니다.<br/>"; }
		}	
	/* CHECK> 거래날짜:필수 */
	let date_val = document.fm.DATE.value;
	if(date_val == ''){ alert("거래날짜를 선택해주세요."); return false }
	/* 여기서 안내문 출력해줌 */
	document.getElementById("guide").innerHTML = guide;
	/* CHECK> 금액 */
	let amount_val = document.fm.AMOUNT.value;
	if(amount_val == ''){ alert("금액을 입력해주세요."); return false }
// 	alert("여기1");
	/* 최종 컨펌을 위한 txt 출력값 생성 */
	let inex_txt = ""; //선택한 수입or지출 구분의 txt명 
	if(inex_val == "IN") inex_txt = "수입"; else if(inex_val == "EX") inex_txt = "지출";
	let ccode_txt = ""; //선택한 카테고리 코드의 txt명 
	switch(inex_val) {
		case "IN" : 
			if(slct_in_val==""){ ccode_txt = "미지정"; 
			}else {
				alert("slct_in_val : "+slct_in_val);
				ccode_txt = slct_in.options[slct_in.selectedIndex].text;
				alert("ccode_txt : "+ccode_txt);
			} break;
		case "EX" :
			if(slct_ex_val == ""){ ccode_txt = "미지정"; 
			}else { ccode_txt = slct_ex.options[slct_ex.selectedIndex].text; } break; 
		case "" : ccode_txt = "미지정"; break;
	}
	let item_txt = " - "; //내용 미입력일 때 이거 하나만 보일 txt명 
	let mcode_txt = ""; //선택한 결제수단 코드의 txt명
	switch(document.fm.SupMETHOD.value) {
		case "MN" : 
			if(slct_mn_val == ""){ mcode_txt = "미지정"; }
			else { mcode_txt = slct_mn.options[slct_mn.selectedIndex].text; } break; 
		case "CRD" :
			if(slct_crd_val == ""){ mcode_txt = "미지정"; }
			else { mcode_txt = slct_crd.options[slct_crd.selectedIndex].text; }	break; 
		case "" : 
			if(inex_val =="EX"){ mcode_txt = "미지정"; }
			else if(inex_val == "IN"){ mcode_txt = "해당없음"; }	break;
	}
// 	alert("여기2");
	/* 최종 컨펌 */
	let detailConf = "● 구분 : "+inex_val+" - "+inex_txt+"\n● 거래날짜 : "+date_val
				+"\n● 카테고리 : "+ccode_val+" - "+ccode_txt+"\n● 내용 : "+item_val + item_txt
				+"\n● 금액 : "+amount_val+" 원\n● 결제수단 : "+mcode_val+" - "+mcode_txt;
	if(! confirm("등록하시겠습니까?\n---\n"+detailConf) ) return false;
	if(! confirm("등록될 seqno : "+document.fm.SEQNO.value) ) return false;	
	alert("끝");
}
function backToList(){
	alert("backToList() 호출됨.");
	if(confirm("취소하고 홈화면으로 돌아가시겠습니까?")){
		location.href="index.jsp";
	}else {
	/* reset 시 fm 입력 값은 자동 초기화됨을 확인했음. 단 js css는 수동 초기화 필요. */
		clearBtnAll(); //버튼 색 all초기화 - 수입,지출,현금,카드 
		onoffROW_METH("OFF"); //결제수단 row 초기화 (기본:가려짐)
		showSLCT_XX(); //카테고리 드롭다운 초기화
	}
	alert("끝");
}
/* --- form 제출 or 취소 끝--- */

/* --- form 입력 과정 func --- */
/* 수입 or 지출 선택 */
function doIN(){ //[수입]
// 	alert("doIN() 호출됨");
	setINEX("IN"); //수입or지출 구분(INEX) : 수입(IN)
	colorBtnINEX("IN"); //버튼 색 바꾸기
	onoffROW_METH("OFF"); //결제수단 row 가리기
	showSLCT_XX("IN"); //카테고리(수입)만 남기고 가리기
	clearValCCODE(); //카테고리 선택값 초기화
	clearVarMCODE(); //결제수단 선택값 초기화
// 	alert("끝");
}
function doEX(){ //[지출]
// 	alert("doEX() 호출됨");
	setINEX("EX"); //수입or지출 구분(INEX) : 지출(EX)
	colorBtnINEX("EX"); //버튼 색 바꾸기
	onoffROW_METH("ON"); //결제수단 row 보여주기
	showSLCT_XX("EX"); //카테고리(지출)만 남기고 가리기
	clearValCCODE(); //카테고리 선택값 초기화
// 	alert("끝");
}
/* 현금 or 카드 선택 */
function doMN(){ //[현금]버튼 클릭시
// 	alert("doMN() 호출됨");
	setSupMETHOD("MN"); //현금or카드 대분류(SupMETHOD) : 현금(MN)
	colorBtnMNCRD("MN"); //버튼 색 바꾸기
	openSlct("MN"); //결제수단 드롭다운 보여주기 : 현금
// 	alert("끝");
}
function doCRD(){ //[카드]버튼 클릭시
// 	alert("doCRD() 호출됨");
	setSupMETHOD("CRD"); //현금or카드 대분류(SupMETHOD) : 현금(CRD)
	colorBtnMNCRD("CRD"); //버튼 색 바꾸기
	openSlct("CRD"); //결제수단 드롭다운 보여주기 : 카드
// 	alert("끝");
}
/* 거래날짜 오늘로 설정 <- 잘안됨 일단 버려둠..*/
//function setToday(){
//	alert("setToday() 호출됨 ---작성중---");
//	document.fm.DATE.value = new Date();
//	alert("set DATE : "+document.fm.SupMETHOD.value);
//}
/* --- form 입력 과정 func 끝--- */

/* --- 공통 기능 func --- */
function clearValCCODE(){ //카테고리 선택값 초기화
// 	alert("BEFORE> slct_nn: "+slct_nn.value+" / slct_in: "+slct_in.value+" / slct_ex: "+slct_ex.value+"\n=> CCODE: "+ccode.value);
	ccode.value = ""; slct_nn.value = ""; slct_in.value = ""; slct_ex.value = "";
// 	alert("AFTER> slct_nn: "+slct_nn.value+" / slct_in: "+slct_in.value+" / slct_ex: "+slct_ex.value+"\n=> CCODE: "+ccode.value);
}
function clearVarMCODE(){ //결제수단 선택값 초기화
// 	alert("BEFORE> slct_mn: "+slct_mn.value+" / slct_crd: "+slct_crd.value+"\n=> MCODE: "+mcode.value);
	mcode.value = ""; slct_mn.value = ""; slct_crd.value = "";
// 	alert("AFTER> slct_mn: "+slct_mn.value+" / slct_crd: "+slct_crd.value+"\n=> MCODE: "+mcode.value);
}
function setINEX(INorEX){ //수입or지출 구분(INEX) 매개변수 받아 설정
	document.fm.INEX.value = INorEX;
// 	alert("set INEX : "+document.fm.INEX.value);
}
function setSupMETHOD(MNorCRD){ //현금or카드 대분류(SupMETHOD) 매개변수 받아 설정
	document.fm.SupMETHOD.value = MNorCRD;
// 	alert("set SupMETHOD : "+document.fm.SupMETHOD.value);
}
function onoffROW_METH(ONorOFF){ //결제수단 row 표시,비표시 (기본:가려짐)
	if(ONorOFF=="ON") row_meth.style.display = "block";
	if(ONorOFF=="OFF") row_meth.style.display = null;
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
	}else {
		slct_nn.style.display = "none";
		slct_in.style.display = "none";
		slct_ex.style.display = "none";
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
/* --- 공통 기능 func 끝 --- */
