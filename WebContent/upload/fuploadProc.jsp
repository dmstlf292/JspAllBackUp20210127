<!-- fuploadProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="upload.FileloadMgr"/><!-- 여기 먼저 만들기,먼저 필요한 mgr 만들어야함-->
<%
		request.setCharacterEncoding("EUC-KR");
		String flag= request.getParameter("flag");
		mgr.uploadFile(request);
		response.sendRedirect("flist.jsp");
%>