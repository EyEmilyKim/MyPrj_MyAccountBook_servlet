<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<BODY>
<p>출처 : https://kin.naver.com/qna/detail.naver?d1id=1&dirId=1040202&docId=72986135&qb=Zm9ybSBzZWxlY3Qgb3B0aW9u6rCSIOy0iOq4sO2ZlCDtlajsiJg=&enc=utf8&section=kin.ext&rank=5&search_sort=0&spq=0</p>

<form name="form1">
<select name="select1" id="select1">
	<option>1</option>
	<option>2</option>
	<option>3</option>
</select><br>
<input type="text" name="txt" placeholder="id: txt"><br>
<input type="text" name="val" placeholder="id: val"><br>
<input type="button" value="append" onclick="Append()">
<input type="button" value="clear" onclick="Remove()"><br>
</form>
<script type="text/javascript">
function Remove(){
 var s = document.form1.select1;
 alert(s.value);
 while(s.options.length > 0) s.options.remove(0);
 alert(s.value);
 //이건 해보니까 ... 선택값이 아니라 그냥 옵션 자체를 날려버리는 거였다-_-;;ㅋㅋㅋㅋㅋ
}

function Append(){
 var option = new Option();
 option.value = document.form1.val.value;
 option.text = document.form1.txt.value;
 document.form1.select1.options.add(option);
}
</script>

</BODY>
</HTML>