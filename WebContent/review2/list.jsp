<!-- list.jsp -->
<%@page import="review2.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="review2.UtilMgr"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="review2.BoardMgr" />
<%
	request.setCharacterEncoding("EUC-KR");
	int totalRecord = 0;
	int numPerPage = 10;
	int pagePerBlock = 15;
	int totalPage = 0;
	int totalBlock = 0;
	int nowPage = 1;
	int nowBlock = 1;
	
	//요청된 numPerPage 처리
	if (request.getParameter("numPerPage") != null) {
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}
	//검색에 필요한 변수
	String keyField = "", keyWord = "";
	if (request.getParameter("keyWord") != null) {
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	//검색 후에 다시 처음 리스트 요청
	if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
		keyField = "";
		keyWord = "";
	}
	
	totalRecord = mgr.getTotalCount(keyField, keyWord);
	
	if (request.getParameter("nowPage") != null) {
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	
	//sql문에 들어가는 start, cnt 선언
	int start = (nowPage * numPerPage) - numPerPage;
	int cnt = numPerPage;
	
	//전체페이지 개수
	totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
	//전체블럭 개수
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
	//현재블럭
	nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
%>
<!DOCTYPE html>
<head>
<!-- Basic need -->
<title>Open Pediatrics</title>
<script type="text/javascript">
	function check(){//찾기버튼, form name : searchFrm
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	function list(){//처음으로 버튼, form name : listFrm, 검색후 리스트로 다시 돌아와도 같은 페이지 인것
		document.listFrm.action="list.jsp";
		document.listFrm.submit();
	}
	function numPerFn(numPerPage){//select name="numPerPage", select onchange="numPerFn"
		document.readFrm.numPerPage.value=numPerPage;
		document.readFrm.submit();
	}
	function pageing(page){//a href="javascript:pageing
		document.readFrm.nowPage.value=page;
		document.readFrm.submit();
	}
	function block(block){//a href="javascript:block
		document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	function read(tnum){//a href="javascript:read
		document.readFrm.tnum.value=tnum;
		document.readFrm.action="read.jsp";
		document.readFrm.submit();
	}
</script>
<meta charset="UTF-8">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="author" content="">
<link rel="profile" href="#">

<!--Google Font-->
<link rel="stylesheet"
	href='http://fonts.googleapis.com/css?family=Dosis:400,700,500|Nunito:300,400,600' />
<!-- Mobile specific meta -->
<meta name=viewport content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone-no">

<!-- CSS files -->
<link rel="stylesheet" href="css/plugins.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="page-single movie_list">
		<div class="container">
			<div class="row ipad-width2">
				<div class="col-md-8 col-sm-12 col-xs-12">
					<p>Board Test</p>
					<table>
						<tr>
							<td width="600"></td>
							<td align="right">
								<form>
									<div class="topbar-filter">
										<form name="npFrm" method="post">
											<select name="numPerPage" size="1"
												onchange="numPerFn(this.form.numPerPage.value)">
												<option value="5">5개 보기</option>
												<option value="10" selected>10개 보기</option>
												<option value="15">15개 보기</option>
												<option value="30">30개 보기</option>
											</select>
										</form>
										<script>
											document.npFrm.numPerPage.value =<%=numPerPage%>;
										</script>
									</div>
								</form> <script></script>
							</td>
						</tr>
					</table>
					<div class="topbar-filter">
						<p>
							Total :<%=totalRecord%>Articles (<font> <%=nowPage + "/" + totalPage%>Pages</font>)
						</p>
					</div>
					<!-- -------------------영화 포스터------------------------------------------->
					<div class="movie-item-style-2">
						<img src="images/uploads/mv2.jpg" alt="">
						<!-- <div class="mv-item-infor"> -->
						
						
							<!-- 영화 포스터 옆에 전체 데이블 -->
							<table>
								<!-- 영화 포스터 영역안에서의 전체 테이블 -->
							  <tr>
								<td align="center" colspan="2">
								<%	Vector<BoardBean> vlist = 
									mgr.getBoardList(keyField, keyWord, start, cnt);
									
									int listSize = vlist.size();
									if(vlist.isEmpty()){
										out.println("등록된 게시물이 없습니다.");
									}else{
								%>
										<table cellspacing="0">
											<tr align="center" bgcolor="#D0D0D0">
												<td width="100">번 호</td>
												<td width="250">제 목</td>
												<td width="100">이 름</td>
												<td width="150">날 짜</td>
												<td width="100">조회수</td>
											</tr>	
												<%
													for(int i=0;i<numPerPage/*10*/;i++){
														if(i==listSize) break;
														BoardBean bean = vlist.get(i);
														int tnum = bean.getTnum();//게시물 번호
														String tsubject = bean.getTsubject();//제목
														String tname = bean.getTname();//이름
														String tregdate = bean.getTregdate();//날짜
														int tdepth = bean.getTdepth();//답변의 깊이
														int tcount = bean.getTcount();//조회수
														String tfilename = bean.getTfilename();//첨부파일
												%>
												<tr align="center">
													<td><%=totalRecord-start-i%></td>
													<td align="left">
														<%for(int j=0;j<tdepth;j++){out.println("&nbsp;&nbsp;");}%>
														<a href="javascript:read('<%=tnum%>')"><%=tsubject%></a>
														<%if(tfilename!=null&&!tfilename.equals("")){%>
															<img src="img/icon_file.gif" align="middle">
														<%}%>
													</td>
													<td><%=tname%></td>
													<td><%=tregdate%></td>
													<td><%=tcount%></td>
												</tr>
												<%}//---for%>			
										</table>
									<%}//---if-else%>
									</td>
								</tr>
								<!-- 영화 포스터 영역안에서의 전체 테이블 -->
								<tr>
									<td colspan="2"><br><br></td>
								</tr>
							</table>
							<!-- 영화 포스터 영역안에서의 전체 테이블 끝-->
						</div>
						<tr>
									<td>
										<!-- 페이징 및 블럭 처리하는 부분Start --> 
										<!-- 이전블럭 --> 
										<%if(nowBlock>1){%>
											<a href="javascript:block('<%=nowBlock-1%>')">Prev...</a>
										
										<%} %>
										<!-- 페이징 --> 
										<%
											int pageStart = (nowBlock-1)*pagePerBlock+1;
											int pageEnd = (pageStart+pagePerBlock)<totalPage?
													pageStart+pagePerBlock:totalPage+1;//전체 페이지보다 적으면 ㅇㅇㅇ, 그게 아니면 +1 해라
											for(;pageStart<pageEnd;pageStart++){
										%>
										<a href="javascript:pageing('<%=pageStart%>')">
											<%if(nowPage==pageStart){%><font color="blue"><%}%>
											[<%=pageStart%>]
											<%if(nowPage==pageStart){%></font><%}%><!-- 여기 이해안감..왜 한번 더 한거지..? -->
										</a>
										<%}//--for%>
										<!-- 다음블럭 -->
										<%if(totalBlock>nowBlock){%>
											<a href="javascript:block('<%=nowBlock+1%>')">...Next</a>
										<%}%>
										<!-- 페이징 및 블럭 End -->
									</td>
								</tr>
					<td align="right">
						<a href="post.jsp">[글쓰기]</a> 
						<a href="javascript:list()">[처음으로]</a>
					</td>	
					</div>
					<!-- 영화 포스터 영역 밖 -->
					<form name="searchFrm">
						<table>
					 		<tr>
					  			<td>
					   				<select name="keyField" size="1">
					    				<option value="tname">이 름</option>
					    				<option value="tsubject">제 목</option>
					    				<option value="tcontent">내 용</option>	
					   				</select>
					   				<input size="16" name="keyWord">
					   				<input type="button" value="찾기" onclick="javascript:check()">
					   				<input type = "hidden" name="nowPage" value="1">
					  			</td>
					 		</tr>
						</table>
					</form>
					<form name="listFrm" method="post"><!-- 검색후 리스트 다시 돌아와도 페이지 그대로인것 -->
						<input type="hidden" name="reload" value="true">
						<input type="hidden" name="nowPage" value="1">
					</form>
					
					<form name="readFrm"><!-- 검색한 창 -->
						<input type="hidden" name="nowPage" value="<%=nowPage%>">
						<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
						<input type="hidden" name="keyField" value="<%=keyField%>">
						<input  type="hidden" name="keyWord"value="<%=keyWord%>">
						<input type="hidden" name="tnum">
					</form>
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

