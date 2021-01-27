<!-- read.jsp -->
<%@page import="java.net.URLEncoder"%>
<%@page import="review2.BoardBean"%>
<%@page import="review2.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="review2.BoardMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");	
		int tnum = UtilMgr.parseInt(request, "tnum");
		
		//��ȸ�� ����
		mgr.upCount(tnum);
		//�Խù� �б�
		BoardBean bean = mgr.getBoard(tnum);
		String tname = bean.getTname();
		String tsubject = bean.getTsubject();
		String tregdate = bean.getTregdate();
		String tcontent = bean.getTcontent();
		String tfilename = bean.getTfilename();
		int tfilesize = bean.getTfilesize();
		String tip = bean.getTip();
		int tcount = bean.getTcount();
		session.setAttribute("bean", bean);
%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<title>�Խñ� �б�</title>
<script>
	function down(tfilename){//a href="javascript:down
		document.downFrm.tfilename.value=tfilename;
		document.downFrm.submit();
	}
	function list(){// <a href="javascript:list()" >����Ʈ</a>
		document.listFrm.action="list.jsp";
		document.listFrm.submit();
	}
	
</script>
	<meta charset="UTF-8">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta name="author" content="">
	<link rel="profile" href="#">

    <!--Google Font-->
    <link rel="stylesheet" href='http://fonts.googleapis.com/css?family=Dosis:400,700,500|Nunito:300,400,600' />
	<!-- Mobile specific meta -->
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="format-detection" content="telephone-no">

	<!-- CSS files -->
	<link rel="stylesheet" href="css/plugins.css">
	<link rel="stylesheet" href="css/style.css">
</head>

<body>
<div class="page-single" >
	<div class="container">
		<div class="row">
			<div class="col-md-9 col-sm-12 col-xs-12">
				<div class="blog-detail-ct">
					<div class="comments">
						<<h4>�Խñ� �б�</h4> 
					</div>
					<div class="comment-form">
						<table align="center" width="600" cellspacing="3">
							
							 <tr>
							  <td colspan="2">
							   <table cellpadding="3" cellspacing="0" width="100%"> 
							    <tr> 
							  <td align="center" width="10%"> Name </td>
							  <td ><%=tname %></td>
							  <td align="center" width="10%"> Date </td>
							  <td ><%=tregdate %></td>
							 </tr>
							 <tr> 
							    <td align="center" > Title </td>
							    <td  colspan="3"><%=tsubject %></td>
							   </tr>
							   <tr> 
							     <td align="center" >File</td>
							     <td  colspan="3">
							    	<%if(tfilename!=null && !tfilename.equals("")){%>
							    		<a href="javascript:down('<%=tfilename%>')"><%=tfilename %></a>
							    		<font color="blue">(<%=UtilMgr.intFormat(tfilesize)%>bytes)</font>
							    	<%}else{out.println("No attachments found.");} %>
							     </td>
							   </tr>
							   <tr> 
							    <td colspan="4"><br/><pre><%=tcontent%></pre><br/></td>
							   </tr>
							   <tr>
							    <td colspan="4" align="right">
							  	<%=tip%>left a post from / view <%=tcount%>
							    </td>
							   </tr>
							   </table>
							  </td>
							 </tr>
							 <tr>
							  <td align="center" colspan="2">
							  <!-- ��� �Է��� Start -->
							  
							  <!-- ��� �Է��� End -->
							 <hr/>
							 <!-- ��� List Start -->
							
							 <!-- ��� List End -->
							 
							 [ <a href="javascript:list()" >list</a> | 
							 <a href="update.jsp?nowPage=<%=nowPage%>&tnum=<%=tnum%>&numPerPage=<%=numPerPage%>">modify</a> |
							 <a href="reply.jsp?nowPage=<%=nowPage%>&numPerPage=<%=numPerPage%>" >reply</a> |
							 <a href="delete.jsp?nowPage=<%=nowPage%>&tnum=<%=tnum%>">delete</a> ]<br/> 
							
							  </td>
							 </tr>
							</table>
							<form method="post" name="downFrm" action="download.jsp">
								<input type="hidden" name="tfilename">
							</form>
							<form name="listFrm">
								<input type="hidden" name ="nowPage" value="<%=nowPage%>">
								<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
								<%if(!(keyWord==null||keyWord.equals(""))){%>
							 	<input type="hidden" name="keyField" value="<%=keyField%>">
								<input type="hidden" name="keyWord" value="<%=keyWord%>">
								<%} %>
								
							</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="js/jquery.js"></script>
<script src="js/plugins.js"></script>
<script src="js/plugins2.js"></script>
<script src="js/custom.js"></script>
</body>
</html>