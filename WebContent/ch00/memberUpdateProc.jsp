<!-- memberUpdateProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="member.MemberMgr"/>
<jsp:useBean id="bean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	boolean result=mgr.updateMember(bean);
	if(result){
%>		
	<script>
		alert("Member information has been modified.");
		location.href="login.jsp";
	</script>

<%}else{%>
	<script>
		alert("Failed to modify member information.");
		history.back();
	</script>
<%}%>