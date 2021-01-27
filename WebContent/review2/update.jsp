<%@ page contentType="text/html; charset=EUC-KR" %>
 <%@ page import="review2.BoardBean"%>
<% 
	  int tnum = Integer.parseInt(request.getParameter("tnum"));
	  String nowPage = request.getParameter("nowPage");
	  String numPerPage = request.getParameter("numPerPage");
	  BoardBean bean = (BoardBean)session.getAttribute("bean");
	  String tsubject = bean.getTsubject();
	  String tname = bean.getTname(); 
	  String tcontent = bean.getTcontent();
	  //read.jsp에서 session에 빈즈 단위로 저장 했기 때문에 파일명도 가져 올 수 있다.
	  String tfilename = bean.getTfilename();
%>
<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check() {
	   if (document.updateFrm.tpass.value == "") {
		 alert("Please enter your password to edit.");
		 document.updateFrm.tpass.focus();
		 return false;
		 }
	   document.updateFrm.submit();
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
						<<h4>Editing a post</h4> 
					</div>
					<div class="comment-form">
					 <form name="updateFrm" method="post" action="tboardUpdate" enctype="multipart/form-data">
						<div class="row">
								<div class="col-md-4">
									  <input name="tname" value="<%=tname%>" size="30" maxlength="20">
								</div>
								<div class="col-md-4">
									  <input name="tsubject" size="50" value="<%=tsubject%>" maxlength="50">
								</div>
								<div class="col-md-4">
									 <td>
									 	<input type="password" name="tpass" size="15" maxlength="15">
    								 </td>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<textarea name="tcontent" rows="10" cols="50"><%=tcontent%></textarea>
								</div>
							</div>
							<div >
								 <tr>
									<td>
     									<%=tfilename!=null?tfilename:"No attachments found."%>
     									<input type="file" name="tfilename" size="50" maxlength="50">
    								 </td>
  			 					 </tr>
							</div>
							<input type="button" value="Completed" onClick="check()">
						    <input type="reset" value="Reedit"> 
						    <input type="button" value="Back" onClick="history.go(-1)">
							<input type="hidden" name="nowPage" value="<%=nowPage %>">
							<input type='hidden' name="tnum" value="<%=tnum%>">
							<input type='hidden' name="numPerPage" value="<%=numPerPage%>">
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

