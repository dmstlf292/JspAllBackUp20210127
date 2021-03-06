<!-- cartProc.jsp : 장바구니 담기, 수정, 삭제 처리 -->
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" scope="session" class="netpidia.CartMgr"/>
<jsp:useBean id="order" class="netpidia.OrderBean"/>
<jsp:setProperty property="*" name="order"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			response.sendRedirect("login.jsp");
			return;
		}
		//누가 주문 했는지 세션에 저장된 id를 order 객체 setter
		order.setId(id);
		String flag = request.getParameter("flag");
		String msg = "";
		if(flag.equals("insert")){
			cMgr.addCart(order);
			msg = "Cart List added";
		}else if(flag.equals("update")){
			cMgr.updateCart(order);
			msg = "Modified Ok";
		}else if(flag.equals("delete")){
			cMgr.deleteCart(order);
			msg = "Delete Ok";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "cartList.jsp";
</script>







