<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEST</title>
</head>
<body>


<script type="text/javascript">
//대분류에 의한 소분류 동적 셀렉트
<!--
 
function smallChange(aa){
 
    if (aa == "util") {
        document.all.wr_2.length   = 6;
        document.all.wr_2[0].value = "u1";
        document.all.wr_2[0].text  = "일반유틸리티";
        document.all.wr_2[1].value = "u2";
        document.all.wr_2[1].text  = "백신,보안";
        document.all.wr_2[2].value = "u3";
        document.all.wr_2[2].text  = "개인,교육";
        document.all.wr_2[3].value = "u4";
        document.all.wr_2[3].text  = "업무";
        document.all.wr_2[4].value = "u5";
        document.all.wr_2[4].text  = "시스템,최적화";
        document.all.wr_2[5].value = "u6";
        document.all.wr_2[5].text  = "윈도우패치";
    }
    if (aa == "multi") {
        document.all.wr_2.length   = 5;
        document.all.wr_2[0].value = "m1";
        document.all.wr_2[0].text  = "동영상SW";
        document.all.wr_2[1].value = "m2";
        document.all.wr_2[1].text  = "사운드SW";
        document.all.wr_2[2].value = "m3";
        document.all.wr_2[2].text  = "그래픽SW";
        document.all.wr_2[3].value = "m4";
        document.all.wr_2[3].text  = "코덱,플레이어";
        document.all.wr_2[4].value = "m5";
        document.all.wr_2[4].text  = "CD,DVD";
    }
    if (aa == "game")  {
        document.all.wr_2.length   = 8;
        document.all.wr_2[0].value = "g1";
        document.all.wr_2[0].text  = "액션,슈팅,FPS";
        document.all.wr_2[1].value = "g2";
        document.all.wr_2[1].text  = "스포츠,레이싱";
        document.all.wr_2[2].value = "g3";
        document.all.wr_2[2].text  = "어드벤쳐,RPG";
        document.all.wr_2[3].value = "g4";
        document.all.wr_2[3].text  = "전략,시물,아케이드";
        document.all.wr_2[4].value = "g5";
        document.all.wr_2[4].text  = "패치,업데이트";
        document.all.wr_2[5].value = "g6";
        document.all.wr_2[5].text  = "세이브,에디트";
        document.all.wr_2[6].value = "g7";
        document.all.wr_2[6].text  = "에뮬게임";
        document.all.wr_2[7].value = "g8";
        document.all.wr_2[7].text  = "온라인게임";
    }
    if (aa == "internet")  {
        document.all.wr_2.length   = 5;
        document.all.wr_2[0].value = "i1";
        document.all.wr_2[0].text  = "브라우져,RSS";
        document.all.wr_2[1].value = "i2";
        document.all.wr_2[1].text  = "P@P.FTP";
        document.all.wr_2[2].value = "i3";
        document.all.wr_2[2].text  = "웹제작";
        document.all.wr_2[3].value = "i4";
        document.all.wr_2[3].text  = "메신저,메일";
        document.all.wr_2[4].value = "i5";
        document.all.wr_2[4].text  = "악성코드,보안";
    }
    if (aa == "device")  {
        document.all.wr_2.length   = 6;
        document.all.wr_2[0].value = "m1";
        document.all.wr_2[0].text  = "그래픽카드";
        document.all.wr_2[1].value = "m2";
        document.all.wr_2[1].text  = "사운드카드";
        document.all.wr_2[2].value = "m3";
        document.all.wr_2[2].text  = "네트워크,렌카드";
        document.all.wr_2[3].value = "m4";
        document.all.wr_2[3].text  = "프린터,스캐너";
        document.all.wr_2[4].value = "m5";
        document.all.wr_2[4].text  = "메인보드";
        document.all.wr_2[5].value = "m6";
        document.all.wr_2[5].text  = "기타장치";
    }
    if (aa == "etc")  {
        document.all.wr_2.length   = 5;
        document.all.wr_2[0].value = "e1";
        document.all.wr_2[0].text  = "윈도우테마,스킨";
        document.all.wr_2[1].value = "e2";
        document.all.wr_2[1].text  = "화면보호기";
        document.all.wr_2[2].value = "e3";
        document.all.wr_2[2].text  = "액세서리";
        document.all.wr_2[3].value = "e4";
        document.all.wr_2[3].text  = "오픈소스";
        document.all.wr_2[4].value = "e5";
        document.all.wr_2[4].text  = "기타";
    }
}
 
//-->
</SCRIPT>
 
- html부분 -
<tr>
    <td class=write_head>카테고리</td>
    <td>
        <select name="wr_1" id="wr_1" required itemname="대분류" ONCHANGE='smallChange(this.value);'>
        <option value="util" SELECTED>유틸리티</option>
        <option value="multi">멀티미디어</option>
        <option value="game">게임</option>
        <option value="internet">인터넷</option>
        <option value="device">드라이버</option>
        <option value="etc">데스크탑/기타</option>
        </select>&nbsp;&nbsp;
        <select name="wr_2" id="wr_2" required itemname="소분류">
        <option value="u1" SELECTED>일반유틸리티</option>
        <option value="u2">백신, 보안</option>
        <option value="u3">개인, 교육</option>
        <option value="u4">업무</option>
        <option value="u5">시스템, 최적화</option>
        <option value="u6">윈도우패치</option>
        </select>
    </td>
</tr>
[출처] 대분류에 의한 동적 셀렉트(대분류가 고정인 경우) 예|작성자 파인
https://blog.naver.com/ad70770/221711357676


</body>
</html>