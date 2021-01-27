<%@page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="member.MemberMgr"/>
<jsp:useBean id="bean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="bean" />
<%
		boolean result = mgr.insertMember(bean);
		String msg = "가입실패";
		String url = "member.jsp";
		if(result){
			msg = "가입성공";
			url = "login.jsp";
			//가입성공과 동시에 로그인 처리를 위한 기능
			session.setAttribute("idKey", bean.getId());
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>











