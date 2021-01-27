<!-- flist.jsp -->
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Base64.Encoder"%>
<%@page import="upload.UtilMgr"%>
<%@page import="upload.FileloadBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="upload.FileloadMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		Vector<FileloadBean> vlist = mgr.listFile();
		//out.print(vlist.size());
%>
<!doctype html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
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
</head>
<body>
<div align="center">
<h2>File List</h2>
<form name="frm" action="fdeleteProc.jsp">
<input type="hidden" name="fch" value="0">
<table border="1" width="300">
	<tr align="center">
		<td><input type="checkbox" name="allCh" onclick="allChk()"></td>
		<td width="30">번호</td>
		<td>파일명</td>
		<td>파일크기</td>
	</tr>
	<%
			for(int i=0;i<vlist.size();i++){
				FileloadBean bean = vlist.get(i);
				int num = bean.getNum();
				String upFile = bean.getUpFile();
				int size = bean.getSize();
	%>
	<tr align="center"> 
		<td><input type="checkbox" value="<%=num%>" name="fch" onclick="chk()"></td>
		<td><%=i+1%></td>
		<td>
			<a href="storage/<%=URLEncoder.encode(upFile)%>" download><%=upFile%></a>
			<%-- <a href="javascript:down('<%=upFile%>')"><%=upFile%></a> --%>
		</td>
		<td><%=UtilMgr.monFormat(size)%>byte</td>
	</tr>
	<%}//---for%>
	<tr>
		<td colspan="4">
			<input type="submit" name="btn" value="DELETE" disabled>
		</td>
	</tr>
</table>
</form><p>
<a href="fupload.jsp">입력폼</a>
<form name="downFrm" method="post" action="fdownload.jsp">
	<input type="hidden" name="upFile">
</form>
</div>
</body>
</html>





