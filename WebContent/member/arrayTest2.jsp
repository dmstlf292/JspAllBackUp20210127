<!-- arrayTest2.jsp -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		//form에 두개 이상의 동일한 name으로 요청되면 자동 배열처리
		String hobby[] = request.getParameterValues("hobby");
		for(int i=0;i<hobby.length;i++){
			out.print(hobby[i]+"<br>");
		}
%><p>
<jsp:useBean id="bean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
		String hobby2[] = bean.getHobby();
		for(int i=0;i<hobby2.length;i++){
			out.print(hobby2[i]+"<br>");
		}
%>







