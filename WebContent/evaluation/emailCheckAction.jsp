<%@page import="evaluation.UserDAO"%>
<%@page import="evaluation.SHA256"%>
<%@page import="java.io.PrintWriter"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String code= request.getParameter("code");
		UserDAO userDAO = new UserDAO();
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�α����� ���ּ���.');");
			script.println("location.href='userLogin.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		String userEmail = userDAO.getUserEmail(userID);
		boolean rightCode = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
		if(rightCode ==true){
			userDAO.setUserEmailChecked(userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('���� ����!');");
			script.println("location.href='index.jsp'");
			script.println("</script>");
			script.close();
			return;
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��ȿ���� ���� �ڵ��Դϴ�.');");
			script.println("location.href='index.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		
%>