<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
</head>
<body>
	<div>
	<form action="login.do" method="post" name="fm" onSubmit="return check()">
	<table>
	<tr><td><input type="text" size="30" name="ID" placeholder="아이디"></td></tr>
	<tr><td><input type="password" size="30" name="PWD" placeholder="비밀번호"></td></tr>
	<tr><td><input type="submit" value="로그인"></td></tr>
	</table>
	</form>
	</div>
</body>
<script type="text/javascript">
function check(){
	if(document.fm.ID.value ==''){
		alert("아이디를 입력하세요."); return false;
	}
	if(document.fm.PWD.value ==''){
		alert("암호를 입력하세요."); return false;
	}
}
</script>
</html>