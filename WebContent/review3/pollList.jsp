<!-- pollList.jsp -->
<%@page import="java.util.Vector"%>
<%@page import="review3.PollListBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="review3.PollMgr"/>
<%request.setCharacterEncoding("EUC-KR");%>

<!doctype html>
<html lang="en" dir="ltr">
<!-- soccer/project/project-ticket.html  07 Jan 2020 03:41:12 GMT -->
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="icon" href="favicon.ico" type="image/x-icon"/>
<title>JSP Poll List</title>

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
                        <h1 class="page-title">Survey List</h1>                        
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
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <jsp:include page="pollForm.jsp"/>
                            </div>
                        </div>
                    </div>
                    <div class="row clearfix">
                    <div class="col-12 col-sm-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">설문조사 리스트 나열</h3>
                                <input type="button" value="결과" 
										onclick="javascript:location.href='pollViewMore.jsp'">
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped text-nowrap table-vcenter mb-0">
                                         <thead>
                                            <tr>
                                                <th>번호</th>
                                                <th>질문</th>
                                                <th>날짜</th>
                                            </tr>
                                        </thead>
                                       	<tbody>
                                       		 <!-- <tr>
                                       			<td>1</td>
                                       			<td>1</td>
                                       			<td>1</td>
                                       			
                                       		</tr>  -->
                                       		<%
												Vector<PollListBean> vlist= mgr.getPollList();
												for(int i=0; i<vlist.size();i++){
													PollListBean plBean = vlist.get(i);
													int tnum = plBean.getTnum();
													String tquestion = plBean.getTquestion();
													String tsdate = plBean.getTsdate();
													String tedate = plBean.getTedate();
											%>
                                       		<tr>
                                                <td><%=vlist.size()-i%></td>
                                                <td><a href="pollList.jsp?tnum=<%=tnum%>"><%=tquestion%></a></td>
                                                <td align="center"><%=tsdate+"~"+tedate%></td>
                                            </tr>
                                       		 <%}//---for%> 
                                       </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <td align="center">
				 <a href="pollInsert.jsp">설문작성하기</a>
				</td>
               
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