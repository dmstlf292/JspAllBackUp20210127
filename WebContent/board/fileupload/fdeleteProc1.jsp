<!-- fdeleteProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="upload.FileloadMgr"/><!-- ���� mgr�����ϱ� -->
<%
		request.setCharacterEncoding("EUC-KR");
		String snum[]=request.getParameterValues("fch");
		//�Ѿ���°� 0,1,3 ������ �Ѿ���� ���� 1,3 �� �Ѿ���Ƿ� 2���� ũ���� �迭�� ������ָ� ��
		int num[]=new int[snum.length-1];
		for(int i=0; i<num.length;i++){
			//�迭 i�� ���� i�� �ٲ��ֱ�
			num[i]=Integer.parseInt(snum[i+1]);//1 �̶�� �ٰŴ� 0�� ������ 1�̶� 3��!!
		}
		mgr.deleteFile(num);
		response.sendRedirect("flist.jsp");
%>