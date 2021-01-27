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
	
	//��û�� numPerPage ó��
	if (request.getParameter("numPerPage") != null) {
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}
	//�˻��� �ʿ��� ����
	String keyField = "", keyWord = "";
	if (request.getParameter("keyWord") != null) {
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	//�˻� �Ŀ� �ٽ� ó�� ����Ʈ ��û
	if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
		keyField = "";
		keyWord = "";
	}
	
	totalRecord = mgr.getTotalCount(keyField, keyWord);
	
	if (request.getParameter("nowPage") != null) {
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	
	//sql���� ���� start, cnt ����
	int start = (nowPage * numPerPage) - numPerPage;
	int cnt = numPerPage;
	
	//��ü������ ����
	totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
	//��ü�� ����
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
	//�����
	nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
%>
<!DOCTYPE html>
<head>
<!-- Basic need -->
<title>Open Pediatrics</title>
<script type="text/javascript">
	function check(){//ã���ư, form name : searchFrm
		if(document.searchFrm.keyWord.value==""){
			alert("�˻�� �Է��ϼ���");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	function list(){//ó������ ��ư, form name : listFrm, �˻��� ����Ʈ�� �ٽ� ���ƿ͵� ���� ������ �ΰ�
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
												<option value="5">5�� ����</option>
												<option value="10" selected>10�� ����</option>
												<option value="15">15�� ����</option>
												<option value="30">30�� ����</option>
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
					<!-- -------------------��ȭ ������------------------------------------------->
					<div class="movie-item-style-2">
						<img src="images/uploads/mv2.jpg" alt="">
						<!-- <div class="mv-item-infor"> -->
						
						
							<!-- ��ȭ ������ ���� ��ü ���̺� -->
							<table>
								<!-- ��ȭ ������ �����ȿ����� ��ü ���̺� -->
							  <tr>
								<td align="center" colspan="2">
								<%	Vector<BoardBean> vlist = 
									mgr.getBoardList(keyField, keyWord, start, cnt);
									
									int listSize = vlist.size();
									if(vlist.isEmpty()){
										out.println("��ϵ� �Խù��� �����ϴ�.");
									}else{
								%>
										<table cellspacing="0">
											<tr align="center" bgcolor="#D0D0D0">
												<td width="100">�� ȣ</td>
												<td width="250">�� ��</td>
												<td width="100">�� ��</td>
												<td width="150">�� ¥</td>
												<td width="100">��ȸ��</td>
											</tr>	
												<%
													for(int i=0;i<numPerPage/*10*/;i++){
														if(i==listSize) break;
														BoardBean bean = vlist.get(i);
														int tnum = bean.getTnum();//�Խù� ��ȣ
														String tsubject = bean.getTsubject();//����
														String tname = bean.getTname();//�̸�
														String tregdate = bean.getTregdate();//��¥
														int tdepth = bean.getTdepth();//�亯�� ����
														int tcount = bean.getTcount();//��ȸ��
														String tfilename = bean.getTfilename();//÷������
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
								<!-- ��ȭ ������ �����ȿ����� ��ü ���̺� -->
								<tr>
									<td colspan="2"><br><br></td>
								</tr>
							</table>
							<!-- ��ȭ ������ �����ȿ����� ��ü ���̺� ��-->
						</div>
						<tr>
									<td>
										<!-- ����¡ �� �� ó���ϴ� �κ�Start --> 
										<!-- ������ --> 
										<%if(nowBlock>1){%>
											<a href="javascript:block('<%=nowBlock-1%>')">Prev...</a>
										
										<%} %>
										<!-- ����¡ --> 
										<%
											int pageStart = (nowBlock-1)*pagePerBlock+1;
											int pageEnd = (pageStart+pagePerBlock)<totalPage?
													pageStart+pagePerBlock:totalPage+1;//��ü ���������� ������ ������, �װ� �ƴϸ� +1 �ض�
											for(;pageStart<pageEnd;pageStart++){
										%>
										<a href="javascript:pageing('<%=pageStart%>')">
											<%if(nowPage==pageStart){%><font color="blue"><%}%>
											[<%=pageStart%>]
											<%if(nowPage==pageStart){%></font><%}%><!-- ���� ���ؾȰ�..�� �ѹ� �� �Ѱ���..? -->
										</a>
										<%}//--for%>
										<!-- ������ -->
										<%if(totalBlock>nowBlock){%>
											<a href="javascript:block('<%=nowBlock+1%>')">...Next</a>
										<%}%>
										<!-- ����¡ �� �� End -->
									</td>
								</tr>
					<td align="right">
						<a href="post.jsp">[�۾���]</a> 
						<a href="javascript:list()">[ó������]</a>
					</td>	
					</div>
					<!-- ��ȭ ������ ���� �� -->
					<form name="searchFrm">
						<table>
					 		<tr>
					  			<td>
					   				<select name="keyField" size="1">
					    				<option value="tname">�� ��</option>
					    				<option value="tsubject">�� ��</option>
					    				<option value="tcontent">�� ��</option>	
					   				</select>
					   				<input size="16" name="keyWord">
					   				<input type="button" value="ã��" onclick="javascript:check()">
					   				<input type = "hidden" name="nowPage" value="1">
					  			</td>
					 		</tr>
						</table>
					</form>
					<form name="listFrm" method="post"><!-- �˻��� ����Ʈ �ٽ� ���ƿ͵� ������ �״���ΰ� -->
						<input type="hidden" name="reload" value="true">
						<input type="hidden" name="nowPage" value="1">
					</form>
					
					<form name="readFrm"><!-- �˻��� â -->
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

