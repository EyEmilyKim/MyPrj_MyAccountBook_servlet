<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="" name="fm">
		<input type="date" name="D_FROM"> ~ 
		<input type="date" name="D_TO"> 
		<button onClick="dateControl()">control</button>
	</form>
</body>
<script type="text/javascript">
function dateControl(){
	alert("dateControl() called.");
	const d_from = document.fm.D_FROM.value;
	const d_to = document.fm.D_TO.value;
	dd_from = new Date(d_from);
	dd_to = new Date(d_to);
	alert("dd_from / dd_to : \n"+dd_from+"\n"+dd_to);
	alert("dd_from.getDate() : "+dd_from.getDate());
// 	const today = new Date();
// 	alert("today : "+today);
	let d1 = new Date();
	let d2 = new Date();
// 	let prev = -1;
// 	let next = +1;
	alert("여기1"); //ok
	d1.setDate(dd_from.getDate()-1);
	d2.setDate(dd_to.getDate()+1);
	alert("여기2"); //ok
	alert("d1 : "+d1+"\nd2 : "+d2); //OK
	
	document.fm.D_FROM.value = d1; //이건 통과는 되는데 기대한 처리는 안됨 ㅠ
	alert("여기3"); //ok
	
}
</script>
</html>
