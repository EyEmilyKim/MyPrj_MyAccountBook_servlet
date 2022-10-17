<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signUp.jsp</title>
</head>
<body>
<div>
	<form action="signUp.do" method="post" name="fm" onSubmit="return check(this)">
		<input type="hidden" name="idChecked"/>
	<table>
		<tr><td><input type="text" size="25" name="ID" id="id" placeholder="아이디">
				<input type="button" value="중복 검사" onClick="idCheck()"/></td></tr>
		<tr><td><input type="password" size="30" name="PWD" placeholder="비밀번호"></td></tr>
		<tr><td><input type="password" size="30" name="PWDCONF" placeholder="비밀번호 확인"></td></tr>
		<tr><td><input type="text" size="30" name="NNAME" placeholder="닉네임"></td></tr>
		<tr><td><input type="text" size="30" name="EMAIL" placeholder="이메일"></td></tr>
		<tr><td>생년월일 : <input type="date" size="30" name="BDAY" placeholder="생년월일"></td></tr>
		<tr><td><input type="submit" value="가입하기"/>
				<input type="reset" value="다시쓰기"></td></tr>
	</table>
	</form>
	</div>
</body>
<script type="text/javascript">
function idCheck(){
	var entryId = document.fm.ID.value;  
	if(entryId == ""){ alert("아이디를 입력하세요."); return; }
	//폼 이름 frm 으로 했더니 로그인 창의 frm 과 이름이 중복돼서 먹통됐었음.
	var url = "idCheck.do?ID=" + entryId;
	window.open(url, "아이디 중복확인", "width=450 height=250" );	
}
function check(fm){
// 	alert("check(fm) 호출됨");
	if(fm.ID.value == ""){ alert("아이디를 입력하세요."); return false; }
	if(fm.idChecked.value == ""){ alert("아이디 중복검사를 해주세요."); return false; }
	if(fm.PWD.value == ""){ alert("암호를 입력하세요."); return false; }
	if(fm.PWD.value != fm.PWDCONF.value){ alert("암호가 일치하지 않습니다."); return false; }
	if(fm.NNAME.value == ""){ alert("닉네임을 입력하세요."); return false; }
	if(fm.EMAIL.value == ""){ alert("이메일을 입력하세요."); return false; }
	if(fm.BDAY.value == ""){ alert("생년월일을 입력하세요."); return false; }
	
	if( ! confirm("가입하시겠습니까?") ) return false;
}
</script>
</html>