<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 3초 후 홈화면으로 이동 -->
<meta http-equiv="refresh" content="2; url=index.jsp">
<title>logoutResult.jsp</title>
</head>
<!-- 시간지연 전환 효과 주려다 실패  -->
<!-- <body onload="timer()"> -->
<body>
<div>
로그아웃 되었습니다.<br>
오늘도 좋은 하루 보내세요.<br>
<br>
~ 3초 뒤 My 가계부 홈으로 이동합니다 :) ~<br>
</div>
<!-- <script type="text/javascript"> -->
<!-- 	alert("로그아웃 되었습니다.\n오늘도 좋은 하루 보내세요."); -->
<!-- 	location.replace("index.jsp"); -->
<!-- </script> -->
</body>

<!-- 시간지연 전환 효과 주려다 실패  -->
<script type="text/javascript">
// function timer(){
//  	alert("timer() 호출됨");
// 	setTimeout(goHome(), 100000); //10초 뒤 실행
// }
// function goHome(){
// 	location.replace("index.jsp");
// }
</script>
</html>