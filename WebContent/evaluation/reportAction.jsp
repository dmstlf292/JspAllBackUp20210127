<%@page import="javax.mail.Transport"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="evaluation.Gmail"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%
			request.setCharacterEncoding("EUC-KR");
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
			
		
			
			String reportTitle = null;
			
			String reportContent = null;
			
			if(request.getParameter("reportTitle") != null) {
			
				reportTitle = (String) request.getParameter("reportTitle");
			
			}
			
			if(request.getParameter("reportContent") != null) {
			
				reportContent = (String) request.getParameter("reportContent");
			
			}
			
			if (reportTitle == null || reportContent == null) {
			
				PrintWriter script = response.getWriter();
			
				script.println("<script>");
			
				script.println("alert('�Է��� �� �� ������ �ֽ��ϴ�.');");
			
				script.println("history.back();");
			
				script.println("</script>");
			
				script.close();
			
				return;
			
			}
			
			
			
			// ����ڿ��� ���� �޽����� �����մϴ�.
			
			String host = "http://localhost/myapp/evaluation/";
			
			String from = "qkrdmstlf292@naver.com";
			
			String to = "silviapark292@gmail.com";
			
			String subject = "������ ����Ʈ���� ������ �Ű� �����Դϴ�.";
			
			String content = "�Ű���: " + userID + "<br>����: " + reportTitle + "<br>����: " + reportContent;
			
			
			
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
			
				script.println("alert('������ �߻��߽��ϴ�.');");
			
				script.println("history.back();");
			
				script.println("</script>");
			
				script.close();		
			
			    return;
			
			}
			
			PrintWriter script = response.getWriter();
			
			script.println("<script>");
			
			script.println("alert('���������� �Ű�Ǿ����ϴ�.');");
			
			script.println("history.back();");
			
			script.println("</script>");
			
			script.close();		
			
			return;


%>