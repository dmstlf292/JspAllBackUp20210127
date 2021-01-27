<%@page import="java.util.Vector"%>
<%@page import="review3.PollListBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="review3.PollMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int tnum=0;
		if(request.getParameter("tnum")!=null){
			tnum=Integer.parseInt(request.getParameter("tnum"));
		}
		PollListBean plBean = mgr.getPoll(tnum);
		Vector<String> vItem = mgr.getItemList(tnum);
		String tquestion = plBean.getTquestion();
		int type=plBean.getType();
		int active=plBean.getActive();
		int sumCount = mgr.sumCount(tnum);
%>
            <!----------------------------- form 시작----------------------------->
                <form action="pollFormProc.jsp">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                        <div class="input-group">
                                            <a>Questions : <%=tquestion%> <font color="blue">(<%=sumCount%>)</font>
                                        </div>
                                    </div>
                                    

                                    <!-- 투표 버튼 -->
                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                        <!-- <a href="javascript:void(0);" class="btn btn-primary btn-block" title="" onclick="send()">Write</a> -->
                                  		<%if(active==1){%>
                                  			<input type="submit" value="투표"> 
                                  		<%}else{%>
                                  			투표종료
                                  		<%}%>
                                    </div>
                                    <!-- 결과 버튼 -->
                                    <div class="col-lg-2 col-md-4 col-sm-6">
                                      <!--   <a href="javascript:void(0);" class="btn btn-primary btn-block" title=""  type="reset">Rewrite</a> -->
                                    	<input type="button" value="결과" 
										onclick="javascript:window.open('pollView.jsp?tnum=<%=tnum%>'
										,'pollView','width=500, height=600')">
										
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
                                            <th colspan="1">항목을 선택해주세요</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <!-- 체크박스 -->
                                        <tr>
	                                        <td>
	                                          <%
	                                          	for(int i=0;i<vItem.size();i++){
	                                          		String titem = vItem.get(i);
	                                          %>	
	                                          <%if(type==1){ %>
	                                          	<input type="checkbox" name="titemnum" value="<%=i%>">
	                                          <%}else if(type==0){%>
	                                          	<input type="radio" name="titemnum" value="<%=i%>">
	                                          <%}%>
	                                          <%=titem%><br>
	                                          <%}%>
	                                        </td>
                                        </tr>
                                    </tbody>  
                                </table>
                            </div>
                        </div>
                    </div>
                   <input type="hidden" name="tnum" value="<%=tnum%>">
                </form>
                <!---------------------------- form 끝 ---------------------------------->
          