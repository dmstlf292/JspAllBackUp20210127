<!-- admin/productProc.jsp -->
<%@page import="shop.UtilMgr"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pMgr" class="shop.ProductMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		//insert, update, delete
		String flag = request.getParameter("flag");
		boolean result = false;
		String msg = "오류 발생";
		
		
		if(flag.equals("insert")){
			result = pMgr.insertProduct(request);
			if(result) msg = "상품 등록 완료";
		}else if(flag.equals("update")){
			result = pMgr.updateProduct(request);
			if(result) msg = "상품 수정 완료";
		}else if(flag.equals("delete")){
			result = pMgr.deleteProduct(UtilMgr.parseInt(request, "no"));
			if(result) msg = "상품 삭제 완료";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "productMgr.jsp";
</script>