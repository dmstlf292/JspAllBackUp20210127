<!-- memberUpdate.jsp -->
<%@page import="member.MemberBean"%>
<%@page import="member.MemberMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="member.MemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String) session.getAttribute("idKey");
		if(id==null){
			response.sendRedirect("login.jsp");
			return;
		}
		MemberBean bean = mgr.getMember(id);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Member Update Page</title>
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
	function zipCheck(){
		url="zipSearch.jsp?search=n";
		window.open(url,"ZipCodeSearch","width=500, height=300,scrollbars=yes");
	}
</script>
<!--===============================================================================================-->
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="css/util2.css">
<link rel="stylesheet" type="text/css" href="css/main2.css">
<!--===============================================================================================-->
</head>
<body onLoad="regFrm.id.focus()">
	<div class="container-login100"
		style="background-image: url('images/bg-01.jpg');">
		<div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
			<form class="login100-form validate-form" name="regFrm" method="post" action="memberUpdateProc.jsp">
				<span class="login100-form-title p-b-37"> Member Update </span>

				<table>
					<div class="wrap-input100 validate-input m-b-20"
						data-validate="Enter id">
						<input class="input100" type="text" name="id" placeholder="id" value="<%=bean.getId()%>" readonly>
						<!-- 여기 username을 id로 바꿈 -->
						<span class="focus-input100"></span>
					</div>
				</table>

				<div class="wrap-input100 validate-input m-b-25"
					data-validate="Enter password">
					<input class="input100" type="password" name="pwd" size="15" value="<%=bean.getPwd() %>"
						placeholder="password">
					<!-- 여기 pass 를 pwd로 바꿈 -->
					<span class="focus-input100"></span>
				</div>

 				<div class="wrap-input100 validate-input m-b-35"
					data-validate="Enter name">
					<input class="input100" type="text" name="name" size="20" value="<%=bean.getName() %>"
						placeholder="name"> <span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-40"
					data-validate="Select gender">
					Male<input type="radio" name="gender" value="1" <%if(bean.getGender().equals("1")) out.println("checked"); %>>
					Female<input type="radio" name="gender" value="2"<%if(bean.getGender().equals("2")) out.println("checked"); %>> <span
						class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-45"
					data-validate="Enter birthday">
					<input class="input100" type="text" name="birthday" size="6" value="<%=bean.getBirthday() %>"
						placeholder="Enter birthday (ex: 941122)"> <span
						class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-50"
					data-validate="Enter email">
					<input class="input100" type="text" name="email" size="30" value="<%=bean.getEmail() %>"
						placeholder="email"> <span class="focus-input100"></span>
				</div>

			

				<div class="text-center">
					<a href="#" class="txt3 hov2" onClick="zipCheck()" >
						 Search post code
					</a>
				</div>


				<div class="wrap-input100 validate-input m-b-60"
					data-validate="Enter postcode">
					<input name="zipcode" size="5" value="<%=bean.getZipcode()%>" readonly >
					
					<span class="focus-input100"></span>
				</div> 



				<div class="wrap-input100 validate-input m-b-65"
					data-validate="Enter address">
					<input class="input100" type="text" name="address" size="45" value="<%=bean.getAddress() %>"
						placeholder="address"> <span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-70"
					data-validate="Select route">
					<%
						String list[]={"Facebook","Instagram","Twitter", "Google","Youtube"};
						String hb[]=bean.getHobby();
						for(int i=0; i<hb.length;i++){
					%>	
					<%=list[i] %>	
					<input type="checkbox" name="hobby" value="<%=list[i]%>" <%=hb[i].equals("1")?"checked":"" %>>
					<%}%>
					 <span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-75"
					data-validate="Select job">
					<select name=job>
						<option value="0">Choose One.
						<option value="employee">employee
						<option value="Research profession">Research profession
						<option value="Professor student">Professor student
						<option value="General self-employment">General
							self-employment
						<option value="Official">Official
						<option value="Medical personnel">Medical personnel
						<option value="Legal man">Legal man
						<option value="Religion/Press/Artist">Religion/Press/Artist
						
						<option value="Farm/Livestock/Fisheries/Miners">Farm/Livestock/Fisheries/Miners
						
						<option value="housewife">housewife
						<option value="inoccupation">inoccupation
						<option value="Etc">Etc
					</select> <span class="focus-input100"></span>
					<script>
						document.regFrm.job.value="<%=bean.getJob()%>";
					</script>
				</div>  
				<div class="container-login100-form-btn">
					<button class="login100-form-btn" onclick="inputCheck()">Submit</button>
				</div>
				<br/>
				<div class="text-center">
					<a href="#" class="txt2 hov1" onClick="javascript:location.href='login.jsp'"> Sign In </a>
				</div>
			</form>
		</div>
	</div>



	<div id="dropDownSelect1"></div>

	<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>