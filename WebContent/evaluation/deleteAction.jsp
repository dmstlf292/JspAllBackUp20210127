<%@ page import="evaluation.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="evaluation.LikeyDTO"%>
<%@ page import="java.io.PrintWriter"%>
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
			
		
			
			String evaluationID = null;
			

			
			if(request.getParameter("evaluationID") != null) {
			
				evaluationID = (String) request.getParameter("evaluationID");
			
			}
			
			EvaluationDAO evaluationDAO = new EvaluationDAO();
			if(userID.equals(evaluationDAO.getUserID(evaluationID))){
				int result = new EvaluationDAO().delete(evaluationID);
				if(result ==1){
					PrintWriter script = response.getWriter();
					
					script.println("<script>");
				
					script.println("alert('������ �Ϸ�Ǿ����ϴ�.');");
				
					script.println("location.href='index.jsp'");
				
					script.println("</script>");
				
					script.close();
				
					return;
				}else{
					PrintWriter script = response.getWriter();
					
					script.println("<script>");
				
					script.println("alert('��� ����');");
				
					script.println("history.back();");
				
					script.println("</script>");
				
					script.close();
				
					return;
				}
				
			}
			else {
				PrintWriter script = response.getWriter();
				
				script.println("<script>");
			
				script.println("alert('�ڽ��� �� �۸� ���� ����');");
			
				script.println("history.back();");
			
				script.println("</script>");
			
				script.close();
			
				return;
			}


%>