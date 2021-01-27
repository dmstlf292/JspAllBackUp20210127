<!-- post.jsp --> 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@page pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<title>�۾���</title>
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
						<!-- <h4>04 Comments</h4> -->
					</div>
					<div class="comment-form">
						<h4>�۾���</h4>
						<form name="postFrm" method="post" action="tboardPost"  enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-4">
									<input placeholder="����" name="tname" size="10" maxlength="8">
								</div>
								<div class="col-md-4">
									<input placeholder="����" name="tsubject" size="50" maxlength="30">
								</div>
								<div class="col-md-4">
									<input type="password" name="tpass" placeholder="��й�ȣ"  size="15" maxlength="15" value="1234">
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<textarea  name="tcontent" rows="10" cols="50" placeholder="����"></textarea>
								</div>
							</div>
							<div >
								 <tr>
     								<td><input type="file" name="tfilename" size="50" maxlength="50"></td>
    							</tr>
							</div>
							<div >
								 <tr>
									<td> HTML<input type=radio name="tcontentType" value="HTTP" >&nbsp;&nbsp;&nbsp;
  			 							TEXT<input type=radio name="tcontentType" value="TEXT" checked>
  			 						</td>
  			 					 </tr>
  			 					
  			 					
							</div>
						
							<input type="submit" value="���">
						    <input type="reset" value="�ٽþ���">
							<input type="button" value="����Ʈ" onclick="javascript:location.href='list.jsp'">
							<input type="hidden" name="tip" value="<%=request.getRemoteAddr()%>">
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
</body>
</html>