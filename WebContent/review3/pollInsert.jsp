<%@ page  contentType="text/html; charset=EUC-KR"%>
<!doctype html>
<html lang="en" dir="ltr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="icon" href="favicon.ico" type="image/x-icon"/>
<title>JSP Poll</title>
<script type="text/javascript">
	function send() {//<input type="button" value="작성하기" onclick="send()">
		f = document.frm;
		f.tsdate.value = f.tsdateY.value+"-"
		+ f.tsdateM.value+"-"+f.tsdateD.value;
		f.tedate.value = f.tedateY.value+"-"
		+ f.tedateM.value+"-"+f.tedateD.value;
		f.submit();
	}
</script>
<!-- Bootstrap Core and vandor -->
<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css">

<!-- Core css -->
<link rel="stylesheet" href="assets/css/main.css"/>
<link rel="stylesheet" href="assets/css/theme1.css"/>
</head>

<body class="font-montserrat">
<!-- Page Loader -->
<div class="page-loader-wrapper">
    <div class="loader">
    </div>
</div>
<div id="main_content">
    <div id="left-sidebar" class="sidebar ">
        <h5 class="brand-name">Selene <a href="javascript:void(0)" class="menu_option float-right"><i class="icon-grid font-16" data-toggle="tooltip" data-placement="left" title="Grid & List Toggle"></i></a></h5>
        <nav id="left-sidebar-nav" class="sidebar-nav">
            <ul class="metismenu">
               <!--  <li class="active"><a href="project-ticket.html"><i class="fa fa-list-ul"></i><span>Your Survey</span></a></li> -->
              
               <li class="active"><a onClick="javascript:location.href='pollInsert.jsp'"><i class="fa fa-dashboard" ></i><span>투표만들기</span></a></li>                        
                <li><a onClick="javascript:location.href='pollList.jsp'"><i class="fa fa-list-ol"></i><span>투표리스트</span></a></li>
                <li><a onClick="javascript:location.href='pollViewMore.jsp'"><i class="fa fa-calendar-check-o"></i><span>투표결과모아보기</span></a></li>
            </ul>
        </nav>        
    </div>

    <div class="page">
        <div id="page_top" class="section-body top_dark">
            <div class="container-fluid">
                <div class="page-header">
                    <div class="left">
                        <a href="javascript:void(0)" class="icon menu_toggle mr-3"><i class="fa  fa-align-left"></i></a>
                        <h1 class="page-title">Voting Program for Survey</h1>                        
                    </div>
                    <div class="right">
                        <div class="input-icon xs-hide mr-4">
                            <input type="text" class="form-control" placeholder="Search for...">
                            <span class="input-icon-addon"><i class="fe fe-search"></i></span>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
        <div class="section-body mt-3">
            <div class="container-fluid">
            <!----------------------------- form 시작----------------------------->
                <form class="row clearfix" name="frm" method="post" action="pollInsertProc.jsp">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                        <div class="input-group">
                                            <a>Questions</a>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                        <div class="input-group">
                                            <input type="text" class="form-control" name ="tquestion" placeholder="Please enter your question">
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                        <!-- <a href="javascript:void(0);" class="btn btn-primary btn-block" title="" onclick="send()">Write</a> -->
                                  		<input type="button" value="작성하기" onclick="send()"> 
                                    </div>
                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                      <!--   <a href="javascript:void(0);" class="btn btn-primary btn-block" title=""  type="reset">Rewrite</a> -->
                                    	<input type="reset" value="다시쓰기"> 
                                    </div>
                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                        <!-- <a href="javascript:void(0);" class="btn btn-primary btn-block" title="" onClick="javascript:location.href='pollList.jsp'">List</a> -->
                                    	<input type="button" value="리스트" onClick="javascript:location.href='pollList.jsp'">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="table-responsive">
                                <table class="table table-hover table-striped table-vcenter mb-0 text-nowrap">
                                    <thead>
                                        <tr>
                                            <th colspan="2">항목을 선택해주세요</th>
                                            <th colspan="3">옵션을 선택해주세요</th>
                                        </tr>
                                        <tr>
                                            <th class="w30">&nbsp;</th>
                                            <th></th>
                                           	
                                            <th>시작일</th>
                                            <th>종료일</th>
                                            <th>복수투표</th>
                                            <th></th>
                                            
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<%
												for (int i = 1; i <= 8; i++) {
													
													out.println("<td>" + (i)
															+ " : <input name='titem'></td>");
													out.println("</tr>");
													if (i == 9) {
														out.println("");
													} else {
														out.println("<tr>");
													}
												}//for end
											%>
                                        </tr>
                                        <tr>
											<td>시작일</td>
											<td colspan="2"><select name="tsdateY">
													<option value="2020">2020
													<option value="2021">2021
											</select>년 <select name="tsdateM">
													<%
														for (int i = 1; i <= 12; i++) {
															out.println("<option value='" + i + "'>" + i);
														}
													%>
											</select>월 <select name="tsdateD">
													<%
														for (int i = 1; i <= 31; i++) {
															out.println("<option value='" + i + "'>" + i);
														}
													%>
											</select>일</td>
										</tr>
										<tr>
											<td>종료일</td>
											<td colspan=2><select name="tedateY">
													<option value="2020">2020
													<option value="2021">2021
											</select>년 <select name="tedateM">
													<%
														for (int i = 1; i <= 12; i++) {
															out.println("<option value='" + i + "'>" + i);
														}
													%>
											</select>월 <select name="tedateD">
													<%
														for (int i = 1; i <= 31; i++) {
															out.println("<option value='" + i + "'>" + i);
														}
													%>
											</select>일</td>
										</tr>
										<tr>
											<td>복수투표</td>
											<td colspan=2>
												<input type="radio" name="type" value="1" checked>yes 
												<input type="radio" name="type" value="0">no
											</td>
										</tr>
                                    </tbody>  
                                </table>
                            </div>
                        </div>
                    </div>
                   <input type="hidden" name="tsdate">
				   <input type="hidden" name="tedate">
                </form>
                <!---------------------------- form 끝 ---------------------------------->
            </div>
        </div>
    </div>
</div>
<script src="assets/bundles/lib.vendor.bundle.js"></script>
<script src="assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<script src="assets/js/core.js"></script>
</body>
</html>