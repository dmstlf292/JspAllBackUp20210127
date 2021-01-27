<%@page import="shop.MemberBean"%>
<%@page import="shop.UtilMgr"%>
<%@page import="shop.ProductBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="shop.OrderBean"%>
<%@page import="java.util.Hashtable"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cMgr" scope="session" class="shop.CartMgr"/>
<jsp:useBean id="pMgr" class="shop.ProductMgr"/>
<jsp:useBean id="mMgr" class="shop.MemberMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		if(id==null){
			response.sendRedirect("login.jsp");
			return;
		}
		Hashtable<Integer, OrderBean> hCart = cMgr.getCartList();
		int totalPrice = 0;
		MemberBean bean = mMgr.getMember(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제시스템</title>
<style>
span {
	width: 60px;
	display: inline-block;
}
</style>
</head>
<body>
	<h2>payForm</h2>
	<%
		
		Enumeration<Integer> hCartKey = hCart.keys(); 
		while(hCartKey.hasMoreElements()){
		//키값으로 주문객체를 리턴
		OrderBean order = hCart.get(hCartKey.nextElement());
		//상품번호
		int productNo = order.getProductNo();
		//상품 정보
		ProductBean pbean = pMgr.getProduct(productNo);
		//상품이름
		String pName = pbean.getName();
		//상품가격
		int price = pbean.getPrice();
		//주문수량
		int quantity = order.getQuantity();
		//주문가격
		int subTotal = price * quantity;
		//전체주문가격
		totalPrice+=subTotal;
	%>

	<form action="payProc.jsp" method="post">
		<span>name:</span><input name="name" value="<%=bean.getName()%>"><br> 
		<span>이메일:</span><input name="email" value="<%=bean.getEmail()%>"><br>
		<span>폰넘버:</span><input name="phone" value="<%=bean.getBirthday()%>"><br>
		<span>주소:</span><input name="address" value="<%=bean.getAddress()%>"><br>
		<span>총가격:</span><input name="totalPrice" value="<%=UtilMgr.monFormat(totalPrice)%>"><br> 
		<input type="submit" value="결제하기"> 
		<input type="reset" value="취소하기">
	</form>
		<%}//while %>
</body>
</html>