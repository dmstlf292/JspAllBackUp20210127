<!-- pollFormProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="poll.PollMgr"/>
<%
	int listNum=Integer.parseInt(request.getParameter("num"));
	String itemNum[] = request.getParameterValues("itemnum");
	boolean result = mgr.updatePoll(listNum, itemNum);
	String msg="투표에 실패 하였습니다.";
	if(result) msg="투표를 하였습니다.";
%>
<script>
	alert("<%=msg%>");
	loction.href="pollList.jsp?num=<%=listNum%>";
</script>