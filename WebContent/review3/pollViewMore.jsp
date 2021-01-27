<%@page import="java.util.Random"%>
<%@page import="review3.PollItemBean"%>
<%@page import="java.util.Vector"%>
<%@page import="review3.PollListBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>

<!doctype html>
<html lang="en" dir="ltr">
<!-- soccer/project/index.html  07 Jan 2020 03:37:47 GMT -->
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="icon" href="favicon.ico" type="image/x-icon"/>

<title>투표결과모아보기</title>

<!-- Bootstrap Core and vandor -->
<link rel="stylesheet" href="assets/plugins/bootstrap/css/bootstrap.min.css" />
<!-- Plugins css -->
<link rel="stylesheet" href="assets/plugins/charts-c3/c3.min.css"/>
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
        <h5 class="brand-name">selene <a href="javascript:void(0)" class="menu_option float-right"><i class="icon-grid font-16" data-toggle="tooltip" data-placement="left" title="Grid & List Toggle"></i></a></h5>
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
                        <h1 class="page-title">투표결과모아보기</h1>                        
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
                <div class="row clearfix">
                    <div class="col-lg-12">
                        <div class="mb-4">
                            <h4>모든 투표결과 보기</h4>
                        </div>                        
                    </div>
                </div>
                <div class="row clearfix row-deck">
                    <div class="col-xl-4 col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Question : </h3>
                                <!-- <div class="card-options">
                                    <a href="#" class="card-options-collapse" data-toggle="card-collapse"><i class="fe fe-chevron-up"></i></a>
                                    <a href="#" class="card-options-fullscreen" data-toggle="card-fullscreen"><i class="fe fe-maximize"></i></a>
                                    <a href="#" class="card-options-remove" data-toggle="card-remove"><i class="fe fe-x"></i></a>
                                </div> -->
                            </div>
                            <div class="card-body">
                                <div class="row text-center">
                                    <div class="col-4 border-right pb-4 pt-4">
                                        <label class="mb-0 font-13">Total voters</label>
                                        <h4 class="font-30 font-weight-bold text-col-blue counter"><b></b></h4>
                                    </div>  
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-striped table-vcenter mb-0">
                                    <tbody>
	                                    
	                                    <tr>
                                            <td>
                                                
                                                <div class="progress progress-xs">
                                                    
                                                </div>
                                            </td>
                                        </tr> 
	                                  
                                    </tbody>
                                </table>
                            </div>
                             
                        </div>
                    </div>
                </div>
     
<script src="assets/bundles/lib.vendor.bundle.js"></script>
<script src="assets/bundles/apexcharts.bundle.js"></script>
<script src="assets/bundles/counterup.bundle.js"></script>
<script src="assets/bundles/knobjs.bundle.js"></script>
<script src="assets/bundles/c3.bundle.js"></script>
<script src="assets/js/core.js"></script>
<script src="assets/js/page/project-index.js"></script>
</body>
<!-- soccer/project/index.html  07 Jan 2020 03:37:47 GMT -->
</html>
                    