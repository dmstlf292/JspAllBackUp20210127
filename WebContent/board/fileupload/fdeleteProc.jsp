<!-- fdeleteProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="upload.FileloadMgr"/><!-- 여기 mgr선언하기 -->
<%
		request.setCharacterEncoding("EUC-KR");
		String snum[]=request.getParameterValues("fch");
		//넘어오는값 0,1,3 이지만 넘어오는 값은 1,3 만 넘어오므로 2개의 크기의 배열만 만들어주면 됨
		int num[]=new int[snum.length-1];
		for(int i=0; i<num.length;i++){
			//배열 i를 정수 i로 바꿔주기
			num[i]=Integer.parseInt(snum[i+1]);//1 이라는 근거는 0은 제끼고 1이랑 3만!!
		}
		mgr.deleteFile(num);
		response.sendRedirect("flist.jsp");
%>