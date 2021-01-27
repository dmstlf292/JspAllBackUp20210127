<!-- delete.jsp -->
<%@page import="review2.BoardBean"%>
<%@page import="review2.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="review2.BoardMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String nowPage = request.getParameter("nowPage");
		int tnum = UtilMgr.parseInt(request, "tnum");
		//����� �Է��� �޾Ƽ� ������ ó���ϴ� ���
		if(request.getParameter("tpass")!=null){
			BoardBean bean = (BoardBean)session.getAttribute("bean");
			//delete.jsp���� ����ڰ� �Է��� ���
			String inPass = request.getParameter("tpass");
			//db�� ����� ���
			String dbPass = bean.getTpass();
			if(inPass.equals(dbPass)){//==�� ��ü�� �ּҰ� ��.
				mgr.deleteBoard(tnum, bean.getTfilename());
				//�� �Խù��� �����Ǹ� ��t���� ��� ��� ����

				String url = "list.jsp?nowPage="+nowPage;
				response.sendRedirect(url);
			}else{%>
			<script type="text/javascript">
				alert("�Է��Ͻ� ��й�ȣ�� �ƴմϴ�.");
				history.back();
			</script>
			<%}
		}else{//����� �Է� �ޱ� ���� ��(form) ���
%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<title>Delete</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function check() {
		if (document.delFrm.tpass.value == "") {
			alert("Please enter your password.");
			document.delFrm.pass.focus();
			return;
		}
		document.delFrm.submit();
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
						
					</div>
					<div class="comment-form">
						<h4>Delete</h4>
						<form name="delFrm" method="post">
							<table width="70%" cellspacing="0" cellpadding="2">
								<tr>
									<td align="center">
										<table width=80%>
											<tr>
												<td align="center">
													<input type="password" name="tpass" size="17" maxlength="15">
												</td>
											</tr>
											<tr>
												<td><hr size="1" color="#eeeeee"/></td>
											</tr>
											<tr>
												<td align="center">
													<input type="button" value="�����Ϸ�" onClick="check()"> 
													<input type="reset" value="�ٽþ���">
													<input type="button" value="�ڷ�" onClick="history.go(-1)">
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
							<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
							<input type="hidden" name="tnum" value="<%=tnum%>">
						</form><!-- FORM �� -->
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
<%}%>
</body>
</html>