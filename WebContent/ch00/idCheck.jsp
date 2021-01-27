<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="ch00.MemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id=request.getParameter("id");
		boolean result=mgr.checkId(id);
%>
<!doctype html>
<html>
<head>
<title>ID 중복체크</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<br/><b><%=id%></b>
<%
		if(result){
			out.println("Is an ID that already exists.<p/>");
		}else{
			out.println("Can be used.<p/>");
		}
%>
<a href="#" onclick="self.close()">close</a>
</div>
</body>
</html>
