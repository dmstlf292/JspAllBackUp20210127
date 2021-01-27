<!-- memberDeleteProc.jsp -->
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
	String id=(String)session.getAttribute("idKey");
	boolean result=mgr.deleteMember(id);
	if(result){
		/* session.invalidate(); */
%>
	<script>
			alert("Ε»Επ ΌΊ°ψ");
			location.href = "login.jsp";
	</script>
<%}else{%>
		<script>
			alert("Ε»Επ ½ΗΖΠ");
			history.back();
		</script>
<%}%>
