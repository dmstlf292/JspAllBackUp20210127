<!-- loginProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="member.MemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String cPath=request.getContextPath();//¿ªÇÒ?
		String id=request.getParameter("id");
		String pass=request.getParameter("pwd");
		String msg="Login failed.";
		boolean result = mgr.loginMember(id,pass);
		if(result){
			session.setAttribute("idKey", id);
			msg="You have successfully logged in.";
		}
%>
<script>
	alert("<%=msg%>");
	location.href="login.jsp";
</script>