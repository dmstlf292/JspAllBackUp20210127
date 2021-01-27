<!-- member.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");
	String id = (String) session.getAttribute("idKey");
%>
<!-- 중요!!여기 안하면 검색버튼 눌러도 아무 반응이 없다!! -->
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
function idCheck(id) {
	if(id==""){
		alert("아이디를 입력하세요.");
		document.regFrm.id.focus();
		return;//이후에 코드를 실행이 안됨. 함수를 빠져나감.
	}
	url = "idCheck.jsp?id="+id;
	window.open(url,"ID중복체크","width=300,height=150");
}

function zipSearch() {
	url = "zipSearch.jsp?search=n";
	window.open(url,"우표번호검색",
			"width=500,height=350,scrollbars=yes");
}
</script>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Join Page</title>

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
			<div align="center">
				<br />
				<br />
				<%
					if (id != null) {
				%>
				<b><%=id%></b> welcome!<br /> Limited functions are available.<br />
				<a href="logout.jsp">logout</a>&nbsp; <a href="memberUpdate.jsp">Member
					Modification</a>
				<%
					} else {
				id = request.getParameter("id");
				%>
			</div>


			<form class="login100-form validate-form" name="regFrm" method="post" action="memberProc.jsp">
				<!-- 여기서  method="post"? 란? -->
				<span class="login100-form-title p-b-37"> Sign up </span>

				<table>
					<div class="wrap-input100 validate-input m-b-20"
						data-validate="Enter id">
						<input class="input100" type="text" name="id" placeholder="id">
						<!-- 여기 username을 id로 바꿈 -->
						<span class="focus-input100"></span>
					</div>
				</table>
				
				<tr>
					<td><input type="button" value="id check" class="text-center" onClick="idCheck(this.form.id.value)"></td>
				</tr>
				
				<div class="wrap-input100 validate-input m-b-25"
					data-validate="Enter password">
					<input class="input100" type="password" name="pwd" size="15"
						placeholder="password">
					<!-- 여기 pass 를 pwd로 바꿈 -->
					<span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-30"
					data-validate="Enter repassword">
					<input class="input100" type="password" name="repwd" size="15"
						placeholder="repassword"> <span class="focus-input100"></span>
				</div>

 				<div class="wrap-input100 validate-input m-b-35"
					data-validate="Enter name">
					<input class="input100" type="text" name="name" size="20"
						placeholder="name"> <span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-40"
					data-validate="Select gender">
					Male<input type="radio" name="gender" value="1" checked>
					Female<input type="radio" name="gender" value="2"> <span
						class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-45"
					data-validate="Enter birthday">
					<input class="input100" type="text" name="birthday"
						placeholder="Enter birthday (ex: 941122)"> <span
						class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-50"
					data-validate="Enter email">
					<input class="input100" type="text" name="email" size="30"
						placeholder="email"> <span class="focus-input100"></span>
				</div>

			

				<div class="text-center">
					<a href="#" class="txt3 hov2" onClick="zipSearch()">
						 Search post code
					</a>
				</div>


				<div class="wrap-input100 validate-input m-b-60"
					data-validate="Enter postcode">
					<input name="zipcode" size="5" readonly >
					
					<span class="focus-input100"></span>
				</div> 



				<div class="wrap-input100 validate-input m-b-65"
					data-validate="Enter address">
					<input class="input100" type="text" name="address" size="45"
						placeholder="address"> <span class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-70"
					data-validate="Select route">
					Facebook<input type="checkbox" name="hobby" value="인터넷">
					Instagram<input type="checkbox" name="hobby" value="인터넷">
					Twitter<input type="checkbox" name="hobby" value="인터넷">
					Google<input type="checkbox" name="hobby" value="인터넷">
					Youtube<input type="checkbox" name="hobby" value="인터넷"> <span
						class="focus-input100"></span>
				</div>

				<div class="wrap-input100 validate-input m-b-75"
					data-validate="Select job">
					<select name=job>
						<option value="0" selected>Choose One.
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
				</div>  

				<div class="container-login100-form-btn">
					<button class="login100-form-btn" onclick="inputCheck()">Sign Up</button>
				</div>

				<div class="text-center p-t-57 p-b-20">
					<span class="txt1"> Or Sign up with </span>
				</div>

				<div class="flex-c p-b-112">
					<a href="#" class="login100-social-item"> <i
						class="fa fa-facebook-f"></i>
					</a> <a href="#" class="login100-social-item"> <img
						src="images/icons/icon-google.png" alt="GOOGLE">
					</a>
				</div>

				<div class="text-center">
					<a href="#" class="txt2 hov1" onClick="javascript:location.href='login.jsp'"> Sign In </a>
				</div>
			</form>
			<%
				}
			%>

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