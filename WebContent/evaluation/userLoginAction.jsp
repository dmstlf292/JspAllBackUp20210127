<%@page import="evaluation.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%

	request.setCharacterEncoding("UTF-8");

	String userID = null;

	String userPassword = null;

	if(request.getParameter("userID") != null) {

		userID = (String) request.getParameter("userID");

	}

	if(request.getParameter("userPassword") != null) {

		userPassword = (String) request.getParameter("userPassword");

	}

	UserDAO userDAO = new UserDAO();

	int result = userDAO.login(userID, userPassword);

	if (result == 1) {

		session.setAttribute("userID", userID);

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("location.href='index.jsp'");

		script.println("</script>");

		script.close();

	} else if (result == 0) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('��й�ȣ�� Ʋ���ϴ�.');");

		script.println("history.back();");

		script.println("</script>");

		script.close();

	} else if (result == -1) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('�������� �ʴ� ���̵��Դϴ�.');");

		script.println("history.back();");

		script.println("</script>");

		script.close();

	} else if (result == -2) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('�����ͺ��̽� ������ �߻��߽��ϴ�.');");

		script.println("history.back();");

		script.println("</script>");

		script.close();

	}

%>
