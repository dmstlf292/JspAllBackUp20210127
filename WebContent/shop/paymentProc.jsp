<%@page import="shop.PaidBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="shop.OrderBean"%>
<%@page import="java.util.Hashtable"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cMgr" scope="session" class="shop.CartMgr"/>
<jsp:useBean id="pMgr" class="shop.ProductMgr"/>
<jsp:useBean id="orderMgr" class="shop.OrderMgr"/>
<jsp:useBean id="paidMgr" class="shop.PaidMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		//apply_num & paid_amount값을 DB에 연동
		int apply_num = Integer.parseInt(request.getParameter("apply_num"));
		int paid_amount = Integer.parseInt(request.getParameter("paid_amount"));
		/* String msg = "카드승인번호 및 승인금액 : "+ apply_num + " : "  + paid_amount; */
		
		
		Hashtable<Integer, OrderBean> hCart = cMgr.getCartList();
		Enumeration<Integer> hCartKey = hCart.keys();
		String msg="";
		if(!hCart.isEmpty()){
			while(hCartKey.hasMoreElements()){
				//장바구니에 카드승인번호 키값으로 객체 리턴
				OrderBean order = hCart.get(hCartKey.nextElement());
				//DB에 카드주문처리
				PaidBean paid = new PaidBean();
				paid.setApply_num(apply_num);
				paid.setPaid_amount(paid_amount);
				paidMgr.insertPaid(paid);
				
			}
			msg = "카드승인번호 및 승인금액 : "+ apply_num + " : "  + paid_amount;
		}else{
			msg="장바구니가 비었습니다.";
		}	
	
%>
<script>
	alert("<%=msg%>");
	location.href="<%=request.getContextPath()%>/shop/orderList.jsp";
</script>

