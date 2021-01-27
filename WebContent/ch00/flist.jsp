<!-- flist.jsp -->
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Base64.Encoder"%>
<%@page import="upload.UtilMgr"%>
<%@page import="upload.FileloadBean"%>
<%@page import="java.util.Vector"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="upload.FileloadMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		Vector<FileloadBean> vlist=mgr.listFile();
		//out.print(vlist.size());
%>
<!DOCTYPE html>
<html lang="en">
<head>
<script>
function allChk() {
	f=document.frm;//form을 f로 치환
	if(f.allCh.checked/*체크상태*/){
		for(i=1;i<f.fch.length;i++){
			f.fch[i].checked=true;
		}
		f.btn.disabled=false;//버튼의 활성화
		f.btn.style.color = "blue";
	}else{
		for(i=1;i<f.fch.length;i++){
			f.fch[i].checked=false;
		}
		f.btn.disabled=true;//버튼의 비활성화
		f.btn.style.color = "gray";
	}
}

function chk() {
	f=document.frm;
	for(i=1;i<f.fch.length;i++){
		if(f.fch[i].checked){//fch 체크박스가 체크인 경우
			f.btn.disabled=false;//버튼의 활성화
			f.btn.style.color = "blue";
			return;
		}//if
	}//for
	f.allCh.checked=false;
	f.btn.disabled=true;
	f.btn.style.color = "gray";
}
function down(file) {
	//alert(file);
	document.downFrm.upFile.value=file;
	document.downFrm.submit();
}
</script>
	<title>File List</title>
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>
	<div class="container-login100" style="background-image: url('images/bg-01.jpg');">
		<div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
		 <div align="center">
			<h2>File List</h2><br/>
			<form class="login100-form validate-form" name="frm" action="fdeleteProc.jsp">
			<input type="hidden" name="fch" value="0">
			<table border="1" width="300">
				<tr align="center">
					<td><input type="checkbox" name="allCh" onclick="allChk()"></td>
					<td width="50">num</td>
					<td>F name</td>
					<td>F size</td>
				</tr>
				<%
					for(int i=0; i<vlist.size();i++){
						FileloadBean bean = vlist.get(i);
						int num=bean.getNum();
						String upFile= bean.getUpFile();
						int size=bean.getSize();
				%>	
				<tr align="center"> 
					<td><input type="checkbox" value="<%=num%>" name="fch" onclick="chk()"></td>
					<td><%=i+1%></td>
					<td>
						<a href="storage/<%=URLEncoder.encode(upFile)%>" download><%=upFile%></a>
						<%-- <a href="javascript:down('<%=upFile%>')"><%=upFile%></a> --%>
					</td>
					<td><%=UtilMgr.monFormat(size) %>byte</td>
				</tr>
				<%}//---for%>
				<tr>
					<td colspan="4">
						<input type="submit" name="btn" value="DELETE" disabled>
					</td>
				</tr>
			</table>
			</form><br/>
			<a href="fupload.jsp">Input form</a>
			<form name="downFrm" method="post" action="fdownload.jsp">
				<input type="hidden" name="upFile">
			</form>
			</div> 	
		</div>
	</div>
	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
</body>
</html>