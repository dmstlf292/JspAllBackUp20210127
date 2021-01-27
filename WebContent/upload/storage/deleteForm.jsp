<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE>
<html>
<head>
    <title>회원탈퇴</title>
</head>

<body onload="begin()">
    <h1>회원탈퇴 페이지</h1>
    <h2>deleteForm.jsp</h2>
    <form name="deleteForm" action="memberDelete.jsp" method="post" onSubmit="return checkIt()">
        <TABLE cellSpacing=1 cellPadding=1 width="260" border=1 align="center" >
        <TR height="30">
            <TD colspan="2" align="middle">
                <font size="+1" ><b>회원 탈퇴</b></font>
            </TD>
        </TR>
       
        <TR height="30">
            <TD width="110" align=center>비밀번호</TD>
            <TD width="150" align=center>
                <INPUT type=password name="pw"  size="15" maxlength="12">
            </TD>
        </TR>
       
        <TR height="30">
            <TD colspan="2" align="middle">
                <INPUT type="submit" value="탈퇴" onclick="javascript:window.location='memberDelete.jsp'">
                <input type="button" value="취소" onclick="javascript:window.location='login.jsp'">
            </TD>
        </TR>
        </TABLE>
    </form>
</body>

<script language="javascript">
  <!--
    function begin(){
      document.deleteform.pw.focus();
    }

    function checkIt(){
 if(!document.deleteform.pw.value){
        alert("비밀번호를 입력하지 않으셨습니다.");
        document.deleteform.pw.focus();
        return false;
      }
 }  
  -->
</script>
</html>