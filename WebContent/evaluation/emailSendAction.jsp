<%@page import="javax.mail.Transport"%>

<%@page import="javax.mail.Message"%>

<%@page import="javax.mail.Address"%>

<%@page import="javax.mail.internet.InternetAddress"%>

<%@page import="javax.mail.internet.MimeMessage"%>

<%@page import="javax.mail.Session"%>

<%@page import="javax.mail.Authenticator"%>

<%@page import="java.util.Properties"%>

<%@page import="java.io.PrintWriter"%>

<%@page import="evaluation.UserDAO"%>

<%@page import="evaluation.SHA256"%>

<%@page import="evaluation.Gmail"%>

<%@ page  contentType="text/html; charset=EUC-KR"%>

<%

	UserDAO userDAO = new UserDAO();

	String userID = null;

	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}

	if(userID == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('�α����� ���ּ���.');");

		script.println("location.href = 'userLogin.jsp'");

		script.println("</script>");

		script.close();

		return;

	}

	boolean emailChecked = userDAO.getUserEmailChecked(userID);

	if(emailChecked == true) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('�̹� ���� �� ȸ���Դϴ�.');");

		script.println("location.href = 'index.jsp'");

		script.println("</script>");

		script.close();		

		return;

	}

	

	// ����ڿ��� ���� �޽����� �����մϴ�.

	//String host = "http://localhost:8080/Lecture_Evaluation/";
	String host = "http://localhost/myapp/evaluation/";

	String from = "silviapark292@gmail.com";

	String to = userDAO.getUserEmail(userID);

	String subject = "�����򰡸� ���� �̸��� Ȯ�� �����Դϴ�.";

	String content = "���� ��ũ�� �����Ͽ� �̸��� Ȯ���� �����ϼ���." +

		"<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>�̸��� �����ϱ�</a>";

	

	// SMTP�� �����ϱ� ���� ������ �����մϴ�.

	Properties p = new Properties();

	p.put("mail.smtp.user", from);

	p.put("mail.smtp.host", "smtp.googlemail.com");

	p.put("mail.smtp.port", "465");

	p.put("mail.smtp.starttls.enable", "true");

	p.put("mail.smtp.auth", "true");

	p.put("mail.smtp.debug", "true");

	p.put("mail.smtp.socketFactory.port", "465");

	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

	p.put("mail.smtp.socketFactory.fallback", "false");

	 

	try{

	    Authenticator auth = new Gmail();

	    Session ses = Session.getInstance(p, auth);

	    ses.setDebug(true);

	    MimeMessage msg = new MimeMessage(ses); 

	    msg.setSubject(subject);

	    Address fromAddr = new InternetAddress(from);

	    msg.setFrom(fromAddr);

	    Address toAddr = new InternetAddress(to);

	    msg.addRecipient(Message.RecipientType.TO, toAddr);

	    msg.setContent(content, "text/html;charset=UTF-8");

	    Transport.send(msg);

	} catch(Exception e){

	    e.printStackTrace();

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('������ �߻��߽��ϴ�..');");

		script.println("history.back();");

		script.println("</script>");

		script.close();		

	    return;

	}

%>
<!doctype html>

<html>

  <head>

    <title>������ �� ����Ʈ</title>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- ��Ʈ��Ʈ�� CSS �߰��ϱ� -->

    <link rel="stylesheet" href="./css/bootstrap.min.css">

    <!-- Ŀ���� CSS �߰��ϱ� -->

    <link rel="stylesheet" href="./css/custom.css">

  </head>

  <body>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">

      <a class="navbar-brand" href="index.jsp">������ �� ����Ʈ</a>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">

        <span class="navbar-toggler-icon"></span>

      </button>

      <div class="collapse navbar-collapse" id="navbar">

      
        <ul class="navbar-nav mr-auto">

          <li class="nav-item active">

            <a class="nav-link" href="index.jsp">����</a>

          </li>

          <li class="nav-item dropdown">

            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">

              ȸ�� ����

            </a>

            <div class="dropdown-menu" aria-labelledby="dropdown">
<%

	if(userID == null) {

%>
              <a class="dropdown-item" href="userLogin.jsp">�α���</a>

              <a class="dropdown-item" href="userRegister.jsp">ȸ������</a>
<%

	} else {

%>
              <a class="dropdown-item" href="userLogout.jsp">�α׾ƿ�</a>
<%

	}

%>
            </div>

          </li>

        </ul>

        <form action="index.jsp" method="get" class="form-inline my-2 my-lg-0">

          <input type="text" name="search" class="form-control mr-sm-2" placeholder="������ �Է��ϼ���.">

          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">�˻�</button>

        </form>

      </div>

    </nav>

	<div class="container">

	    <div class="alert alert-warning mt-4" role="alert">

		  �̸��� �ּ� ������ �ϼž� �̿� �����մϴ�. ���� ������ ���� ���ϼ̳���?

		</div>

		<a href="emailSendAction.jsp" class="btn btn-primary">���� ���� �ٽ� �ޱ�</a>

    </div>

    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">

      Copyright �� 2018 ������ All Rights Reserved.

    </footer>

    <!-- �������� �ڹٽ�ũ��Ʈ �߰��ϱ� -->

    <script src="./js/jquery.min.js"></script>

    <!-- Popper �ڹٽ�ũ��Ʈ �߰��ϱ� -->

    <script src="./js/popper.min.js"></script>

    <!-- ��Ʈ��Ʈ�� �ڹٽ�ũ��Ʈ �߰��ϱ� -->

    <script src="./js/bootstrap.min.js"></script>

  </body>

</html>










