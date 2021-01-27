<%@page import="java.util.Random"%>
<%@page import="poll.PollItemBean"%>
<%@page import="java.util.Vector"%>
<%@page import="poll.PollListBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="poll.PollMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int listNum=Integer.parseInt(request.getParameter("num"));
		//어떤 설문에 대한 값이다.
		PollListBean plBean = mgr.getPoll(listNum);
		//벡타로 제네릭을 가져왔기 때문에..밑에 코드는 결과보기 버튼 눌려서 창이 띄어졌을때 설문조사의 question 문구 가져오는 코드
		Vector<PollItemBean> vlist = mgr.getView(listNum);
		//현재 설문에 sum 투표수
		int sumCnt= mgr.sumCount(listNum);
		//현재 설문에 가장 높은 투표수
		int maxCnt = mgr.getMaxCount(listNum);
%>
<html>
<head>
<title>JSP Poll</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center"><br/>
<h2>투표 결과</h2>
<table border="1" width="400">
	<tr>
		<!-- td가 총 4개 -->
		<td colspan="4"><b>Q : <%=plBean.getQuestion()%></b></td>
	</tr>
	<tr>
		<td colspan="3"><b>총 투표자 :  <%=sumCnt%> 명</b></td>
		<td width="40"><b>count(%)</b></td>
	</tr>
	<!-- 벡타 돌려야해서 form 들어가야함 -->
	<%
		Random r =new Random();
		for(int i =0; i<vlist.size();i++){
			PollItemBean piBean = vlist.get(i);
			String item[]=piBean.getItem();
			//득표수
			int count = piBean.getCount();
			//비율 만들기 = (총투표수/투표수)
			int ratio = (int)(Math.round((double)count/sumCnt*100));
			//랜덤한 색상
			String rgb="#"+Integer.toHexString(r.nextInt(255*255*255));
	%>		
	<!-- td가 총 4개!! -->
	<tr>
		<td width="20" align="center"><%=i+1%></td>
		<td width="120">
			<!-- 고득표에 하이라이트 기능 넣기 -->
			<%if(maxCnt==count){%><font color="red"><b><%}%>
			   <%=item[0]%>
			<%if(maxCnt==count){%></b></font><%}%>
		</td>
		<td>
			<table width="<%=ratio%>"height="15">
			<tr><td bgcolor="<%=rgb%>"></td></tr>
			</table>
		</td>
		<td width="40"><%=count%>(<%=ratio %>)</td>
	</tr>
	<%}//--for%>
</table><br>
<a href="javascript:window.close()">닫기</a>
</div>
</body>
</html>











