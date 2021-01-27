<%@page import="evaluation.UserBean"%>
<%@page import="evaluation.UserMgr"%>
<%@page import="java.io.PrintWriter"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="bean" class="evaluation.UserBean"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String userID = null;
		String userPassword=null;
		if(request.getParameter("userID")!=null){
			userID=(String) request.getParameter("userID");
		}
		if(request.getParameter("userPassword")!=null){
			userPassword=(String) request.getParameter("userPassword");
		}
		if(userID ==null || userPassword ==null){
			PrintWriter script= response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
		UserMgr user = new UserMgr();
		//int result = user.join(userID,userPassword);
		int result = user.join(bean);
		if(result==1){
			PrintWriter script= response.getWriter();
			script.println("<script>");
			script.println("alert('가입성공.')");
			script.println("location.href='index.jsp';");
			script.println("</script>");
			script.close();
			return;
		}
		
		
%>