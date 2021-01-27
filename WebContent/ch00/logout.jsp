<!-- logout.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%
		session.invalidate();
%>
<script>
	alert("You are logged out.");
	location.href="login.jsp";
</script>