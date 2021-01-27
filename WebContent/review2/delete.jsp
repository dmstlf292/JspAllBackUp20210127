<!-- delete.jsp -->
<%@page import="review2.BoardBean"%>
<%@page import="review2.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="review2.BoardMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String nowPage = request.getParameter("nowPage");
		int tnum = UtilMgr.parseInt(request, "tnum");
		//비번을 입력을 받아서 삭제를 처리하는 기능
		if(request.getParameter("tpass")!=null){
			BoardBean bean = (BoardBean)session.getAttribute("bean");
			//delete.jsp에서 사용자가 입력한 비번
			String inPass = request.getParameter("tpass");
			//db에 저장된 비번
			String dbPass = bean.getTpass();
			if(inPass.equals(dbPass)){//==는 객체의 주소값 비교.
				mgr.deleteBoard(tnum, bean.getTfilename());
				//원 게시물이 삭제되면 관t려된 댓글 모두 삭제

				String url = "list.jsp?nowPage="+nowPage;
				response.sendRedirect(url);
			}else{%>
			<script type="text/javascript">
				alert("입력하신 비밀번호가 아닙니다.");
				history.back();
			</script>
			<%}
		}else{//비번을 입력 받기 위한 폼(form) 출력
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
													<input type="button" value="삭제완료" onClick="check()"> 
													<input type="reset" value="다시쓰기">
													<input type="button" value="뒤로" onClick="history.go(-1)">
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
							<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
							<input type="hidden" name="tnum" value="<%=tnum%>">
						</form><!-- FORM 끝 -->
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