<!-- admin/productProc.jsp -->
<%@page import="shop.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pMgr" class="shop.ProductMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		//insert, update, delete
		String flag = request.getParameter("flag");
		boolean result = false;
		String msg = "���� �߻�";
		
		
		if(flag.equals("insert")){
			result = pMgr.insertProduct(request);
			if(result) msg = "��ǰ ��� �Ϸ�";
		}else if(flag.equals("update")){
			result = pMgr.updateProduct(request);
			if(result) msg = "��ǰ ���� �Ϸ�";
		}else if(flag.equals("delete")){
			result = pMgr.deleteProduct(UtilMgr.parseInt(request, "no"));
			if(result) msg = "��ǰ ���� �Ϸ�";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "productMgr.jsp";
</script>